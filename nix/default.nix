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
  cargoToml = builtins.fromTOML (builtins.readFile ../core/Cargo.toml);
in
  rustPlatform.buildRustPackage rec {
    pname = cargoToml.package.name;
    version = cargoToml.package.version;

    src = ../.;

    buildInputs = [
      pkg-config
      openssl
      cpuid
      libcpuid
      libffi
      file
    ];

    cargoLock = {inherit lockFile;};

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
