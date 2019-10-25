
set links [get_hw_sio_links]


foreach link $links {

    # DFE off
    #set_property RXDFEENABLED {0} [get_hw_sio_links $link]
    #set_property TXDFEENABLED {0} [get_hw_sio_links $link]
    
    # PRBS to 31 bits
    set_property TX_PATTERN {PRBS 31-bit} [get_hw_sio_links $link]
    set_property RX_PATTERN {PRBS 31-bit} [get_hw_sio_links $link]

    # set polarity
    set_property PORT.RXPOLARITY {1} [get_hw_sio_links $link]
    
    commit_hw_sio [get_hw_sio_links $link]

    # reset
    set_property LOGIC.MGT_ERRCNT_RESET_CTRL 1 [get_hw_sio_links $link]
    commit_hw_sio [get_hw_sio_links $link]
    set_property LOGIC.MGT_ERRCNT_RESET_CTRL 0 [get_hw_sio_links $link]
    commit_hw_sio [get_hw_sio_links $link]

}


