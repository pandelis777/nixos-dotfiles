{ config, pkgs, ... }:

{
  programs.dconf.enable = true;
  
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
    };
  };

  programs.virt-manager.enable = true;
  users.users.panda.extraGroups = [ "libvirtd" "kvm" ];
  
  home.packages = with pkgs; [
    bridge-utils
    virt-manager
    libvirt
    qemu_kvm
  ];
}
