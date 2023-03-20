{ pkgs ? (
    let
      inherit (builtins) fetchTree fromJSON readFile;
      inherit ((fromJSON (readFile ./flake.lock)).nodes) nixpkgs gomod2nix;
    in
    import (fetchTree nixpkgs.locked) {
      overlays = [
        (import "${fetchTree gomod2nix.locked}/overlay.nix")
      ];
    }
  )
}:

pkgs.buildGoApplication {
  pname = "streamdeck-cmd";
  version = "1.7.0";
  pwd = ./.;
  src = ./cmd/streamdeck;
  modules = ./cmd/streamdeck/gomod2nix.toml;
  subpackage=["streamdeck" ];
  buildInputs = [ pkgs.udev ];
}
