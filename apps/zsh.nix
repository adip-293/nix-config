{
  # One of the few apps that needs both halves.

  # Only root can register a shell in /etc/shells and set it as a login shell,
  # and the greeter refuses a shell that is not listed there.
  system =
    { pkgs, ... }:
    {
      programs.zsh.enable = true;
      users.users.pabio.shell = pkgs.zsh;
    };

  # The config, and the half that actually follows you to another machine.
  home =
    { ... }:
    {
      programs.zsh = {
        enable = true;

        # home-manager spells this oh-my-zsh; the NixOS module spells it
        # ohMyZsh. Same upstream project, different option name.
        oh-my-zsh = {
          enable = true;
          theme = "agnoster";
        };
      };
    };
}
