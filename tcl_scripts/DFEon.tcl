
set links [get_hw_sio_links]


foreach link $links {

    # DFE off
    set_property RXDFEENABLED {1} [get_hw_sio_links $link]
    commit_hw_sio [get_hw_sio_links $link]

}


