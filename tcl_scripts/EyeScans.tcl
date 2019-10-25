
set systemTime [clock seconds]

set folderName [clock format $systemTime -format %Y%m%d%H%M%S]

set foldername "/home/hwtest/vpalladi/$foldername" 

exec mkdir -p -- $folderName


set links [get_hw_sio_links]

set groups [get_hw_sio_linkgroups]

foreach group $groups {

    set groupName [get_property DESCRIPTION $group]

    set links [get_hw_sio_links -of_objects [get_hw_sio_linkgroups $group]]

    foreach link $links {
    
        set linkName [get_property DESCRIPTION $link]
        
        set scanName "Scan $groupName $linkName"
        
        set xil_newScan [create_hw_sio_scan -description $scanName  2d_full_eye  [lindex [get_hw_sio_links $link] ] ]
        set_property HORIZONTAL_INCREMENT {1} [get_hw_sio_scans $xil_newScan]
        set_property DWELL_BER 1e-5 [get_hw_sio_scans $xil_newScan]
        
        # run the scan! :) 
        run_hw_sio_scan [get_hw_sio_scans $xil_newScan]
        wait_on_hw_sio_scan [get_hw_sio_scans $xil_newScan]
        
        # save the scan! 
        write_hw_sio_scan -force "$folderName/$scanName" [get_hw_sio_scans $xil_newScan]

    }

}






