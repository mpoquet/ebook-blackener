{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/20.03.tar.gz") {}
}:

let
  self = rec {
    inherit pkgs;
    pythonPackages = pkgs.python3Packages;
    buildPythonPackage = pythonPackages.buildPythonPackage;

    ebooklib = buildPythonPackage {
      name = "ebooklib-0.17.1";
      doCheck = false;
      buildInputs = with pythonPackages; [
        six
      ];
      propagatedBuildInputs = with pythonPackages; [
        lxml
      ];
      src = builtins.fetchurl {
        url = "https://files.pythonhosted.org/packages/00/38/7d6ab2e569a9165249619d73b7bc6be0e713a899a3bc2513814b6598a84c/EbookLib-0.17.1.tar.gz";
        sha256 = "1w972g0kmh9cdxf3kjr7v4k99wvv4lxv3rxkip39c08550nf48zy";
      };
    };

    dev-shell = pkgs.mkShell {
      name = "dev-shell";
      buildInputs = [
        pythonPackages.ipython
        pythonPackages.cssutils
        pythonPackages.docopt
        ebooklib
      ];
    };
  };
in
  self
