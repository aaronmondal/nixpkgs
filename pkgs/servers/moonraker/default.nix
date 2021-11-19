{ lib, stdenvNoCC, fetchFromGitHub, python3, makeWrapper, unstableGitUpdater }:

let
  pythonEnv = python3.withPackages (packages: with packages; [
    tornado
    pyserial
    pillow
    lmdb
    streaming-form-data
    distro
    inotify-simple
    libnacl
    paho-mqtt
    pycurl
  ]);
in stdenvNoCC.mkDerivation rec {
  pname = "moonraker";
  version = "unstable-2021-11-13";

  src = fetchFromGitHub {
    owner = "Arksine";
    repo = "moonraker";
    rev = "bed239c90a3b5fef5c6bf4559a774b9d09987c30";
    sha256 = "2gnW6dPsKMfoZnjs9F3opxRCeym+P43ZJOmGM44twfw=";
  };

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out $out/bin $out/lib
    cp -r moonraker $out/lib

    makeWrapper ${pythonEnv}/bin/python $out/bin/moonraker \
      --add-flags "$out/lib/moonraker/moonraker.py"
  '';

  passthru.updateScript = unstableGitUpdater { url = meta.homepage; };

  meta = with lib; {
    description = "API web server for Klipper";
    homepage = "https://github.com/Arksine/moonraker";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ zhaofengli ];
  };
}
