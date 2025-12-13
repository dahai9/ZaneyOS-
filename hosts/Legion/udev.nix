{...}: {
  services.udev.enable = true;
  services.udev.extraRules = ''
    # 提高 amdgpu_bl2 的优先级
    SUBSYSTEM=="backlight", KERNEL=="amdgpu_bl2", ATTR{priority}="100"
    SUBSYSTEM=="backlight", KERNEL=="nvidia_0", ATTR{priority}="50"

    # 创建一个默认 backlight 的符号链接指向 amdgpu_bl2
    SUBSYSTEM=="backlight", KERNEL=="amdgpu_bl2", SYMLINK+="backlight"
  '';
}
