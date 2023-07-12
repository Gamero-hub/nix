{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  pname = "Dank-Mono-Font";
  version = "1.0.0";
  src = fetchFromGitHub {
    owner = "notshekhar";
    repo = "Dank-Mono-Font";
    rev = "3c6a54ffb6c892aec158a92a769d480f30628b19";
    sha256 = "0abwjpipgn86ka74145dm60pyjihgrj2qly4c7jrbwnm21qkfnw1";
    fetchSubmodules = false;
  };

  installPhase = ''
    mkdir -p $out/share/fonts
    cp -R $src/*.ttf $out/share/fonts
  '';

  meta.description = "Dank Mono font!";
}
