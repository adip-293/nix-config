{
  home =
    { ... }:
    {
      programs.git = {
        enable = true;

        # `settings` is ~/.gitconfig verbatim, as nested attributes. The older
        # userName/userEmail/extraConfig options are deprecated aliases into
        # here as of home-manager 26.05.
        settings = {
          user.name = "Aditya Pola";
          user.email = "adityapola4@gmail.com";

          init.defaultBranch = "main";

          # Only ever fast-forward or make an explicit merge on pull; never
          # silently rebase or create a surprise merge commit.
          pull.ff = "only";
        };
      };
    };

  # Note: ../system/core.nix also puts git in environment.systemPackages,
  # deliberately - a system-wide git has to exist before this flake can be
  # evaluated at all, which is earlier than any of this applies.
}
