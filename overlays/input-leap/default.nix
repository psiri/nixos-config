(self: super: {
    # Customized input-leap package
    input-leap = builtins.fetchTarball https://github.com/input-leap/input-leap/archive/refs/tags/v2.4.0.tar.gz
    #"https://github.com/input-leap/input-leap/releases/download/1.30.0/dhall-1.30.0-x86_64-linux.tar.bz2";
})