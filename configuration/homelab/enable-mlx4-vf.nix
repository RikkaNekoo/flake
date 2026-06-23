_:{
  boot.extraModprobeConfig = ''
    # Enable 1 VF on port 2
    options mlx4_core num_vfs=0,1,0 probe_vf=0,1,0 log_num_mgm_entry_size=-1
    options mlx4_en inline_thold=0
  '';
}