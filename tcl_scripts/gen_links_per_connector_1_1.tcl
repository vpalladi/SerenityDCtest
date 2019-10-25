
#set pathBaseGTY "pcuptracker001:3121/xilinx_tcf/Xilinx/128.141.223.225:5006/0_1_0_50/IBERT"
#set pathBaseGTH "pcuptracker001:3121/xilinx_tcf/Xilinx/128.141.223.225:5006/0_1_0_0/IBERT"

set pathBaseGTY "localhost:3121/xilinx_tcf/Digilent/210249A847C3/1_1_0_50/IBERT"
set pathBaseGTH "localhost:3121/xilinx_tcf/Digilent/210249A847C3/1_1_0_0/IBERT"

# tx0->rx0
set xil_newLinks [list]

set xil_newLink [create_hw_sio_link -description {Link_1 0 } [lindex [get_hw_sio_txs $pathBaseGTY/Quad_134/MGT_X0Y30/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTY/Quad_132/MGT_X0Y22/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 1 } [lindex [get_hw_sio_txs $pathBaseGTY/Quad_132/MGT_X0Y23/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTY/Quad_132/MGT_X0Y21/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 2 } [lindex [get_hw_sio_txs $pathBaseGTY/Quad_134/MGT_X0Y29/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTY/Quad_132/MGT_X0Y20/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 3 } [lindex [get_hw_sio_txs $pathBaseGTY/Quad_134/MGT_X0Y31/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTY/Quad_134/MGT_X0Y29/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 4 } [lindex [get_hw_sio_txs $pathBaseGTY/Quad_134/MGT_X0Y28/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTY/Quad_132/MGT_X0Y23/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 5 } [lindex [get_hw_sio_txs $pathBaseGTY/Quad_133/MGT_X0Y27/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTY/Quad_133/MGT_X0Y24/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 6 } [lindex [get_hw_sio_txs $pathBaseGTY/Quad_132/MGT_X0Y20/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTY/Quad_133/MGT_X0Y26/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 7 } [lindex [get_hw_sio_txs $pathBaseGTY/Quad_133/MGT_X0Y25/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTY/Quad_134/MGT_X0Y30/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 8 } [lindex [get_hw_sio_txs $pathBaseGTY/Quad_133/MGT_X0Y26/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTY/Quad_133/MGT_X0Y25/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 9 } [lindex [get_hw_sio_txs $pathBaseGTY/Quad_132/MGT_X0Y21/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTY/Quad_134/MGT_X0Y28/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 10} [lindex [get_hw_sio_txs $pathBaseGTY/Quad_132/MGT_X0Y22/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTY/Quad_134/MGT_X0Y31/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 11} [lindex [get_hw_sio_txs $pathBaseGTY/Quad_133/MGT_X0Y24/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTY/Quad_133/MGT_X0Y27/RX] 0] ]
lappend xil_newLinks $xil_newLink

set xil_newLinkGroup [create_hw_sio_linkgroup -description {DC1:Tx0-Rx0} [get_hw_sio_links $xil_newLinks]]

unset xil_newLinks


# tx1->rx1
set xil_newLinks [list]

set xil_newLink [create_hw_sio_link -description {Link_1 0 } [lindex [get_hw_sio_txs $pathBaseGTY/Quad_131/MGT_X0Y17/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTY/Quad_129/MGT_X0Y9/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 1 } [lindex [get_hw_sio_txs $pathBaseGTY/Quad_130/MGT_X0Y14/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTY/Quad_130/MGT_X0Y13/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 2 } [lindex [get_hw_sio_txs $pathBaseGTY/Quad_131/MGT_X0Y18/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTY/Quad_129/MGT_X0Y8/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 3 } [lindex [get_hw_sio_txs $pathBaseGTY/Quad_131/MGT_X0Y19/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTY/Quad_129/MGT_X0Y11/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 4 } [lindex [get_hw_sio_txs $pathBaseGTY/Quad_130/MGT_X0Y15/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTY/Quad_131/MGT_X0Y16/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 5 } [lindex [get_hw_sio_txs $pathBaseGTY/Quad_131/MGT_X0Y16/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTY/Quad_131/MGT_X0Y18/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 6 } [lindex [get_hw_sio_txs $pathBaseGTY/Quad_129/MGT_X0Y10/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTY/Quad_129/MGT_X0Y10/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 7 } [lindex [get_hw_sio_txs $pathBaseGTY/Quad_129/MGT_X0Y11/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTY/Quad_131/MGT_X0Y19/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 8 } [lindex [get_hw_sio_txs $pathBaseGTY/Quad_130/MGT_X0Y13/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTY/Quad_131/MGT_X0Y17/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 9 } [lindex [get_hw_sio_txs $pathBaseGTY/Quad_129/MGT_X0Y8/TX] 0]  [lindex [get_hw_sio_rxs $pathBaseGTY/Quad_130/MGT_X0Y12/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 10} [lindex [get_hw_sio_txs $pathBaseGTY/Quad_129/MGT_X0Y9/TX] 0]  [lindex [get_hw_sio_rxs $pathBaseGTY/Quad_130/MGT_X0Y14/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 11} [lindex [get_hw_sio_txs $pathBaseGTY/Quad_130/MGT_X0Y12/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTY/Quad_130/MGT_X0Y15/RX] 0] ]
lappend xil_newLinks $xil_newLink

set xil_newLinkGroup [create_hw_sio_linkgroup -description {DC1:Tx1-Rx1} [get_hw_sio_links $xil_newLinks]]

unset xil_newLinks

# tx2->rx2
set xil_newLinks [list]

set xil_newLink [create_hw_sio_link -description {Link_1 0 } [lindex [get_hw_sio_txs $pathBaseGTY/Quad_128/MGT_X0Y6/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_225/MGT_X0Y6/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 1 } [lindex [get_hw_sio_txs $pathBaseGTY/Quad_128/MGT_X0Y7/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_225/MGT_X0Y5/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 2 } [lindex [get_hw_sio_txs $pathBaseGTY/Quad_127/MGT_X0Y0/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_225/MGT_X0Y4/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 3 } [lindex [get_hw_sio_txs $pathBaseGTY/Quad_128/MGT_X0Y5/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_225/MGT_X0Y7/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 4 } [lindex [get_hw_sio_txs $pathBaseGTY/Quad_127/MGT_X0Y3/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTY/Quad_128/MGT_X0Y5/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 5 } [lindex [get_hw_sio_txs $pathBaseGTH/Quad_225/MGT_X0Y7/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTY/Quad_128/MGT_X0Y6/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 6 } [lindex [get_hw_sio_txs $pathBaseGTY/Quad_127/MGT_X0Y1/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTY/Quad_127/MGT_X0Y1/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 7 } [lindex [get_hw_sio_txs $pathBaseGTY/Quad_127/MGT_X0Y2/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTY/Quad_127/MGT_X0Y2/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 8 } [lindex [get_hw_sio_txs $pathBaseGTH/Quad_225/MGT_X0Y6/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTY/Quad_128/MGT_X0Y7/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 9 } [lindex [get_hw_sio_txs $pathBaseGTY/Quad_128/MGT_X0Y4/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTY/Quad_127/MGT_X0Y0/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 10} [lindex [get_hw_sio_txs $pathBaseGTH/Quad_225/MGT_X0Y4/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTY/Quad_127/MGT_X0Y3/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 11} [lindex [get_hw_sio_txs $pathBaseGTH/Quad_225/MGT_X0Y5/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTY/Quad_128/MGT_X0Y4/RX] 0] ]
lappend xil_newLinks $xil_newLink

set xil_newLinkGroup [create_hw_sio_linkgroup -description {DC1:Tx2-Rx2} [get_hw_sio_links $xil_newLinks]]

unset xil_newLinks


# tx3->rx3
set xil_newLinks [list]

set xil_newLink [create_hw_sio_link -description {Link_1 0 } [lindex [get_hw_sio_txs $pathBaseGTH/Quad_227/MGT_X0Y15/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_227/MGT_X0Y14/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 1 } [lindex [get_hw_sio_txs $pathBaseGTH/Quad_227/MGT_X0Y13/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_227/MGT_X0Y12/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 2 } [lindex [get_hw_sio_txs $pathBaseGTH/Quad_226/MGT_X0Y8/TX] 0]  [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_228/MGT_X0Y17/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 3 } [lindex [get_hw_sio_txs $pathBaseGTH/Quad_228/MGT_X0Y17/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_227/MGT_X0Y13/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 4 } [lindex [get_hw_sio_txs $pathBaseGTH/Quad_226/MGT_X0Y10/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_227/MGT_X0Y15/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 5 } [lindex [get_hw_sio_txs $pathBaseGTH/Quad_226/MGT_X0Y11/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_228/MGT_X0Y19/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 6 } [lindex [get_hw_sio_txs $pathBaseGTH/Quad_228/MGT_X0Y19/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_226/MGT_X0Y11/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 7 } [lindex [get_hw_sio_txs $pathBaseGTH/Quad_227/MGT_X0Y14/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_226/MGT_X0Y10/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 8 } [lindex [get_hw_sio_txs $pathBaseGTH/Quad_227/MGT_X0Y12/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_228/MGT_X0Y18/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 9 } [lindex [get_hw_sio_txs $pathBaseGTH/Quad_228/MGT_X0Y18/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_226/MGT_X0Y9/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 10} [lindex [get_hw_sio_txs $pathBaseGTH/Quad_228/MGT_X0Y16/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_226/MGT_X0Y8/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 11} [lindex [get_hw_sio_txs $pathBaseGTH/Quad_226/MGT_X0Y9/TX] 0]  [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_228/MGT_X0Y16/RX] 0] ]
lappend xil_newLinks $xil_newLink

set xil_newLinkGroup [create_hw_sio_linkgroup -description {DC1:Tx3-Rx3} [get_hw_sio_links $xil_newLinks]]

unset xil_newLinks


# tx4->rx4
set xil_newLinks [list]

set xil_newLink [create_hw_sio_link -description {Link_1 0 } [lindex [get_hw_sio_txs $pathBaseGTH/Quad_229/MGT_X0Y23/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_231/MGT_X0Y29/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 1 } [lindex [get_hw_sio_txs $pathBaseGTH/Quad_229/MGT_X0Y20/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_231/MGT_X0Y30/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 2 } [lindex [get_hw_sio_txs $pathBaseGTH/Quad_229/MGT_X0Y22/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_231/MGT_X0Y31/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 3 } [lindex [get_hw_sio_txs $pathBaseGTH/Quad_231/MGT_X0Y30/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_230/MGT_X0Y27/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 4 } [lindex [get_hw_sio_txs $pathBaseGTH/Quad_231/MGT_X0Y28/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_231/MGT_X0Y28/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 5 } [lindex [get_hw_sio_txs $pathBaseGTH/Quad_230/MGT_X0Y24/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_230/MGT_X0Y26/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 6 } [lindex [get_hw_sio_txs $pathBaseGTH/Quad_230/MGT_X0Y25/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_229/MGT_X0Y23/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 7 } [lindex [get_hw_sio_txs $pathBaseGTH/Quad_230/MGT_X0Y27/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_230/MGT_X0Y24/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 8 } [lindex [get_hw_sio_txs $pathBaseGTH/Quad_230/MGT_X0Y26/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_230/MGT_X0Y25/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 9 } [lindex [get_hw_sio_txs $pathBaseGTH/Quad_231/MGT_X0Y31/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_229/MGT_X0Y22/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 10} [lindex [get_hw_sio_txs $pathBaseGTH/Quad_231/MGT_X0Y29/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_229/MGT_X0Y21/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 11} [lindex [get_hw_sio_txs $pathBaseGTH/Quad_229/MGT_X0Y21/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_229/MGT_X0Y20/RX] 0] ]
lappend xil_newLinks $xil_newLink

set xil_newLinkGroup [create_hw_sio_linkgroup -description {DC1:Tx4-Rx4} [get_hw_sio_links $xil_newLinks]]

unset xil_newLinks


# tx4->rx4
set xil_newLinks [list]

set xil_newLink [create_hw_sio_link -description {Link_1 0 } [lindex [get_hw_sio_txs $pathBaseGTH/Quad_233/MGT_X0Y36/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_234/MGT_X0Y43/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 1 } [lindex [get_hw_sio_txs $pathBaseGTH/Quad_232/MGT_X0Y33/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_234/MGT_X0Y42/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 2 } [lindex [get_hw_sio_txs $pathBaseGTH/Quad_232/MGT_X0Y32/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_234/MGT_X0Y41/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 3 } [lindex [get_hw_sio_txs $pathBaseGTH/Quad_233/MGT_X0Y39/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_233/MGT_X0Y38/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 4 } [lindex [get_hw_sio_txs $pathBaseGTH/Quad_232/MGT_X0Y34/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_233/MGT_X0Y37/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 5 } [lindex [get_hw_sio_txs $pathBaseGTH/Quad_232/MGT_X0Y35/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_234/MGT_X0Y40/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 6 } [lindex [get_hw_sio_txs $pathBaseGTH/Quad_234/MGT_X0Y43/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_233/MGT_X0Y36/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 7 } [lindex [get_hw_sio_txs $pathBaseGTH/Quad_233/MGT_X0Y37/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_232/MGT_X0Y34/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 8 } [lindex [get_hw_sio_txs $pathBaseGTH/Quad_233/MGT_X0Y38/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_232/MGT_X0Y33/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 9 } [lindex [get_hw_sio_txs $pathBaseGTH/Quad_234/MGT_X0Y42/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_233/MGT_X0Y39/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 10} [lindex [get_hw_sio_txs $pathBaseGTH/Quad_234/MGT_X0Y40/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_232/MGT_X0Y35/RX] 0] ]
lappend xil_newLinks $xil_newLink
set xil_newLink [create_hw_sio_link -description {Link_1 11} [lindex [get_hw_sio_txs $pathBaseGTH/Quad_234/MGT_X0Y41/TX] 0] [lindex [get_hw_sio_rxs $pathBaseGTH/Quad_232/MGT_X0Y32/RX] 0] ]
lappend xil_newLinks $xil_newLink

set xil_newLinkGroup [create_hw_sio_linkgroup -description {DC1:Tx5-Rx5} [get_hw_sio_links $xil_newLinks]]

unset xil_newLinks


