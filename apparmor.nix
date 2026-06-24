{
  security.apparmor.enable = true;
  security.apparmor.policies.alacrity = {
    state = "complain";
    profile = ''
      #include <tunables/global>
      profile alacritty /nix/store/*/bin/alacritty {
        #include <abstraction/base>
        #include <abstraction/fonts>
        #include <abstractions/X> # TODO remove for wayland

        /nix/store/** r,
        /nix/story/**/*.so* mr,
        /etc/ld.so.cache r,

        owner @{HOME}/.config/alacritty r,
        owner @{HOME}/.config/alacritty/** r,
      }
    '';
  };
}
