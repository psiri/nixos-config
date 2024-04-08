
(self: super: lib: {
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

    vendorHash = "sha256-SjABVO6tHYRc/1pYjOqfZP+NfnK1/WnAcY5NQ4hMssE=";

    ldflags = [ "-s" "-w" ];

    meta = with lib; {
      description = "A CLI for having Okta as the IdP for AWS CLI operations";
      homepage = "https://github.com/okta/okta-aws-cli";
      license = licenses.asl20;
      maintainers = with maintainers; [ daniyalsuri6 ];
      mainProgram = "okta-aws-cli";
    };
  });
})
