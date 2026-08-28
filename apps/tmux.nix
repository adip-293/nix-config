{
  # Terminal multiplexer: split panes and, more usefully, sessions that survive
  # the terminal window closing or an ssh connection dropping.
  #
  # Entirely per-user config, so this file works unchanged on macOS.
  home =
    { pkgs, ... }:
    {
      programs.tmux = {
        enable = true;

        # Prefix is left at the default C-b. C-a is the common rebind, but it
        # collides with readline's start-of-line in every shell, so it is not
        # obviously an upgrade - set `shortcut = "a";` here to switch.

        mouse = true;

        # Windows and panes count from 1. Matching the number row on the
        # keyboard matters more than matching array indices.
        baseIndex = 1;

        # vi keys in copy mode, to match neovim.
        keyMode = "vi";

        # The big one for neovim. tmux waits this many ms after an escape to
        # see if it is the start of an escape sequence; the 500ms default shows
        # up as a lag every single time you leave insert mode.
        escapeTime = 0;

        historyLimit = 50000;

        # Advertises italics and 256 colors to programs running inside tmux.
        terminal = "tmux-256color";

        extraConfig = ''
          # 24-bit color passthrough. Without this, tmux quantises everything
          # to 256 colors and neovim's colorscheme visibly degrades.
          set -ga terminal-features ",*:RGB"

          # Reuse the current pane's directory for new splits and windows,
          # rather than always starting from $HOME.
          bind '"' split-window -v -c "#{pane_current_path}"
          bind %   split-window -h -c "#{pane_current_path}"
          bind c   new-window      -c "#{pane_current_path}"

          # Close a window in the middle and the rest renumber, so the indices
          # stay contiguous and predictable.
          set -g renumber-windows on

          # Select with v and copy with y, as in neovim's visual mode.
          bind -T copy-mode-vi v send -X begin-selection
          bind -T copy-mode-vi y send -X copy-pipe-and-cancel

          # Send that copy to the system clipboard rather than only tmux's own
          # buffer. wl-clipboard comes from ../system/desktop.nix on Linux;
          # pbcopy is built in on macOS.
          set -s copy-command '${if pkgs.stdenv.hostPlatform.isDarwin then "pbcopy" else "wl-copy"}'

          # Status bar in the Miasma palette, the same colors hardcoded into
          # the ly greeter in ../system/greeter.nix.
          set -g status-style 'bg=#222222 fg=#C2C2B0'
          set -g status-left ' #[bold]#S #[default]'
          set -g status-right '#[fg=#C9A554]%a %d %b  %H:%M '
          set -g status-right-length 40
          set -g window-status-current-style 'fg=#C9A554 bold'
        '';
      };
    };
}
