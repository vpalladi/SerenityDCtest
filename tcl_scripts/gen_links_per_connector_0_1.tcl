
package require json

# open file 
set fileName "/home/hwtest/vpalladi/tools/tcl_scripts/config.json"
set fin [open $fileName r]
file copy -force $fileName "./currentConfiguration.json"
set dataRaw [read $fin]

set data [ ::json::json2dict $dataRaw ]

set DCs         [ dict get $data DCs ]
set pathBaseGTY [ dict get $data pathBaseGTY ]
set pathBaseGTH [ dict get $data pathBaseGTH ] 

##### generate
dict for {dcId DC} $DCs {

    set connections [ dict get $DC connections ]
    set pathBaseGTY [ dict get [ dict get $data pathBaseGTY ] DC$dcId ]
    set pathBaseGTH [ dict get [ dict get $data pathBaseGTH ] DC$dcId ]

    dict for {cId connection} $connections {

        set txId           [ dict get $connection Tx ]
        set rxId           [ dict get $connection Rx ]
        set connectionType [ dict get $connection type ]

        set txList [ dict get [ dict get $data tx$txId ] MGTs ]
        set rxList [ dict get [ dict get $data rx$rxId ] MGTs ]
        
        if { $connectionType == "fiber" } {
            set rxList [ lreverse $rxList ]
        }
        
        set xil_newLinks [ list ]
        set i 0
        
        foreach {rxId rx} $rxList {txId tx} $txList {

            set rxMGT [ dict get $rx MGT ]
            set txMGT [ dict get $rx MGT ]
            set rxMGTtype [ dict get $rx type ]
            set txMGTtype [ dict get $rx type ]
            set rxPath []
            set txPath []
            if { $rxMGTtype == "GTY" } {
                set rxPath [ dict get [ dict get $data pathBaseGTY ] DC$dcId ]
            } else {
                set rxPath [ dict get [ dict get $data pathBaseGTH ] DC$dcId ]
            }
            
            if { $txMGTtype == "GTY" } {
                set txPath [ dict get [ dict get $data pathBaseGTY ] DC$dcId ]
            } else {
                set txPath [ dict get [ dict get $data pathBaseGTH ] DC$dcId ]
            }
            
            set description "Link_$dcId rx$rxId tx$txId"
            set rxPath "RX     $rxPath/$rxMGT"
            set txPath "TX     $txPath/$txMGT"
            
            set xil_newLink [create_hw_sio_link -description $description [lindex [get_hw_sio_txs $txPath] 0] [lindex [get_hw_sio_rxs $rxPath] 0] ]
            lappend xil_newLinks $xil_newLink

        }

        set groupDescription "DC$dcId:Tx$txId-Rx$rxId"
        set xil_newLinkGroup [create_hw_sio_linkgroup -description $groupDescription [get_hw_sio_links $xil_newLinks]]
        unset xil_newLinks

    }

}
