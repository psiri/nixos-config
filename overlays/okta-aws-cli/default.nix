
(self: super: {
  # Customized okta-aws-cli package - override the source to use the unstable version
  okta-aws-cli = super.okta-aws-cli.overrideAttrs (old: {
    version = "2.1.2";
    subPackages = [ "cmd/okta-aws-cli" ];
    src = super.fetchFromGitHub {
      owner = "okta";
      repo = "okta-aws-cli";
      rev = "v2.1.2";
      hash = "sha256-MNaoCefJwUPWYPZ+AtQUHhm1ZKSFq+hCGGAFwBxrbWI=";
      fetchSubmodules = true;
    };
  });
})
