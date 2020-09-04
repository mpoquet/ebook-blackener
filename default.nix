{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/20.03.tar.gz") {}
}:

let
  self = rec {
    inherit pkgs;
    pythonPackages = pkgs.python3Packages;
    buildPythonPackage = pythonPackages.buildPythonPackage;

    ebook-blackener = buildPythonPackage {
      name = "ebook-blackener-0.1.0";
      doCheck = false;
      propagatedBuildInputs = with pythonPackages; [
        cssutils
        docopt
      ];
      src = ./.;
    };

    dev-shell = pkgs.mkShell {
      name = "dev-shell";
      buildInputs = [
        pythonPackages.ipython
      ] ++ ebook-blackener.propagatedBuildInputs;
    };
  };
in
  self
