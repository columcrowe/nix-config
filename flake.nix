{
  description = "Personal NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    niri.url = "github:sodiboo/niri-flake";
    niri.inputs.nixpkgs.follows = "nixpkgs";
    
    qtile.url = "github:qtile/qtile";
    qtile.inputs.nixpkgs.follows = "nixpkgs";
    
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    stratoshark.url = "path:/home/columcc/nixpkgs/stratoshark";
    stratoshark.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = inputs@{ self, nixpkgs, home-manager, niri, qtile, disko, stratoshark,... }: {

    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem rec {
      specialArgs = { inherit inputs; };
      modules = [
        { nixpkgs.overlays = [ stratoshark.overlays.default ]; }
        stratoshark.nixosModules.stratoshark
        ({...}: { programs.stratoshark.enable = true; })
        ./default.nix
        ./hosts/laptop/configuration.nix
        niri.nixosModules.niri #has to be system
        ({ ... }: {programs.niri.enable = true; })
        #({...}: {services.xserver = {
        #  enable = true;
        #  windowManager.qtile = {
        #    enable = true;
        #  };
        #}; })
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = specialArgs;
          home-manager.backupFileExtension = "bak";
          home-manager.users.columcc = {
            imports = [ 
              ./home.nix
            ];
          };
        }
      ];
    };

    #TEMPLATE
    nixosConfigurations.pc = nixpkgs.lib.nixosSystem rec {
      specialArgs = { inherit inputs; };
      modules = [
        ./default.nix
        ./hosts/pc/configuration.nix
        ({ ... }: {networking.hostName = "pc"; })
        disko.nixosModules.disko
        ./hosts/pc/disk-configuration.nix
        {
          _module.args.disks = [ "/dev/sdX" ];
        }
      ];
    };

  };
}
