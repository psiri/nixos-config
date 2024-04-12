{
  config,
  user,
  ...
}: {
  home-manager.users.${user}.home.file.".config/hypr/hyprlock.conf" = {
    text = ''
general {
    ignore_empty_input = true       # skips validation when empty password is provided
    hide_cursor = true              # hides the cursor instead of making it visible
    pam_module = hyprlock           # sets the pam module used for authentication. If the module is not found in /etc/pam.d, “su” will be used as a fallback
}
    '';
  };
}