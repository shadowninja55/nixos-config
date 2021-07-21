{ stdenv, fetchFromGitHub, ... }:

stdenv.mkDerivation {
  name = "dracula-grub-theme";
  src = fetchFromGitHub {
    owner = "dracula";
    repo = "grub";
    rev = "ad5b6bd4b159fea4950918a5510864ebb551519d";
    sha256 = "12c76qs6p0fpbn4c3i0va5ibr711fgdhhh4ci86hmd5ss93p4b5y";
  };
  installPhase = ''
    mkdir -p $out/grub/themes
    cp -r $src/dracula $out/grub/themes/dracula
  '';
}
