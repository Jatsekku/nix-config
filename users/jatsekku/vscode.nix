{
  pkgs,
  lib,
  config,
  inputs,
  outputs,
  myLib,
  username,
  ...
}:
{
  programs.vscode.extensions =
    with pkgs.vscode-extensions;
    [
      ms-azuretools.vscode-docker
      vscodevim.vim
    ]
    ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "remote-containers";
        publisher = "ms-vscode-remote";
        version = "0.218.0";
        sha256 = "4Li0sYfHOsJMn5FJtvDTGKoGPcRmoosD9tZ7q9H9DfQ=";
      }
    ];
}
