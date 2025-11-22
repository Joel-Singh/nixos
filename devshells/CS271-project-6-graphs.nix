{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell rec {
  nativeBuildInputs = [
    gtest
    ccls
    sfml
    bear
    clang-tools # For clang-format
    doxygen
    gdb
  ];
}
