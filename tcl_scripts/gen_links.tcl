### ### ### ### ###
###################
### ### ### ### ###

# DAQ -> socket0 only form serenity v1.2
# Tx0 -> socket1
# Rx0 -> socket2
# Tx1 -> socket3
# Rx1 -> socket4
# Tx2 -> socket5
# Rx2 -> socket6
# Tx3 -> socket7
# Rx3 -> socket8
# Tx4 -> socket9
# Rx4 -> socket10
# Tx5 -> socket11
# Rx5 -> socket12
# ext -> socket13 only from serenity v1.2

### ### ### ### ###
###################
### ### ### ### ###

package require json

# GTY and GTH "numbering"

set MGTtypeId [ dict create GTH "_1_0_0/IBERT" GTY "_1_0_55/IBERT" ]

# open files
set tclBase  "/home/hwtest/vpalladi/SerenityDCtest/tcl_scripts"

set configFileName "$tclBase/config.json"
set ku15p_sm1_v1_fileName "$tclBase/ku15p_sm1_v1_connectivity.json"
set ku15p_so1_v1_fileName "$tclBase/ku15p_so1_v1_connectivity.json"

set configFileIn [open $configFileName r]
set connectivity [dict create \
                      sm1_v1 [ ::json::json2dict [read [open $ku15p_sm1_v1_fileName r] ] ] \
                      so1_v1 [ ::json::json2dict [read [open $ku15p_so1_v1_fileName r] ] ] \
                      # ----->>>>> add here any configuration: e.g. VU9P and sm1_v2
                 ]

# get data 
set configRaw [read $configFileIn]

set config [ ::json::json2dict $configRaw ]

set baseBoard   [ dict get $config BaseBoard ]
set DCs         [ dict get $config DCs ]

set JTAG        [ dict get $config JTAG ]
set JTAGid      [ dict get $JTAG JTAGid ]
set host        [ dict get $JTAG host ]

set pathBase "$host/xilinx_tcf/$JTAGid"

set connections [ dict get $config connections ]


##### generate

dict for { id c } $connections {
    
    set connectionType [ dict get $c connectionType ]

    set siteA         [ dict get [ dict get $c sideA ] site ]
    set connectorA    [ dict get [ dict get $c sideA ] connector ]
    set daughterCardA [ dict get $DCs $siteA ]
    set socketA       [ dict get [dict get $connectivity [dict get $daughterCardA type] ] $connectorA] 
    
    set siteB         [ dict get [ dict get $c sideB ] site ]
    set connectorB    [ dict get [ dict get $c sideB ] connector ]
    set daughterCardB [ dict get $DCs $siteB ]
    set socketBtmp    [ dict get [dict get $connectivity [dict get $daughterCardB type] ] $connectorB] 
    
    ## invert lines on the fiber/bundle if needed
    set socketB []
    set nConnections [dict size $socketBtmp]
    if { $connectionType == "Cu8" || $connectionType == "Cu12" } {
        
        for {set i [expr $nConnections-1]} {$i > -1} {incr i -1} { 
            dict set socketB $i [dict get $socketBtmp $i] 
        }

    } else {
        
        for {set i 0} {$i < $nConnections} {incr i} { 
            dict set socketB $i [dict get $socketBtmp $i] 
        }
        
    } 

    ## generate the links
    foreach {MGTidA A} $socketA {MGTidB B} $socketB {
        
        # get the MGTs path and type
        set MGTa     [ dict get $A MGT ]
        set MGTaType [ dict get $A type ]
        set MGTb     [ dict get $B MGT ]
        set MGTbType [ dict get $B type ]

        if { $MGTa == "none" || $MGTb == "none" } {
            continue
        }

        # RX vars
        set rxMGT []
        set rxMGTtype []
        set rxSite []
        # TX vars
        set txMGT []
        set txMGTtype []
        set txSite []
        
        if { [ string first "RX" $MGTa ] != -1 && [ string first "TX" $MGTb ] != -1 } {
            # A is RX
            set rxMGT $MGTa
            set rxMGTtype $MGTaType
            set rxSite [ string map {"X" ""} $siteA ]
            # B is TX
            set txMGT $MGTb
            set txMGTtype $MGTbType
            set txSite [ string map {"X" ""} $siteB]
        } elseif { [ string first "TX" $MGTa ] != -1 && [ string first "RX" $MGTb ] != -1 } {
            # B is RX
            set rxMGT $MGTb
            set rxMGTtype $MGTbType
            set rxSite [ string map {"X" ""} $siteB ] 
            # A is TX
            set txMGT $MGTa
            set txMGTtype $MGTaType
            set txSite [ string map {"X" ""} $siteA ] 
        } else {
            puts "Wrong assignment!!! Check your configuration file. Two RX or two TX are matched."
            puts "Site $siteA $MGTa"
            puts "Site $siteB $MGTb"
            return -1
        }
        
        set rxMGTid [dict get $MGTtypeId $rxMGTtype ]
        set txMGTid [dict get $MGTtypeId $txMGTtype ]

        set txPath "$pathBase/$txSite$txMGTid/$txMGT"
        set rxPath "$pathBase/$rxSite$rxMGTid/$rxMGT"

        set description "Link X$txSite-$txMGT -> X$rxSite-$rxMGT"
        puts $description
        
        # generate the link
        set xil_newLink [create_hw_sio_link -description $description [lindex [get_hw_sio_txs $txPath] 0] [lindex [get_hw_sio_rxs $rxPath] 0] ]
        lappend xil_newLinks $xil_newLink
        
    }

    # group links
    set groupDescription "$baseBoard\_$connectionType:$siteA\_$connectorA-$siteB\_$connectorB"
    puts $groupDescription
    set xil_newLinkGroup [create_hw_sio_linkgroup -description $groupDescription [get_hw_sio_links $xil_newLinks]]
    unset xil_newLinks
    
    
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




