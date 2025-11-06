{
  network.description = "Deploy Varnish + Caddy to existing NixOS host";
  myvm = { config, pkgs, ... }: {
    imports = [
      <nixpkgs/nixos/modules/virtualisation/google-compute-image.nix>
    ];
    deployment.targetHost = "34.29.51.158";
    deployment.targetUser = "colum_crowe_gmail_com";
    services.varnish = {
      enable = true;
      package = pkgs.varnish;
      #http_address = "0.0.0.0:6081";
      config = ''
        vcl 4.0;

        backend default {
          .host = "127.0.0.1";
          .port = "8001";
        }
      '';
    };

    services.caddy.enable = true;
    services.caddy.virtualHosts.":8001" = {
      extraConfig = ''
        respond "Hello, world!"
      '';
    };
        #root * /www/columcrowe
        #encode gzip
        #file_server
    services.caddy.virtualHosts."columcrowe.eu" = {
      extraConfig = ''
        reverse_proxy 127.0.0.1:6081
      '';
    };
    services.caddy.virtualHosts."www.columcrowe.eu" = {
      extraConfig = ''
        redir https://columcrowe.eu{uri} permanent
      '';
    };
    #redir https://{host}{uri} permanent
    services.caddy.virtualHosts.":80" = {
      extraConfig = ''
        redir https://columcrowe.eu{uri} permanent
      '';
    };
    networking.firewall.enable = false;
  };
}

