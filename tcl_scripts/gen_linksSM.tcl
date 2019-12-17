
package require json

# open file
set fileName "/home/ahoward/DCTesting/SerenityDCtest/tcl_scripts/ku15pSM_so_config_jtag.json"
set fin [open $fileName r]
#file copy -force $fileName "./currentConfiguration.json"
set dataRaw [read $fin]

set data [ ::json::json2dict $dataRaw ]

set baseBoard   [ dict get $data BaseBoard ]
set DCs         [ dict get $data DCs ]
set pathBaseGTY [ dict get $data pathBaseGTY ]
set pathBaseGTH [ dict get $data pathBaseGTH ] 

##### generate
dict for { siteId DC } $DCs {

    set DCid [ dict get $DC id ]

    if { [string compare -nocase $DCid "none"] != 0 } {
 
        puts "DC $DCid on site: $siteId"

        set connections [ dict get $DC connections ]
        set pathBaseGTY [ dict get [ dict get $data pathBaseGTY ] DC$siteId ]
        set pathBaseGTH [ dict get [ dict get $data pathBaseGTH ] DC$siteId ]
        
        dict for {cId connection} $connections {
            
            set txId           [ dict get $connection Tx ]
            set rxId           [ dict get $connection Rx ]
            set connectionType [ dict get $connection type ]

	    puts $txId
	    puts $rxId
	    puts $connectionType
	    puts $connection
            
            set txList [ dict get [ dict get $data tx$txId ] MGTs ]
            set rxTmpL [ dict get [ dict get $data rx$rxId ] MGTs ]
            
            set rxList []
            if { $connectionType == "Cu4plus4" } {

                for {set i 11} {$i > -1} {incr i -2} { 
		    set j [expr $i-1]
                    dict set rxList $i [dict get $rxTmpL $j] 
                    dict set rxList $j [dict get $rxTmpL $i] 
                }
                
                
            } else {
                
                for {set i 11} {$i > -1} {incr i -1} { 
                    dict set rxList $i [dict get $rxTmpL $i] 
                }
                
            } 
            
            set xil_newLinks [ list ]
            set i 0
	    set reverseRx 0
            
            foreach {rxMGTid rx} $rxList {txMGTid tx} $txList {
                
                # get the MGTs path and type
                set rxMGT [ dict get $rx MGT ]
                set txMGT [ dict get $tx MGT ]
                set rxMGTtype [ dict get $rx type ]
                set txMGTtype [ dict get $tx type ]
                set rxPath []
                set txPath []

		if { [string compare -nocase $rxMGT "none"] == 0 || [string compare -nocase $txMGT "none"] == 0 } {
		    set reverseRx 1
		}
		if { [string compare -nocase $rxMGT "none"] != 0 && [string compare -nocase $txMGT "none"] != 0 } {
		    puts $rxMGT
		    puts $txMGT
		    if { $rxMGTtype == "GTY" } {
			set rxPath [ dict get [ dict get $data pathBaseGTY ] DC$siteId ]
		    } else {
			set rxPath [ dict get [ dict get $data pathBaseGTH ] DC$siteId ]
		    }
		    
		    if { $txMGTtype == "GTY" } {
			set txPath [ dict get [ dict get $data pathBaseGTY ] DC$siteId ]
		    } else {
			set txPath [ dict get [ dict get $data pathBaseGTH ] DC$siteId ]
		    }
		    
		    set description "Link tx$txMGTid rx$rxMGTid"
		    set rxPath "$rxPath/$rxMGT"
		    set txPath "$txPath/$txMGT"
		    puts "----------------------------------"
		    puts $txPath
		    puts $rxPath
		    puts $txMGT
		    puts $rxMGT

		    if { $reverseRx == 0 && $connectionType == "Cu4plus4" } { 
			set xil_newLink [create_hw_sio_link -description $description [lindex [get_hw_sio_txs $rxPath] 0] [lindex [get_hw_sio_rxs $txPath] 0] ]
		    } else {
			set xil_newLink [create_hw_sio_link -description $description [lindex [get_hw_sio_txs $txPath] 0] [lindex [get_hw_sio_rxs $rxPath] 0] ]
		    }
		    lappend xil_newLinks $xil_newLink
		    
		}

	    }
            
            set groupDescription "$baseBoard\_site$siteId\_DC$DCid\_$connectionType:Tx$txId-Rx$rxId"
            puts $groupDescription
            set xil_newLinkGroup [create_hw_sio_linkgroup -description $groupDescription [get_hw_sio_links $xil_newLinks]]
            unset xil_newLinks
            
    }
    } else {
        puts "No DC on site: $siteId"
        
    }
    
}

### setup links
set links [get_hw_sio_links]

foreach link $links {

    # DFE off
    #set_property RXDFEENABLED {0} [get_hw_sio_links $link]
    #set_property TXDFEENABLED {0} [get_hw_sio_links $link]
    
    # PRBS set to 31 bits
    set_property TX_PATTERN {PRBS 31-bit} [get_hw_sio_links $link]
    set_property RX_PATTERN {PRBS 31-bit} [get_hw_sio_links $link]

    # set polarity only if status is NO LINK
    set linkStatus [ get_property STATUS [get_hw_sio_links $link] ]
    if { $linkStatus == "NO LINK" } {
        set_property PORT.RXPOLARITY {1} [get_hw_sio_links $link]
        commit_hw_sio [get_hw_sio_links $link]
    }

    # rx reset
    set_property LOGIC.RX_RESET_DATAPATH 1 [get_hw_sio_links $link]
    commit_hw_sio [get_hw_sio_links $link]
    set_property LOGIC.RX_RESET_DATAPATH 0 [get_hw_sio_links $link]
    commit_hw_sio [get_hw_sio_links $link]
    
    # reset counters
    set_property LOGIC.MGT_ERRCNT_RESET_CTRL 1 [get_hw_sio_links $link]
    commit_hw_sio [get_hw_sio_links $link]
    set_property LOGIC.MGT_ERRCNT_RESET_CTRL 0 [get_hw_sio_links $link]
    commit_hw_sio [get_hw_sio_links $link]

}




