{
  description = "A very basic flake";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nix-filter.url = "github:numtide/nix-filter";
  inputs.gomod2nix = {
      url = "github:tweag/gomod2nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "flake-utils";
    };

  outputs = { self, nixpkgs, flake-utils, gomod2nix, nix-filter }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          gomod2nix.overlays.default
        ];
      };
    in {
      packages.default = pkgs.buildGoModule rec {
        pname = "streamdeck";
        version = "0.1";
        root = ./.;
        src = nix-filter.lib.filter {
          root = ./.;
            include = [
              "streamdeck.go"
              "go.mod"
              "go.sum"
            ];
        };
        vendorHash = null;
        buildInputs = with pkgs; [
          hidapi
        ];
      };
    });
}
