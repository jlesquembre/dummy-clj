{
  description = "A flake for clojure projects";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    devshell.url = "github:numtide/devshell";
  };
  outputs = { self, nixpkgs, flake-utils, devshell }@inputs:

    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            devshell.overlay
          ];
        };
      in

      {
        packages = { };

        devShells.default =
          pkgs.devshell.mkShell {
            packages = [
              (pkgs.clojure.override { jdk = pkgs.jdk17; })
              pkgs.clojure-lsp
              pkgs.jdk
            ];
            commands = [
              {
                name = "run-test";
                help = "Run tests";
                command =
                  ''
                    clj -X:test
                  '';
              }
            ];
          };

      });

}
