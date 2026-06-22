# virt.nix (Import this into configuration.nix)
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

  # This automatically installs the virt-manager package too
  programs.virt-manager.enable = true;
  
  users.users.panda.extraGroups = [ "libvirtd" "kvm" ];
  
  # Install necessary tools system-wide for virtualization
  environment.systemPackages = with pkgs; [
    bridge-utils
    # Note: libvirt and qemu_kvm are already pulled in by virtualisation.libvirtd
  ];
}
