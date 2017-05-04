with (import <nixpkgs> {});

let ghc = haskell.packages.ghc802;
in
stdenv.mkDerivation {
  name = "xmonad-testing";

  buildInputs = [
    (ghc.ghcWithPackages (pkgs: with pkgs; [
      cabal-install
      packdeps
    ]))

    pkgconfig
    autoconf
    xorg.libX11
    xorg.libXext
    xorg.libXft
    xorg.libXinerama
    xorg.libXpm
    xorg.libXrandr
    xorg.libXrender

    gnupg # sign tags and releases
    rsync # Needed by xmonad-web/gen-docs.sh
  ];

  shellHook = ''
    # Generate the configure script in X11:
    ( test -d x11 && cd x11 && autoreconf -f )
    # Make stack happy:
    export GPG_TTY=`tty`
  '';
}
