{
  inputs = {
    naersk.url = "github:nix-community/naersk/master";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils, naersk }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        naersk-lib = pkgs.callPackage naersk { };
      in
      {
        defaultPackage = naersk-lib.buildPackage ./.;
        devShell = with pkgs; mkShell {
          buildInputs = [
            cargo
            rustc
            rustfmt
            rustPackages.clippy

            alsa-lib.dev
            udev.dev 
            xorg.libX11
            xorg.libXrandr
            xorg.libXcursor
            xorg.libxcb
            xorg.libXi
            wayland
            libxkbcommon
            libxkbcommon.dev
            vulkan-loader
            vulkan-tools
            glfw
            xorg.xf86videoamdgpu
          ];
          nativeBuildInputs = with pkgs; [
            pkg-config
          ];
          RUST_SRC_PATH = rustPlatform.rustLibSrc;
        };
      }
    );
}
