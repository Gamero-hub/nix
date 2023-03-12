{pkgs, ...}: {
  home.activation.installAwesomeWMConfig = ''
      if [ ! -d "$HOME/.config/awesome" ]; then
      ln -s "/etc/nixos/modules/home/awesome/config" "$HOME/.config/awesome"
      chmod -R +w "$HOME/.config/awesome"
    fi
  '';
}
