{
  inputs,
  lib,
  makeWrapper,
  rustPlatform,
  pkg-config,
  openssl,
  cpuid,
  libcpuid,
  libffi,
  rustfmt,
  rustc,
  cargo,
  file,
  lockFile,
}: let
  cargoToml = builtins.fromTOML (builtins.readFile ../Cargo.toml);
in
  rustPlatform.buildRustPackage {
    pname = "lodestone_core";
    version = "0.5.0-beta.2";
    src = ../.;

    buildInputs = [
      pkg-config
      openssl
      cpuid
      libcpuid
      libffi
      file
    ];

    cargoLock = {
      lockFile = ../Cargo.lock;
      allowBuiltinFetchGit = true;
      outputHashes = {
        "safe-path-0.1.0" = "sha256-udvN/jxnE9kWWRXypgw8NLYx8xbQkZJRyGrV+fdxkKo=";
        "sqlx-0.6.2" = "sha256-+A5po+rvD7jQYqY+1zhPiDHCZxrwN7E/Lgg7hEqAEO0=";
      };
    };

    buildFeatures = ["vendored-openssl"];

    checkInputs = [cargo rustc];

    nativeBuildInputs = [
      pkg-config
      makeWrapper
      rustfmt
      rustc
      cargo
    ];

    doCheck = true;

    CARGO_BUILD_INCREMENTAL = "false";
    RUST_BACKTRACE = "full";
    copyLibs = true;

    postInstall = ''
      wrapProgram $out/bin/lodestone_cli
    '';

    meta = with lib; {
      description = "A free, open source server hosting tool for Minecraft and other multiplayers.";
      homepage = "https://github.com/Lodestone-Team/lodestone";
      license = with licenses; [agpl3Only];
      maintainers = [
        {
          email = "alph4nir@riseup.net";
          github = "DrMkdaddy";
          githubId = 37319157;
        }
      ];
    };
  }
