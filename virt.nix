{ config, pkgs, ... }:

{
  programs.dconf.enable = true;
  
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true; # Crucial: Allows libvirt/QEMU to read files in your home dir
      swtpm.enable = true;
    };
  };

  programs.virt-manager.enable = true;
  
  users.users.panda.extraGroups = [ "libvirtd" "kvm" ];
  
  environment.systemPackages = with pkgs; [
    bridge-utils
  ];

  # Automatically symlink your stealth XML into the system-wide libvirt directory
  # The "L+" ensures the symlink is forcibly created/updated

#  systemd.tmpfiles.rules = [
#    "L+ /var/lib/libvirt/qemu/windows10.xml - - - - /home/panda/nixos-dotfiles/config/qemu/windows10.xml"
#  ];
}
