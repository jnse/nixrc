{ config, lib, pkgs, ... }:

{
  # install development packages
  environment.systemPackages = with pkgs; [
    binutils
    cmake
    doxygen
    eclipses.eclipse_cpp_43
    mercurial
    netbeans
    (lib.overrideDerivation pkgs.nixops (attrs: rec {
      name = "nixops-git-${version}";
      version = "86c35beca37833c5b0abed373e5144702f2e88f6";

      src = pkgs.fetchgit {
        url = https://github.com/NixOS/nixops;
        rev = "${version}";
        sha256 = "204b1846f79fb9db48e44251f6075cab56de6bf49740a73907f7ccc3c26ca660";
      };
    }))
    piglit
    python
#    polish-shell
    R
#    rubyLibs.jekyll
    scons
    sloccount
    subversionClient
    valgrind
#    vimPlugins.UltiSnips
#    vimPlugins.YouCompleteMe  # YCM is blocking vim process, probably due to vim plugin architecture.
  ];

  system.activationScripts =
  {
    # install development environments
    dev_environments = ''
      if [ ! -d /home/auntieneo/.nixpkgs/environments ]; then
        mkdir -p /home/auntieneo/.nixpkgs/environments
      fi
      for f in ${../dotfiles/nixpkgs/environments}/*.nix; do
        ln -fs $f /home/auntieneo/.nixpkgs/environments/
      done
    '';
  };

  # custom packages
  nixpkgs.config.packageOverrides = pkgs: rec {
    piglit = pkgs.callPackage ../pkgs/piglit/default.nix { };
    polish-shell = pkgs.callPackage ../pkgs/polish-shell/default.nix { };
    waffle = pkgs.callPackage ../pkgs/waffle/default.nix { };
  };
}
