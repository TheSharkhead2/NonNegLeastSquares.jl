{ pkgs ? import <nixpkgs> { } }:
let lib = pkgs.lib;
in (pkgs.buildFHSUserEnv {
  name = "julia-fhs";
  targetPkgs = pkgs:
    with pkgs; [
      julia
      gnumake
      gcc
      gfortran
      libatomic_ops
      perl
      wget
      curl
      m4
      gawk
      patch
      cmake
      pkg-config
      which

      (python3.withPackages
        (python-pkgs: [ python-pkgs.scipy python-pkgs.numpy ]))
    ];

  # profile = ''
  #   export PYTHON=${pkgs.python3}/bin/python
  # '';
  profile = ''
    export PYTHON=/usr/bin/python
    export PYTHONHOME=${pkgs.python3}/lib/python${
      lib.versions.majorMinor (lib.getVersion pkgs.python3)
    };
  '';
  # profile = ''
  #   export PYTHONPATH=${pkgs.python3}/lib/python${
  #     lib.versions.majorMinor (lib.getVersion pkgs.python3)
  #   }/site-packages;
  # '';
}).env
