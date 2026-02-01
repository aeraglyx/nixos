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
                xorg.libSM
                xorg.libICE
                zlib
            ];
        in

        stdenv.mkDerivation {
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
                    mv ./blender/blender.desktop $out/share/applications/blender-${version}.desktop

                    substituteInPlace $out/share/applications/blender-${version}.desktop \
                        --replace "Name=Blender" "Name=Blender ${version}" \
                        --replace "Exec=blender" "Exec=blender-${version}" \
                        --replace "Icon=blender" "Icon=blender-${version}"

                    mkdir $out/bin
                    makeWrapper $out/libexec/blender/blender $out/bin/blender-${version} \
                        --prefix LD_LIBRARY_PATH : /run/opengl-driver/lib:${lib.makeLibraryPath libs}

                    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
                        blender/blender

                    patchelf --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)"  \
                        $out/libexec/blender/*/python/bin/python3*
                '';

            meta.mainProgram = "blender-${version}";
        };

in {

    blender_5_0 = mkBlender {
        pname = "blender-bin";
        version = "5.0.1";
        src = import <nix/fetchurl.nix> {
            url = "https://download.blender.org/release/Blender5.0/blender-5.0.1-linux-x64.tar.xz";
            hash = "sha256-gBlYDuG3Ji5QX0GWoAI3zPdDyI0gWzjTQgFRBnbmCwk=";
        };
    };

    blender_5_1 = mkBlender {
        pname = "blender-bin";
        version = "5.1.0";
        src = import <nix/fetchurl.nix> {
            url = "https://cdn.builder.blender.org/download/daily/blender-5.1.0-alpha+main.28e68221175f-linux.x86_64-release.tar.xz";
            hash = "sha256-Yfda7gGJGgMQ01mj2te/ZnkPpOrBAb/vZHpVRWzipxE=";
        };
    };

}
