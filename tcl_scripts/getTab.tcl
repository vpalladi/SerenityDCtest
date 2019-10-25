package require csv

### get links 
set links [get_hw_sio_links]

set groups [get_hw_sio_linkgroups]

### create csv file 
set outfile [open "IBERTresults.csv" w]

### start loop
foreach group $groups {

    set groupName [get_property DESCRIPTION $group]
    set subFolder [ lindex [split $groupName ":"] 0 ]
    set links [get_hw_sio_links -of_objects [get_hw_sio_linkgroups $group]]

    foreach link $links {

        # from link name define scan name
        set linkName [get_property DESCRIPTION $link]
        set scanName "Scan $groupName $linkName"
	
        # get all qplls and their status
	set QPLLs [ get_hw_sio_plls -of_objects [ get_hw_sio_commons -of_objects [ get_hw_sio_gtgroup -of_objects [ get_hw_sio_gts -of_objects [get_hw_sio_links $link] ] ] ] ]

	set PLL0status [get_property STATUS [lindex $QPLLs 0] ]
	set PLL1status [get_property STATUS [lindex $QPLLs 1] ]
	
        # do not scan if pll is not locked, report it instead
	if { $PLL0status == "NOT LOCKED"  } {
	    puts "WARNING wrong PLL status ($scanName): PLL0 is $PLL0status, PLL1 is $PLL1status"
	} else {
            puts $outfile [csv::join [list [ get_property RX_BER $link ] [ get_property RX_BER $link ] ] ]
	} 
	
    }

}

### close out file
close $outfile





