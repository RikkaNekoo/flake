_:{
  virtualisation.oci-containers.containers."autodiscover" = {
    image = "monogramm/autodiscover-email-settings:latest";
    environment = {
      "COMPANY_NAME" = "RikkaMail";
      "SUPPORT_URL" = "https://mail.rikka.im";
      "DOMAIN" = "rikka.im";
      "IMAP_HOST" = "mail.rikka.im";
      "IMAP_PORT" = "993";
      "IMAP_SOCKET" = "SSL";
      "SMTP_HOST" = "mail.rikka.im";
      "SMTP_PORT" = "587";
      "SMTP_SOCKET" = "STARTTLS";
      "PROFILE_IDENTIFIER" = "im.rikka.autodiscover";
      "PROFILE_UUID" = "a1b62d77-92be-4586-9ef6-290555c8f7e2";
      "MAIL_UUID" = "2298f4dc-10dd-4078-af1b-ac75a26e09a7";
      "LDAP_UUID" = "b0d3cde7-bfde-4281-bffc-cad0d723a337";
    };
    log-driver = "journald";
    extraOptions = [
      "--network=rikka"
    ];
  };
}