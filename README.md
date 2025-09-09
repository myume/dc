# dc

cd backwards

## Nix setup

Add the flake input:

```nix
dc.url = "github:myume/dc";
```

Add the zsh plugin:

```nix
{
  pkgs,
  inputs,
  ...
}: {
  programs.zsh.plugins = [
    ...
    {
      name = "dc";
      src = inputs.dc.packages.${pkgs.system}.default;
      file = "share/dc/dc.plugin.zsh";
    }
  ];
}
```

## For everyone else

1. Build the binary with cargo
2. Update the dc_executable path in `dc.plugin.zsh`
3. Source the plugin in your .zshrc
