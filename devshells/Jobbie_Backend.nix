{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell rec {
  nativeBuildInputs = [
    dotnetCorePackages.sdk_8_0_3xx-bin
    kubectl
    docker
  ];
}
