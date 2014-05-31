{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    anki
#    anthy  # TODO: write an anthy package (with ibus)
    chromium
    conky
    dmenu
    # install patched version of dwm
    (pkgs.lib.overrideDerivation pkgs.dwm (attrs: {
        name = "dwm-6.0-patched";
        src = fetchurl {
          url = "https://github.com/auntieNeo/dwm/archive/e7d079df7024379b50c520f14f613f0c036153b1.tar.gz";
          sha256 = "5415d2fe5458165253e047df434a7840d5488f8a60487a05c00bb4f38fe4843f";
        };
    }))
    evince
    gutenprint
    mplayer
    rxvt_unicode
    xlibs.xinit
  ];
#
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "dvorak";
  # services.xserver.xkbOptions = "eurosign:e";
  services.xserver.synaptics.enable = true;
}
