{ lib
, python3Packages
, python3
, pkgs
}:

let

  name = "files-to-prompt";

  python = python3.withPackages (ps: [ ps.click ]);

  script = (pkgs.writeScriptBin name
    (''
    #!/usr/bin/env bash

    # Needed to have python see the files_to_prompt module
    export PYTHONPATH="${./.}"

    args=("$@")

    # Pass the args to the python script by properly expanding them out of an array.
    # The weird ''${ syntax is to avoid nix interpreting bash array expansion as a string literally. Crazy.
    ${python}/bin/python3 -c 'from files_to_prompt.cli import cli; cli()' "''${args[@]}"

    '')
    ).overrideAttrs(old: {
    # Patch the script shebang line to use the bash provided by nix.
      buildCommand = "${old.buildCommand}\n patchShebangs $out";
    });
in

script

