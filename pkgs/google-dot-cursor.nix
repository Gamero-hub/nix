{
  stdenv,
  fetchzip,
  ...
}:
stdenv.mkDerivation rec {
  pname = "google-dot-cursor";
  name = pname;
  version = "latest";

  src = fetchzip {
    url = "https://github.com/ful1e5/Google_Cursor/releases/download/v2.0.0/GoogleDot-Black.tar.gz";
     sha256 = "sha256-pb2U9j1m8uJaILxUxKqp8q9FGuwzZsQvhPP3bfGZL5I=";
  };

  installPhase = ''
    mkdir -p $out/share/icons/GoogleDot-Black
    cp -r * $out/share/icons/GoogleDot-Black
  '';
}
