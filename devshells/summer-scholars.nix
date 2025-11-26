{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell rec {
  nativeBuildInputs = [
    libertine
    inconsolata
  ];

  buildInputs = [
  ];
}
