let

nixpkgs = import (builtins.fetchTarball {
  url = "https://github.com/NixOS/nixpkgs/archive/3a228057f5b619feb3186e986dbe76278d707b6e.tar.gz";
  sha256 = "0iqla32cwy147lx1jw84174qkf8jyd912vxqjfgggyil1k8fix66";
}) {config = {}; overlays = [];};

pkgs = nixpkgs;

python = pkgs.python3.withPackages (ps: [ ps.click ]);

in

pkgs.mkShell {
  packages = [ python ];
  shellHook = ''
  alias files-to-prompt='python -c "from files_to_prompt.cli import cli; cli()"'
  '';
}
