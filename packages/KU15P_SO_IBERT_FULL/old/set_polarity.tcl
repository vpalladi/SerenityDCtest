


set pathBaseGTY "pcuptracker001:3121/xilinx_tcf/Xilinx/128.141.223.227:5006/0_1_0_50/IBERT"
set pathBaseGTH "pcuptracker001:3121/xilinx_tcf/Xilinx/128.141.223.227:5006/1_1_0_0/IBERT"

# tx0->rx0

set tx0 [list]
set rx0 [list]

lappend tx0 "$pathBaseGTY/Quad_134/MGT_X0Y30/TX"  
lappend tx0 "$pathBaseGTY/Quad_132/MGT_X0Y23/TX"  
lappend tx0 "$pathBaseGTY/Quad_134/MGT_X0Y29/TX"  
lappend tx0 "$pathBaseGTY/Quad_134/MGT_X0Y31/TX"  
lappend tx0 "$pathBaseGTY/Quad_134/MGT_X0Y28/TX"  
lappend tx0 "$pathBaseGTY/Quad_133/MGT_X0Y27/TX"  
lappend tx0 "$pathBaseGTY/Quad_132/MGT_X0Y20/TX"  
lappend tx0 "$pathBaseGTY/Quad_133/MGT_X0Y25/TX"  
lappend tx0 "$pathBaseGTY/Quad_133/MGT_X0Y26/TX"  
lappend tx0 "$pathBaseGTY/Quad_132/MGT_X0Y21/TX"  
lappend tx0 "$pathBaseGTY/Quad_132/MGT_X0Y22/TX"  
lappend tx0 "$pathBaseGTY/Quad_133/MGT_X0Y24/TX"  
   
lappend rx0 "$pathBaseGTY/Quad_132/MGT_X0Y22/RX" 
lappend rx0 "$pathBaseGTY/Quad_132/MGT_X0Y21/RX" 
lappend rx0 "$pathBaseGTY/Quad_132/MGT_X0Y20/RX" 
lappend rx0 "$pathBaseGTY/Quad_134/MGT_X0Y29/RX" 
lappend rx0 "$pathBaseGTY/Quad_132/MGT_X0Y23/RX" 
lappend rx0 "$pathBaseGTY/Quad_133/MGT_X0Y24/RX" 
lappend rx0 "$pathBaseGTY/Quad_133/MGT_X0Y26/RX" 
lappend rx0 "$pathBaseGTY/Quad_134/MGT_X0Y30/RX" 
lappend rx0 "$pathBaseGTY/Quad_133/MGT_X0Y25/RX" 
lappend rx0 "$pathBaseGTY/Quad_134/MGT_X0Y28/RX" 
lappend rx0 "$pathBaseGTY/Quad_134/MGT_X0Y31/RX" 
lappend rx0 "$pathBaseGTY/Quad_133/MGT_X0Y27/RX" 
             
# tx1->rx1
set tx1 [list]
set rx1 [list]
             
lappend tx1 "$pathBaseGTY/Quad_131/MGT_X0Y17/TX"  
lappend tx1 "$pathBaseGTY/Quad_130/MGT_X0Y14/TX"  
lappend tx1 "$pathBaseGTY/Quad_131/MGT_X0Y18/TX"  
lappend tx1 "$pathBaseGTY/Quad_131/MGT_X0Y19/TX"  
lappend tx1 "$pathBaseGTY/Quad_130/MGT_X0Y15/TX"  
lappend tx1 "$pathBaseGTY/Quad_131/MGT_X0Y16/TX"  
lappend tx1 "$pathBaseGTY/Quad_129/MGT_X0Y10/TX"  
lappend tx1 "$pathBaseGTY/Quad_129/MGT_X0Y11/TX"  
lappend tx1 "$pathBaseGTY/Quad_130/MGT_X0Y13/TX"  
lappend tx1 "$pathBaseGTY/Quad_129/MGT_X0Y8/TX"   
lappend tx1 "$pathBaseGTY/Quad_129/MGT_X0Y9/TX"   
lappend tx1 "$pathBaseGTY/Quad_130/MGT_X0Y12/TX"  
             
lappend rx1 "$pathBaseGTY/Quad_129/MGT_X0Y9/RX"  
lappend rx1 "$pathBaseGTY/Quad_130/MGT_X0Y13/RX" 
lappend rx1 "$pathBaseGTY/Quad_129/MGT_X0Y8/RX"  
lappend rx1 "$pathBaseGTY/Quad_129/MGT_X0Y11/RX" 
lappend rx1 "$pathBaseGTY/Quad_131/MGT_X0Y16/RX" 
lappend rx1 "$pathBaseGTY/Quad_131/MGT_X0Y18/RX" 
lappend rx1 "$pathBaseGTY/Quad_129/MGT_X0Y10/RX" 
lappend rx1 "$pathBaseGTY/Quad_131/MGT_X0Y19/RX" 
lappend rx1 "$pathBaseGTY/Quad_131/MGT_X0Y17/RX" 
lappend rx1 "$pathBaseGTY/Quad_130/MGT_X0Y12/RX" 
lappend rx1 "$pathBaseGTY/Quad_130/MGT_X0Y14/RX" 
lappend rx1 "$pathBaseGTY/Quad_130/MGT_X0Y15/RX" 

# tx2->rx2
set tx2 [list]
set rx2 [list]

lappend tx2 "$pathBaseGTY/Quad_128/MGT_X0Y6/TX"  
lappend tx2 "$pathBaseGTY/Quad_128/MGT_X0Y7/TX"  
lappend tx2 "$pathBaseGTY/Quad_127/MGT_X0Y0/TX"  
lappend tx2 "$pathBaseGTY/Quad_128/MGT_X0Y5/TX"  
lappend tx2 "$pathBaseGTY/Quad_127/MGT_X0Y3/TX"  
lappend tx2 "$pathBaseGTH/Quad_225/MGT_X0Y7/TX"  
lappend tx2 "$pathBaseGTY/Quad_127/MGT_X0Y1/TX"  
lappend tx2 "$pathBaseGTY/Quad_127/MGT_X0Y2/TX"  
lappend tx2 "$pathBaseGTH/Quad_225/MGT_X0Y6/TX"  
lappend tx2 "$pathBaseGTY/Quad_128/MGT_X0Y4/TX"  
lappend tx2 "$pathBaseGTH/Quad_225/MGT_X0Y4/TX"  
lappend tx2 "$pathBaseGTH/Quad_225/MGT_X0Y5/TX"  
             
lappend rx2 "$pathBaseGTH/Quad_225/MGT_X0Y6/RX" 
lappend rx2 "$pathBaseGTH/Quad_225/MGT_X0Y5/RX" 
lappend rx2 "$pathBaseGTH/Quad_225/MGT_X0Y4/RX" 
lappend rx2 "$pathBaseGTH/Quad_225/MGT_X0Y7/RX" 
lappend rx2 "$pathBaseGTY/Quad_128/MGT_X0Y5/RX" 
lappend rx2 "$pathBaseGTY/Quad_128/MGT_X0Y6/RX" 
lappend rx2 "$pathBaseGTY/Quad_127/MGT_X0Y1/RX" 
lappend rx2 "$pathBaseGTY/Quad_127/MGT_X0Y2/RX" 
lappend rx2 "$pathBaseGTY/Quad_128/MGT_X0Y7/RX" 
lappend rx2 "$pathBaseGTY/Quad_127/MGT_X0Y0/RX" 
lappend rx2 "$pathBaseGTY/Quad_127/MGT_X0Y3/RX" 
lappend rx2 "$pathBaseGTY/Quad_128/MGT_X0Y4/RX" 

# tx3->rx3
set tx3 [list]
set rx3 [list]

lappend tx3 "$pathBaseGTH/Quad_227/MGT_X0Y15/TX" 
lappend tx3 "$pathBaseGTH/Quad_227/MGT_X0Y13/TX" 
lappend tx3 "$pathBaseGTH/Quad_226/MGT_X0Y8/TX"  
lappend tx3 "$pathBaseGTH/Quad_228/MGT_X0Y17/TX" 
lappend tx3 "$pathBaseGTH/Quad_226/MGT_X0Y10/TX" 
lappend tx3 "$pathBaseGTH/Quad_226/MGT_X0Y11/TX" 
lappend tx3 "$pathBaseGTH/Quad_228/MGT_X0Y19/TX" 
lappend tx3 "$pathBaseGTH/Quad_227/MGT_X0Y14/TX" 
lappend tx3 "$pathBaseGTH/Quad_227/MGT_X0Y12/TX" 
lappend tx3 "$pathBaseGTH/Quad_228/MGT_X0Y18/TX" 
lappend tx3 "$pathBaseGTH/Quad_228/MGT_X0Y16/TX" 
lappend tx3 "$pathBaseGTH/Quad_226/MGT_X0Y9/TX"  
            
lappend rx3 "$pathBaseGTH/Quad_227/MGT_X0Y14/RX"
lappend rx3 "$pathBaseGTH/Quad_227/MGT_X0Y12/RX"
lappend rx3 "$pathBaseGTH/Quad_228/MGT_X0Y17/RX"
lappend rx3 "$pathBaseGTH/Quad_227/MGT_X0Y13/RX"
lappend rx3 "$pathBaseGTH/Quad_227/MGT_X0Y15/RX"
lappend rx3 "$pathBaseGTH/Quad_228/MGT_X0Y19/RX"
lappend rx3 "$pathBaseGTH/Quad_226/MGT_X0Y11/RX"
lappend rx3 "$pathBaseGTH/Quad_226/MGT_X0Y10/RX"
lappend rx3 "$pathBaseGTH/Quad_228/MGT_X0Y18/RX"
lappend rx3 "$pathBaseGTH/Quad_226/MGT_X0Y9/RX" 
lappend rx3 "$pathBaseGTH/Quad_226/MGT_X0Y8/RX" 
lappend rx3 "$pathBaseGTH/Quad_228/MGT_X0Y16/RX"
            
# tx4->rx4
set tx4 [list]
set rx4 [list]
            
lappend tx4 "$pathBaseGTH/Quad_229/MGT_X0Y23/TX" 
lappend tx4 "$pathBaseGTH/Quad_229/MGT_X0Y20/TX" 
lappend tx4 "$pathBaseGTH/Quad_229/MGT_X0Y22/TX" 
lappend tx4 "$pathBaseGTH/Quad_231/MGT_X0Y30/TX" 
lappend tx4 "$pathBaseGTH/Quad_231/MGT_X0Y28/TX" 
lappend tx4 "$pathBaseGTH/Quad_230/MGT_X0Y24/TX" 
lappend tx4 "$pathBaseGTH/Quad_230/MGT_X0Y25/TX" 
lappend tx4 "$pathBaseGTH/Quad_230/MGT_X0Y27/TX" 
lappend tx4 "$pathBaseGTH/Quad_230/MGT_X0Y26/TX" 
lappend tx4 "$pathBaseGTH/Quad_231/MGT_X0Y31/TX" 
lappend tx4 "$pathBaseGTH/Quad_231/MGT_X0Y29/TX" 
lappend tx4 "$pathBaseGTH/Quad_229/MGT_X0Y21/TX" 
            
lappend rx4 "$pathBaseGTH/Quad_231/MGT_X0Y29/RX"
lappend rx4 "$pathBaseGTH/Quad_231/MGT_X0Y30/RX"
lappend rx4 "$pathBaseGTH/Quad_231/MGT_X0Y31/RX"
lappend rx4 "$pathBaseGTH/Quad_230/MGT_X0Y27/RX"
lappend rx4 "$pathBaseGTH/Quad_231/MGT_X0Y28/RX"
lappend rx4 "$pathBaseGTH/Quad_230/MGT_X0Y26/RX"
lappend rx4 "$pathBaseGTH/Quad_229/MGT_X0Y23/RX"
lappend rx4 "$pathBaseGTH/Quad_230/MGT_X0Y24/RX"
lappend rx4 "$pathBaseGTH/Quad_230/MGT_X0Y25/RX"
lappend rx4 "$pathBaseGTH/Quad_229/MGT_X0Y22/RX"
lappend rx4 "$pathBaseGTH/Quad_229/MGT_X0Y21/RX"
lappend rx4 "$pathBaseGTH/Quad_229/MGT_X0Y20/RX"
            
# tx5, rx5
set tx5 [list]
set rx5 [list]
            
lappend tx5 "$pathBaseGTH/Quad_233/MGT_X0Y36/TX"
lappend tx5 "$pathBaseGTH/Quad_232/MGT_X0Y33/TX"
lappend tx5 "$pathBaseGTH/Quad_232/MGT_X0Y32/TX"
lappend tx5 "$pathBaseGTH/Quad_233/MGT_X0Y39/TX"
lappend tx5 "$pathBaseGTH/Quad_232/MGT_X0Y34/TX"
lappend tx5 "$pathBaseGTH/Quad_232/MGT_X0Y35/TX"
lappend tx5 "$pathBaseGTH/Quad_234/MGT_X0Y43/TX"
lappend tx5 "$pathBaseGTH/Quad_233/MGT_X0Y37/TX"
lappend tx5 "$pathBaseGTH/Quad_233/MGT_X0Y38/TX"
lappend tx5 "$pathBaseGTH/Quad_234/MGT_X0Y42/TX"
lappend tx5 "$pathBaseGTH/Quad_234/MGT_X0Y40/TX"
lappend tx5 "$pathBaseGTH/Quad_234/MGT_X0Y41/TX"
            
lappend rx5 "$pathBaseGTH/Quad_234/MGT_X0Y43/RX"
lappend rx5 "$pathBaseGTH/Quad_234/MGT_X0Y42/RX"
lappend rx5 "$pathBaseGTH/Quad_234/MGT_X0Y41/RX"
lappend rx5 "$pathBaseGTH/Quad_233/MGT_X0Y38/RX"
lappend rx5 "$pathBaseGTH/Quad_233/MGT_X0Y37/RX"
lappend rx5 "$pathBaseGTH/Quad_234/MGT_X0Y40/RX"
lappend rx5 "$pathBaseGTH/Quad_233/MGT_X0Y36/RX"
lappend rx5 "$pathBaseGTH/Quad_232/MGT_X0Y34/RX"
lappend rx5 "$pathBaseGTH/Quad_232/MGT_X0Y33/RX"
lappend rx5 "$pathBaseGTH/Quad_233/MGT_X0Y39/RX"
lappend rx5 "$pathBaseGTH/Quad_232/MGT_X0Y35/RX"
lappend rx5 "$pathBaseGTH/Quad_232/MGT_X0Y32/RX"

set txAll [list $tx0 $tx1 $tx2 $tx3 $tx4 $tx5]
set rxAll [list $rx0 $rx1 $rx2 $rx3 $rx4 $rx5]

foreach txList $txAll rxList $rxAll {
    foreach tx $txList rx $rxList {

        set pol [get_property PORT.RXPOLARITY [get_hw_sio_links "$tx->$rx"]]
        if {$pol == 0} {
            set_property PORT.RXPOLARITY {1} [get_hw_sio_links "$tx->$rx"]
            commit_hw_sio [get_hw_sio_links "$tx->$rx"]
            
        }

    }
}

