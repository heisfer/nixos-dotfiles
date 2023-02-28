{ fetchurl
, appimageTools
, lib
}:
let
  name = "miru";
  src = fetchurl {
    url = "https://github.com/ThaUnknown/miru/releases/download/v3.7.4/linux-Miru-3.7.4.AppImage";
    sha256 = "sha256-KO3/NWfix+NKOFi9wmID5B5Mdq9RPT12YMn5KFGkGwA=";
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
