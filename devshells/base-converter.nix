{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell rec {
  nativeBuildInputs = [
    perl
    ccls
    clang-tools
    gdb
  ];
}
