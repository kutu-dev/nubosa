{
  config,
  pkgs,
  scriptsPath,
}: 
let
  genericDotfilesSymlink = path: platformName: config.lib.file.mkOutOfStoreSymlink ("${config.home.homeDirectory}/documents/dev/nubosa/platform/${platformName}/dotfiles/" + path);

in
{
  inherit genericDotfilesSymlink;

  dotfilesSymlink = path: genericDotfilesSymlink path "common";

  createScript = scriptName: pkgs.writeShellScriptBin (builtins.elemAt (pkgs.lib.strings.splitString "." scriptName) 0) (builtins.readFile (scriptsPath + "/${scriptName}"));
}
