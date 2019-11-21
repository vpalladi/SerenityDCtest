
# which precision
set dwell_ber 1e-5

# proc for json file creation
proc writeJSON {fileOut obj} {

    dict for {key val} $obj {
        puts $val
        puts [dict keys $val]
        if { [ llength $val ] > 0 } {
            writeJSON $fileOut $val
        } else {
         return
        }

    } 
    
}

# remove the current scans if any
remove_hw_sio_scan [get_hw_sio_scans {}]

# get the system time to name the directory
set systemTime [clock seconds]
 
set folderName [clock format $systemTime -format %Y%m%d%H%M%S]
set foldername "/home/hwtest/vpalladi/$folderName" 

# generate the folders 
exec mkdir -p -- $folderName
exec mkdir -p -- $folderName/site0
exec mkdir -p -- $folderName/site1

# open the out file to store the configuration 
set fout [open ./config.json w]
puts $fout "{"

### get links 
set links [ get_hw_sio_links ]

set groups [ get_hw_sio_linkgroups ]

set config [ dict create ]

# start loop
set i 0
foreach group $groups {

    set groupName [get_property DESCRIPTION $group]
    set tmp [ lindex [split $groupName ":"] 0 ]
    set baseBoard [ lindex [ split $tmp "_" ] 0 ]
    set site [ lindex [ split $tmp "_" ] 1 ]
    set DC [ lindex [ split $tmp "_" ] 2 ]
    set links [get_hw_sio_links -of_objects [get_hw_sio_linkgroups $group]]
    
    foreach link $links {

        # from link name define scan name
        set linkName [get_property DESCRIPTION $link]
        set scanName "Scan $groupName $linkName"
	
        # get all qplls and their status
	set QPLLs [ get_hw_sio_plls -of_objects [ get_hw_sio_commons -of_objects [ get_hw_sio_gtgroup -of_objects [ get_hw_sio_gts -of_objects [get_hw_sio_links $link] ] ] ] ]

	set PLL0status [get_property STATUS [lindex $QPLLs 0] ]
	set PLL1status [get_property STATUS [lindex $QPLLs 1] ]

        set txEndpoint [ get_property TX_ENDPOINT $link ]
        set tx [ get_property TX_ENDPOINT $link ]
        set rxEndpoint [ get_property RX_ENDPOINT $link ]
        
	
        # do not scan if pll is not locked, report it instead
	if { $PLL0status == "NOT LOCKED"  } {
	    puts "WARNING wrong PLL status ($scanName): PLL0 is $PLL0status, PLL1 is $PLL1status"
	} else {
	    set xil_newScan [create_hw_sio_scan -description $scanName  1d_bathtub  [lindex [get_hw_sio_links $link] ] ]
	    set_property HORIZONTAL_INCREMENT {1} [get_hw_sio_scans $xil_newScan]
	    set_property DWELL_BER $dwell_ber [get_hw_sio_scans $xil_newScan]

	    # run the scan! :) 
	    run_hw_sio_scan [get_hw_sio_scans $xil_newScan]
	    wait_on_hw_sio_scan [get_hw_sio_scans $xil_newScan]
        
	    # save the scan! :D
	    write_hw_sio_scan -force "$folderName/$site/$scanName" [get_hw_sio_scans $xil_newScan]

        }

        set status      [ get_property STATUS          $link ]
        set tx_pattern  [ get_property TX_PATTERN      $link ]
        set rx_pattern  [ get_property RX_PATTERN      $link ]
        set tx_polarity [ get_property PORT.TXPOLARITY $link ]
        set rx_polarity [ get_property PORT.RXPOLARITY $link ]
        set DFE_enabled [ get_property RXDFEENABLED    $link ]

        if { $i > 0 } {
            puts $fout "\},"
        }
        puts $fout "\"$scanName\" : \{"
        
        puts $fout "\"baseBoard\" : \"$baseBoard\","
        puts $fout "\"site\" : \"$site\","
        puts $fout "\"DC\" : \"$DC\","
        puts $fout "\"status\" : \"$status\", "
        puts $fout "\"DFE\" : \"$DFE_enabled\", "
        puts $fout "\"tx\" : \"$txEndpoint\"," 
        puts $fout "\"txPolarity\" : \"$tx_polarity\", "
        puts $fout "\"txPattern\" : \"$tx_pattern\", "
        puts $fout "\"rx\" : \"$rxEndpoint\", "
        puts $fout "\"rxPolarity\" : \"$rx_polarity\", "
        puts $fout "\"rxPattern\" : \"$rx_pattern\" "

        incr i
	
    }

}
puts $fout "\}"
puts $fout "\}"
close $fout

exec mv ./config.json $folderName
