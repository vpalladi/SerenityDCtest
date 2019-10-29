

### define the IBERT paths
#set pathBaseGTY "pcuptracker001:3121/xilinx_tcf/Xilinx/128.141.223.225:5006/0_1_0_50/IBERT"
#set pathBaseGTH "pcuptracker001:3121/xilinx_tcf/Xilinx/128.141.223.225:5006/0_1_0_0/IBERT"

set pathBaseGTY "localhost:3121/xilinx_tcf/Digilent/210249A847C3/0_1_0_50/IBERT"
set pathBaseGTH "localhost:3121/xilinx_tcf/Digilent/210249A847C3/0_1_0_0/IBERT"

### tx and rx objects ( KU15P SO1 )
set tx0 [ list \
              "$pathBaseGTY/Quad_134/MGT_X0Y30/TX"\
              "$pathBaseGTY/Quad_132/MGT_X0Y23/TX"\
              "$pathBaseGTY/Quad_134/MGT_X0Y29/TX"\
              "$pathBaseGTY/Quad_134/MGT_X0Y31/TX"\
              "$pathBaseGTY/Quad_134/MGT_X0Y28/TX"\
              "$pathBaseGTY/Quad_133/MGT_X0Y27/TX"\
              "$pathBaseGTY/Quad_132/MGT_X0Y20/TX"\
              "$pathBaseGTY/Quad_133/MGT_X0Y25/TX"\
              "$pathBaseGTY/Quad_133/MGT_X0Y26/TX"\
              "$pathBaseGTY/Quad_132/MGT_X0Y21/TX"\
              "$pathBaseGTY/Quad_132/MGT_X0Y22/TX"\
              "$pathBaseGTY/Quad_133/MGT_X0Y24/TX"\
              ]

set rx0 [ list \
              "$pathBaseGTY/Quad_132/MGT_X0Y22/RX" \
              "$pathBaseGTY/Quad_132/MGT_X0Y21/RX" \
              "$pathBaseGTY/Quad_132/MGT_X0Y20/RX" \
              "$pathBaseGTY/Quad_134/MGT_X0Y29/RX" \
              "$pathBaseGTY/Quad_132/MGT_X0Y23/RX" \
              "$pathBaseGTY/Quad_133/MGT_X0Y24/RX" \
              "$pathBaseGTY/Quad_133/MGT_X0Y26/RX" \
              "$pathBaseGTY/Quad_134/MGT_X0Y30/RX" \
              "$pathBaseGTY/Quad_133/MGT_X0Y25/RX" \
              "$pathBaseGTY/Quad_134/MGT_X0Y28/RX" \
              "$pathBaseGTY/Quad_134/MGT_X0Y31/RX" \
              "$pathBaseGTY/Quad_133/MGT_X0Y27/RX" \
             ]

set tx1 [ list \
              "$pathBaseGTY/Quad_131/MGT_X0Y17/TX" \
              "$pathBaseGTY/Quad_130/MGT_X0Y14/TX" \
              "$pathBaseGTY/Quad_131/MGT_X0Y18/TX" \
              "$pathBaseGTY/Quad_131/MGT_X0Y19/TX" \
              "$pathBaseGTY/Quad_130/MGT_X0Y15/TX" \
              "$pathBaseGTY/Quad_131/MGT_X0Y16/TX" \
              "$pathBaseGTY/Quad_129/MGT_X0Y10/TX" \
              "$pathBaseGTY/Quad_129/MGT_X0Y11/TX" \
              "$pathBaseGTY/Quad_130/MGT_X0Y13/TX" \
              "$pathBaseGTY/Quad_129/MGT_X0Y8/TX"  \
              "$pathBaseGTY/Quad_129/MGT_X0Y9/TX"  \
              "$pathBaseGTY/Quad_130/MGT_X0Y12/TX" \
              ]

set rx1 [ list \
              "$pathBaseGTY/Quad_129/MGT_X0Y9/RX" \
              "$pathBaseGTY/Quad_130/MGT_X0Y13/RX" \
              "$pathBaseGTY/Quad_129/MGT_X0Y8/RX" \
              "$pathBaseGTY/Quad_129/MGT_X0Y11/RX" \
              "$pathBaseGTY/Quad_131/MGT_X0Y16/RX" \
              "$pathBaseGTY/Quad_131/MGT_X0Y18/RX" \
              "$pathBaseGTY/Quad_129/MGT_X0Y10/RX" \
              "$pathBaseGTY/Quad_131/MGT_X0Y19/RX" \
              "$pathBaseGTY/Quad_131/MGT_X0Y17/RX" \
              "$pathBaseGTY/Quad_130/MGT_X0Y12/RX" \
              "$pathBaseGTY/Quad_130/MGT_X0Y14/RX" \
              "$pathBaseGTY/Quad_130/MGT_X0Y15/RX" \
              ]

set tx2 [ list \
              "$pathBaseGTY/Quad_128/MGT_X0Y6/TX" \
              "$pathBaseGTY/Quad_128/MGT_X0Y7/TX" \
              "$pathBaseGTY/Quad_127/MGT_X0Y0/TX" \
              "$pathBaseGTY/Quad_128/MGT_X0Y5/TX" \
              "$pathBaseGTY/Quad_127/MGT_X0Y3/TX" \
              "$pathBaseGTH/Quad_225/MGT_X0Y7/TX" \
              "$pathBaseGTY/Quad_127/MGT_X0Y1/TX" \
              "$pathBaseGTY/Quad_127/MGT_X0Y2/TX" \
              "$pathBaseGTH/Quad_225/MGT_X0Y6/TX" \
              "$pathBaseGTY/Quad_128/MGT_X0Y4/TX" \
              "$pathBaseGTH/Quad_225/MGT_X0Y4/TX" \
              "$pathBaseGTH/Quad_225/MGT_X0Y5/TX" \
              ]

set rx2 [ list \
              "$pathBaseGTH/Quad_225/MGT_X0Y6/RX" \
              "$pathBaseGTH/Quad_225/MGT_X0Y5/RX" \
              "$pathBaseGTH/Quad_225/MGT_X0Y4/RX" \
              "$pathBaseGTH/Quad_225/MGT_X0Y7/RX" \
              "$pathBaseGTY/Quad_128/MGT_X0Y5/RX" \
              "$pathBaseGTY/Quad_128/MGT_X0Y6/RX" \
              "$pathBaseGTY/Quad_127/MGT_X0Y1/RX" \
              "$pathBaseGTY/Quad_127/MGT_X0Y2/RX" \
              "$pathBaseGTY/Quad_128/MGT_X0Y7/RX" \
              "$pathBaseGTY/Quad_127/MGT_X0Y0/RX" \
              "$pathBaseGTY/Quad_127/MGT_X0Y3/RX" \
              "$pathBaseGTY/Quad_128/MGT_X0Y4/RX" \
              ]

set tx3 [ list \
              "$pathBaseGTH/Quad_227/MGT_X0Y15/TX" \
              "$pathBaseGTH/Quad_227/MGT_X0Y13/TX" \
              "$pathBaseGTH/Quad_226/MGT_X0Y8/TX" \
              "$pathBaseGTH/Quad_228/MGT_X0Y17/TX" \
              "$pathBaseGTH/Quad_226/MGT_X0Y10/TX" \
              "$pathBaseGTH/Quad_226/MGT_X0Y11/TX" \
              "$pathBaseGTH/Quad_228/MGT_X0Y19/TX" \
              "$pathBaseGTH/Quad_227/MGT_X0Y14/TX" \
              "$pathBaseGTH/Quad_227/MGT_X0Y12/TX" \
              "$pathBaseGTH/Quad_228/MGT_X0Y18/TX" \
              "$pathBaseGTH/Quad_228/MGT_X0Y16/TX" \
              "$pathBaseGTH/Quad_226/MGT_X0Y9/TX" \
              ]

set rx3 [ list \
              "$pathBaseGTH/Quad_227/MGT_X0Y14/RX" \
              "$pathBaseGTH/Quad_227/MGT_X0Y12/RX" \
              "$pathBaseGTH/Quad_228/MGT_X0Y17/RX" \
              "$pathBaseGTH/Quad_227/MGT_X0Y13/RX" \
              "$pathBaseGTH/Quad_227/MGT_X0Y15/RX" \
              "$pathBaseGTH/Quad_228/MGT_X0Y19/RX" \
              "$pathBaseGTH/Quad_226/MGT_X0Y11/RX" \
              "$pathBaseGTH/Quad_226/MGT_X0Y10/RX" \
              "$pathBaseGTH/Quad_228/MGT_X0Y18/RX" \
              "$pathBaseGTH/Quad_226/MGT_X0Y9/RX" \
              "$pathBaseGTH/Quad_226/MGT_X0Y8/RX" \
              "$pathBaseGTH/Quad_228/MGT_X0Y16/RX" \
             ]

set tx4 [ list \
              "$pathBaseGTH/Quad_229/MGT_X0Y23/TX" \
              "$pathBaseGTH/Quad_229/MGT_X0Y20/TX" \
              "$pathBaseGTH/Quad_229/MGT_X0Y22/TX" \
              "$pathBaseGTH/Quad_231/MGT_X0Y30/TX" \
              "$pathBaseGTH/Quad_231/MGT_X0Y28/TX" \
              "$pathBaseGTH/Quad_230/MGT_X0Y24/TX" \
              "$pathBaseGTH/Quad_230/MGT_X0Y25/TX" \
              "$pathBaseGTH/Quad_230/MGT_X0Y27/TX" \
              "$pathBaseGTH/Quad_230/MGT_X0Y26/TX" \
              "$pathBaseGTH/Quad_231/MGT_X0Y31/TX" \
              "$pathBaseGTH/Quad_231/MGT_X0Y29/TX" \
              "$pathBaseGTH/Quad_229/MGT_X0Y21/TX" \
             ]

set rx4 [ list \
              "$pathBaseGTH/Quad_231/MGT_X0Y29/RX" \
              "$pathBaseGTH/Quad_231/MGT_X0Y30/RX" \
              "$pathBaseGTH/Quad_231/MGT_X0Y31/RX" \
              "$pathBaseGTH/Quad_230/MGT_X0Y27/RX" \
              "$pathBaseGTH/Quad_231/MGT_X0Y28/RX" \
              "$pathBaseGTH/Quad_230/MGT_X0Y26/RX" \
              "$pathBaseGTH/Quad_229/MGT_X0Y23/RX" \
              "$pathBaseGTH/Quad_230/MGT_X0Y24/RX" \
              "$pathBaseGTH/Quad_230/MGT_X0Y25/RX" \
              "$pathBaseGTH/Quad_229/MGT_X0Y22/RX" \
              "$pathBaseGTH/Quad_229/MGT_X0Y21/RX" \
              "$pathBaseGTH/Quad_229/MGT_X0Y20/RX" \
              ]

set tx5 [ list \
              "$pathBaseGTH/Quad_233/MGT_X0Y36/TX" \
              "$pathBaseGTH/Quad_232/MGT_X0Y33/TX" \
              "$pathBaseGTH/Quad_232/MGT_X0Y32/TX" \
              "$pathBaseGTH/Quad_233/MGT_X0Y39/TX" \
              "$pathBaseGTH/Quad_232/MGT_X0Y34/TX" \
              "$pathBaseGTH/Quad_232/MGT_X0Y35/TX" \
              "$pathBaseGTH/Quad_234/MGT_X0Y43/TX" \
              "$pathBaseGTH/Quad_233/MGT_X0Y37/TX" \
              "$pathBaseGTH/Quad_233/MGT_X0Y38/TX" \
              "$pathBaseGTH/Quad_234/MGT_X0Y42/TX" \
              "$pathBaseGTH/Quad_234/MGT_X0Y40/TX" \
              "$pathBaseGTH/Quad_234/MGT_X0Y41/TX" \
              ]

set rx5 [ list \
              "$pathBaseGTH/Quad_234/MGT_X0Y43/RX" \
              "$pathBaseGTH/Quad_234/MGT_X0Y42/RX" \
              "$pathBaseGTH/Quad_234/MGT_X0Y41/RX" \
              "$pathBaseGTH/Quad_233/MGT_X0Y38/RX" \
              "$pathBaseGTH/Quad_233/MGT_X0Y37/RX" \
              "$pathBaseGTH/Quad_234/MGT_X0Y40/RX" \
              "$pathBaseGTH/Quad_233/MGT_X0Y36/RX" \
              "$pathBaseGTH/Quad_232/MGT_X0Y34/RX" \
              "$pathBaseGTH/Quad_232/MGT_X0Y33/RX" \
              "$pathBaseGTH/Quad_233/MGT_X0Y39/RX" \
              "$pathBaseGTH/Quad_232/MGT_X0Y35/RX" \
              "$pathBaseGTH/Quad_232/MGT_X0Y32/RX" \
              ]

## list element positions [DC, tx, list_of_elements_tx, rx, list_of_elements_rx ]
#set connections [ list \
#                      [list "0" "0" $tx0 "0" $rx0 ""] \
#                      [list "0" "1" $tx1 "1" $rx1 ""] \
#                      [list "0" "2" $tx2 "2" $rx2 ""] \
#                      [list "0" "3" $tx3 "3" $rx3 ""] \
#                      [list "0" "4" $tx4 "4" $rx4 ""] \
#                      [list "0" "5" $tx5 "5" $rx5 ""] \
#                     ]

set connections [ list \
                      [list "0" "0" $tx0 "0" $rx0 ""] \
                      [list "0" "1" $tx1 "1" $rx1 ""] \
                      [list "0" "2" $tx2 "2" $rx2 ""] \
                      [list "0" "3" $tx3 "3" $rx3 "invertTx"] \
                      [list "0" "4" $tx4 "5" $rx5 "invertTx"] \
                      [list "0" "5" $tx5 "4" $rx4 "invertTx"] \
                     ]

#set connections [ list \
#                      [list "0" "0" $tx0 "5" $rx5 ] \
#                      [list "0" "1" $tx1 "4" $rx4 ] \
#                      [list "0" "2" $tx2 "3" $rx3 ] \
#                      [list "0" "3" $tx3 "2" $rx2 ] \
#                      [list "0" "4" $tx4 "1" $rx1 ] \
#                      [list "0" "5" $tx5 "0" $rx0 ] \
#                     ]


### generate
foreach c $connections {

    set xil_newLinks [ list ]

    set DC     [ lindex $c 0 ]
    set txId   [ lindex $c 1 ]
    set txList [ lindex $c 2 ]
    set rxId   [ lindex $c 3 ]
    set rxList [ lindex $c 4 ]
    set invert [ lindex $c 5 ]
    
    if { $invert == "invertRx" } {
        set rxId   [ lreverse $rxId ]
        set rxList [ lreverse $rxList ]
    }
    if { $invert == "invertTx" } {
        set txId   [ lreverse $txId ]
        set txList [ lreverse $txList ]
    }

    set i 0

    foreach rx $rxList tx $txList {

        set description "Link_$DC $i"
        set xil_newLink [create_hw_sio_link -description $description [lindex [get_hw_sio_txs $tx] 0] [lindex [get_hw_sio_rxs $rx] 0] ]
        lappend xil_newLinks $xil_newLink
        
        incr i

    }

    set description "DC$DC:Tx$txId-Rx$rxId"
    set xil_newLinkGroup [create_hw_sio_linkgroup -description $description [get_hw_sio_links $xil_newLinks]]
    unset xil_newLinks

}
