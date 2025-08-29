{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell rec {
  nativeBuildInputs = [
    cmake
    gtest
    ccls
    sfml
    bear
    clang-tools # For clang-format
    doxygen
    gdb
    hello
    cpulimit
  ];

  buildInputs = [
    flac
    freetype
    glew
    libjpeg
    libvorbis
    openal
    udev
    xorg.libXi
    xorg.libX11
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXrender
    xorg.xcbutilimage
  ];
}
