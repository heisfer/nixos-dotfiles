{ lib
, stdenv
, fetchFromGitHub
, testVersion
, hello
, docker
, bash
, subversion
, makeWrapper
, gettext
, ...
}:

stdenv.mkDerivation rec {
  pname = "den";
  version = "indev";
  

  src = fetchFromGitHub {
    owner = "swiftotter";
    repo  = "den";
    rev   = "81aa88c4dc5e8cac6ad8bb3f8d5e77e9e6b19504";
    sha256 = "13khqqnq5g0s3j1xdsq0d819s9cgqm5dz12ksc86jh7xi55kxgf8";
  };

  buildInputs = [ bash subversion gettext ];
  nativeBuildInputs = [ makeWrapper ];
  installPhase = ''
    mkdir -p $out/bin
    cp -r ./* $out/
    wrapProgram $out/bin/den \
        --prefix PATH : ${lib.makeBinPath [ bash subversion ]}

  '';

  meta = with lib; {
    description = "Den - The home for all your projects - A docker orchestration utility";
    homepage = "https://swiftotter.github.io/den/";
    license  = licenses.mit;
    platforms = platforms.linux;
    maintainers = [ maintainers.heisfer ];
  };
}
