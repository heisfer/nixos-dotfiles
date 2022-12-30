{ fetchurl
, appimageTools
, lib
}:
let
  name = "miru";
  src = fetchurl {
    url = "https://github.com/ThaUnknown/miru/releases/download/v3.5.0/linux-Miru-3.5.0.AppImage";
    sha256 = "0qakjm8x30w6qip1k6vxq49arqxsg5ciz6rc2lmmh5fbs15kb360";
  };
  appimageContents = appimageTools.extractType2 { inherit name src; };
in appimageTools.wrapType2 {
  inherit name src;

  extraInstallCommands = ''
    
    # Installs .desktop files
    install -Dm444 ${appimageContents}/${name}.desktop -t $out/share/applications
    install -Dm444 ${appimageContents}/${name}.png -t $out/share/pixmaps
    substituteInPlace $out/share/applications/${name}.desktop \
      --replace 'Exec=AppRun --no-sandbox %U' 'Exec=${name}'
  '';
  
}
