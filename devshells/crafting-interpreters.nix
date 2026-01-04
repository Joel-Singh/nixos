{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell rec {
  nativeBuildInputs = [
    javaPackages.compiler.openjdk25
    gdb
  ];
}
