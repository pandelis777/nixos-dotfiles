{ config, pkgs, ... }:
let
	dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
	create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
in
{
	home.username = "panda";
	home.homeDirectory = "/home/panda";
	home.stateVersion = "26.05";
	programs.bash = {
		enable = true;
		profileExtra = ''
			if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
				exec uwsm start -S hyprland-uwsm.desktop
			fi
		'';
		initExtra = ''
			PS1='\[\033[1;32m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\$\[\033[0m\] '
		'';
	};

	xdg.configFile."hypr" = {
		source = create_symlink "${dotfiles}/hypr/";
		recursive = true;
	};
	xdg.configFile."zed" = {
		source = create_symlink "${dotfiles}/zed/";
		recursive = true;
	};
	xdg.configFile."foot" = {
		source = create_symlink "${dotfiles}/foot/";
		recursive = true;
	};

	home.packages = with pkgs; [
		gcc
		zed-editor
		rofi
	];

	#fonts.packages = with pkgs; [
#		comic-mono
	#];
}
