{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell rec {
  nativeBuildInputs = [
    javaPackages.compiler.openjdk8
    dart
  ];
}
