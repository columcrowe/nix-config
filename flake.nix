{
  description = "Personal NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    niri.url = "github:sodiboo/niri-flake";

  };

  outputs = inputs@{ self, nixpkgs, home-manager, niri, disko, ... }: {

    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem rec {
      specialArgs = { inherit inputs; };
      modules = [
        ./default.nix
        ./hosts/laptop/configuration.nix
        niri.nixosModules.niri #has to be system
        ({ ... }: {programs.niri.enable = true; })
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
      ];
    };

  };
}
