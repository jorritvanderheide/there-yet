{
  description = "There Yet";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      treefmt-nix,
      ...
    }:
    let
      androidSdk = androidComposition.androidsdk;
      system = "x86_64-linux";
      treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;

      androidComposition = pkgs.androidenv.composeAndroidPackages {
        buildToolsVersions = [ "35.0.0" ];
        cmakeVersions = [ "3.22.1" ];
        includeEmulator = false;
        includeNDK = true;
        includeSources = false;
        includeSystemImages = false;
        ndkVersions = [ "28.2.13676358" ];

        platformVersions = [
          "34"
          "35"
          "36"
        ];
      };

      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          android_sdk.accept_license = true;
        };
      };

      # SQLite amalgamation (3.50.2). Built from source via the sqlite3 hook
      # configured in pubspec.yaml. Pinned to a specific zip hash; bump
      # `sqliteVersionCode` and `sha256` together when upgrading.
      sqliteVersionCode = "3500200";
      sqliteAmalgamationZip = pkgs.fetchurl {
        url = "https://www.sqlite.org/2025/sqlite-amalgamation-${sqliteVersionCode}.zip";
        sha256 = "387991de2834b5da2894119ff4173a9ea0779ea55ebcf53d9a40b24d1dc2484e";
      };
      sqliteAmalgamation =
        pkgs.runCommand "sqlite-amalgamation-${sqliteVersionCode}"
          {
            nativeBuildInputs = [ pkgs.unzip ];
          }
          ''
            mkdir -p $out
            unzip -j ${sqliteAmalgamationZip} 'sqlite-amalgamation-${sqliteVersionCode}/sqlite3.c' -d $out
          '';
    in
    {
      checks.${system}.formatting = treefmtEval.config.build.check self;
      formatter.${system} = treefmtEval.config.build.wrapper;

      devShells.${system}.default = pkgs.mkShell {
        ANDROID_HOME = "${androidSdk}/libexec/android-sdk";
        ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
        GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${androidSdk}/libexec/android-sdk/build-tools/35.0.0/aapt2";
        JAVA_HOME = "${pkgs.jdk21}";

        buildInputs = with pkgs; [
          androidSdk
          dart
          flutter
          gradle
          jdk21
          mask
          treefmtEval.config.build.wrapper
        ];

        shellHook = ''
          echo "There Yet dev shell"
          # Materialize the pinned SQLite amalgamation into vendor/sqlite/.
          # File is gitignored; the sqlite3 build hook in pubspec.yaml expects
          # it at this path. Only runs when entering the shell from the
          # repo root.
          if [ -f pubspec.yaml ]; then
            mkdir -p vendor/sqlite
            if [ ! -f vendor/sqlite/sqlite3.c ] \
              || ! cmp -s vendor/sqlite/sqlite3.c ${sqliteAmalgamation}/sqlite3.c; then
              cp ${sqliteAmalgamation}/sqlite3.c vendor/sqlite/sqlite3.c
              chmod +w vendor/sqlite/sqlite3.c
            fi
          fi
        '';
      };
    };
}
