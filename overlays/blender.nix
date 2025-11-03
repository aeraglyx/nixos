# heavily inspired by https://github.com/edolstra/nix-warez

final: prev:
let

    mkBlender = { pname, version, src }:
        with final;

        let
            libs = [
                wayland
                libdecor
                xorg.libX11
                xorg.libXi
                xorg.libXxf86vm
                xorg.libXfixes
                xorg.libXrender
                libxkbcommon
                libGLU
                libglvnd
                numactl
                SDL2
                libdrm
                ocl-icd
                stdenv.cc.cc.lib
                openal
                alsa-lib
                pulseaudio
            ] ++ lib.optionals (lib.versionAtLeast version "3.5") [
                xorg.libSM
                xorg.libICE
                zlib
            ];
        in

        stdenv.mkDerivation rec {
            inherit pname version src;

            buildInputs = [ makeWrapper ];

            preUnpack =
                ''
                    mkdir -p $out/libexec
                    cd $out/libexec
                '';

            installPhase =
                ''
                    cd $out/libexec
                    mv blender-* blender

                    mkdir -p $out/share/applications
                    mv ./blender/blender.desktop $out/share/applications/blender-new.desktop

                    substituteInPlace $out/share/applications/blender-new.desktop \
                        --replace "Name=Blender" "Name=Blender New" \
                        --replace "Exec=blender" "Exec=blender-new" \
                        --replace "Icon=blender" "Icon=blender-new"

                    mkdir $out/bin
                    makeWrapper $out/libexec/blender/blender $out/bin/blender-new \
                        --prefix LD_LIBRARY_PATH : /run/opengl-driver/lib:${lib.makeLibraryPath libs}

                    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
                        blender/blender

                    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)"  \
                        $out/libexec/blender/*/python/bin/python3*
                '';

            meta.mainProgram = "blender-new";
        };

in {

    blender_5_0 = mkBlender {
        pname = "blender-bin";
        version = "5.0.0";
        src = import <nix/fetchurl.nix> {
            url = "https://cdn.builder.blender.org/download/daily/archive/blender-5.0.0-beta+v50.88d0f8820ef0-linux.x86_64-release.tar.xz";
            hash = "sha256-fO8RaYN31OFjddouhrATT+4M5PDlmS0l3kfCVMMwnXE=";
        };
    };

}
