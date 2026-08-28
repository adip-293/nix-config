{ ... }:
{
  # ly is a TUI login manager that draws on tty1. Nothing graphical stands
  # between power-on and the session, so it appears the moment the unit
  # starts. Delete this file to fall back to a plain TTY login.
  services.displayManager = {
    ly = {
      enable = true;

      # niri is Wayland-only and services.xserver is off, so ly's X11 half is
      # dead weight. Off here means no xauth and no X server wrapper.
      x11Support = false;

      settings = {
        # Colors are noctalia's active scheme: the community palette Miasma,
        # dark mode, from ~/.local/state/noctalia/community-palettes/. Check
        # the live scheme with `noctalia msg color-scheme-get`, not the stale
        # ~/.config/noctalia/colors.json, which v5 no longer writes.
        #
        # Fixed rather than wallpaper-derived, so it does not drift. Switching
        # schemes in noctalia means updating these five values by hand - ly
        # runs on a TTY before the compositor exists and cannot read them.
        #
        # ly wants 0xSSRRGGBB, where SS is a style byte - 0x00 is unstyled,
        # 0x01 is bold. Written as strings so the literal hex reaches
        # config.ini instead of Nix rendering it as decimal.
        # The module writes a fresh config.ini rather than using ly's shipped
        # one, so anything unset falls back to a compiled-in default. Pinned
        # explicitly: without it the colors below degrade to 8-color mode.
        full_color = true;

        bg = "0x00222222"; # mSurface
        fg = "0x00C2C2B0"; # mOnSurface
        border_fg = "0x00C9A554"; # mPrimary
        error_bg = "0x00222222"; # mSurface
        error_fg = "0x01B36D43"; # mError, bold

        # Cosmetics. The version string is noise on a login screen; the key
        # hints (F1 shutdown, F2 reboot) are worth keeping.
        hide_version_string = true;
        box_title = "thinkpad";
        text_in_center = true;
        margin_box_h = 4;
        margin_box_v = 2;

        clock = "%a %d %b  %H:%M";
        battery_id = "BAT0"; # verified present in /sys/class/power_supply
        asterisk = "0x2022"; # bullet instead of *
        clear_password = true;

        # Deliberately no animation. doom/matrix/colormix all burn CPU
        # redrawing a login screen you want to be past in two seconds.
        animation = "none";
      };
    };

    # Which session is preselected. ly discovers the entry itself from the
    # wayland-sessions directory that programs.niri populates.
    defaultSession = "niri";
  };

  # No PAM workaround here on purpose. ly's stack substacks `login`, which
  # gnome-keyring already hooks, so the keyring unlocks with the login
  # password - the thing the old noctalia-greeter mkForce gave up.
}
