
(self: super: {
  # Customized input-leap package
  input-leap = super.input-leap.overrideAttrs (old: {
    #version = "unstable-2023-12-27";
    src = super.fetchFromGitHub {
      owner = "input-leap";
      repo = "input-leap";
      rev = "ecf1fb6645af7b79e6ea984d3c9698ca0ab6f391";
      hash = "sha256-TEv1xR1wUG3wXNATLLIZKOtW05X96wsPNOlE77OQK54=";
      fetchSubmodules = true;
    };
  });
  #input-leap = builtins.fetchTarball https://github.com/input-leap/input-leap/archive/refs/tags/v2.4.0.tar.gz
  #"https://github.com/input-leap/input-leap/releases/download/1.30.0/dhall-1.30.0-x86_64-linux.tar.bz2";
})