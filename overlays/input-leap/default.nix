
(self: super: {
  # Customized input-leap package - override the source to use the unstable version
  input-leap = super.input-leap.overrideAttrs (old: {
    version = "unstable-2023-12-27";
    src = super.fetchFromGitHub {
      owner = "input-leap";
      repo = "input-leap";
      rev = "ecf1fb6645af7b79e6ea984d3c9698ca0ab6f391";
      hash = "sha256-TEv1xR1wUG3wXNATLLIZKOtW05X96wsPNOlE77OQK54=";
      fetchSubmodules = true;
    };
  });
})