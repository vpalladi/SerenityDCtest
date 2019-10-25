
puts [lindex [ get_hw_sio_plls -of_objects [ get_hw_sio_commons -of_objects [ get_hw_sio_gtgroup -of_objects [ get_hw_sio_gts -of_objects [get_hw_sio_links localhost:3121/xilinx_tcf/Digilent/210249A847C3/1_1_0_0/IBERT/Quad_231/MGT_X0Y28/TX->localhost:3121/xilinx_tcf/Digilent/210249A847C3/1_1_0_0/IBERT/Quad_231/MGT_X0Y28/RX] ] ] ] ] 0]

puts [report_property [lindex [ get_hw_sio_plls -of_objects [ get_hw_sio_commons -of_objects [ get_hw_sio_gtgroup -of_objects [ get_hw_sio_gts -of_objects [get_hw_sio_links localhost:3121/xilinx_tcf/Digilent/210249A847C3/1_1_0_0/IBERT/Quad_231/MGT_X0Y28/TX->localhost:3121/xilinx_tcf/Digilent/210249A847C3/1_1_0_0/IBERT/Quad_231/MGT_X0Y28/RX] ] ] ] ] 0] ]
puts [report_property [lindex [ get_hw_sio_plls -of_objects [ get_hw_sio_commons -of_objects [ get_hw_sio_gtgroup -of_objects [ get_hw_sio_gts -of_objects [get_hw_sio_links localhost:3121/xilinx_tcf/Digilent/210249A847C3/1_1_0_0/IBERT/Quad_231/MGT_X0Y28/TX->localhost:3121/xilinx_tcf/Digilent/210249A847C3/1_1_0_0/IBERT/Quad_231/MGT_X0Y28/RX] ] ] ] ] 1] ]

puts [get_property STATUS [lindex [ get_hw_sio_plls -of_objects [ get_hw_sio_commons -of_objects [ get_hw_sio_gtgroup -of_objects [ get_hw_sio_gts -of_objects [get_hw_sio_links localhost:3121/xilinx_tcf/Digilent/210249A847C3/1_1_0_0/IBERT/Quad_231/MGT_X0Y28/TX->localhost:3121/xilinx_tcf/Digilent/210249A847C3/1_1_0_0/IBERT/Quad_231/MGT_X0Y28/RX] ] ] ] ] 0] ]
puts [get_property STATUS [lindex [ get_hw_sio_plls -of_objects [ get_hw_sio_commons -of_objects [ get_hw_sio_gtgroup -of_objects [ get_hw_sio_gts -of_objects [get_hw_sio_links localhost:3121/xilinx_tcf/Digilent/210249A847C3/1_1_0_0/IBERT/Quad_231/MGT_X0Y28/TX->localhost:3121/xilinx_tcf/Digilent/210249A847C3/1_1_0_0/IBERT/Quad_231/MGT_X0Y28/RX] ] ] ] ] 1] ]

#DRP.A_QPLL0LOCKEN
#DRP.A_QPLL0PD
#DRP.A_QPLL0RESET
#DRP.QPLL0CLKOUT_RATE
#DRP.QPLL0_AMONITOR_SEL
#DRP.QPLL0_CFG0
#DRP.QPLL0_CFG1
#DRP.QPLL0_CFG1_G3
#DRP.QPLL0_CFG2_G3
#DRP.QPLL0_CFG2
#DRP.QPLL0_CFG3
#DRP.QPLL0_CFG4
#DRP.QPLL0_CP
#DRP.QPLL0_CP_G3
#DRP.QPLL0_CRSCODE
#DRP.QPLL0_FBDIV
#DRP.QPLL0_FBDIV_G3
#DRP.QPLL0_INIT_CFG0
#DRP.QPLL0_INIT_CFG1
#DRP.QPLL0_IPS_EN
#DRP.QPLL0_IPS_REFCLK_SEL
#DRP.QPLL0_LOCK_CFG
#DRP.QPLL0_LOCK_CFG_G3
#DRP.QPLL0_LPF
#DRP.QPLL0_LPF_G3
#DRP.QPLL0_PCI_EN
#DRP.QPLL0_RATE_SW_USE_DRP
#DRP.QPLL0_REFCLK_DIV
#DRP.QPLL0_SDM_CFG0
#DRP.QPLL0_SDM_CFG1
#DRP.QPLL0_SDM_CFG2
#NAME
#PARENT
#PORT.PCIERATEQPLL0
#PORT.QPLL0CLKRSVD0
#PORT.QPLL0CLKRSVD1
#PORT.QPLL0FBCLKLOST
#PORT.QPLL0FBDIV
#PORT.QPLL0LOCK
#PORT.QPLL0LOCKEN
#PORT.QPLL0OUTRESET
#PORT.QPLL0PD
#PORT.QPLL0REFCLKLOST
#PORT.QPLL0REFCLKSEL
#PORT.QPLL0RESET
#QPLL0CLKOUT_RATE
#QPLL0REFCLKSEL
#QPLL0_FBDIV
#QPLL0_FBDIV_G3
#QPLL0_REFCLK_DIV
#QPLL0_STATUS
#STATUS


