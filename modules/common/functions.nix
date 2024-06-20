{
  config,
  pkgs,
  scriptsPath,
}: {
  dotfilesSymlink = path: config.lib.file.mkOutOfStoreSymlink ("${config.home.homeDirectory}/documents/dev/nubosa/dotfiles/" + path);

  createScript = scriptName: pkgs.writeShellScriptBin (builtins.elemAt (pkgs.lib.strings.splitString "." scriptName) 0) (builtins.readFile (scriptsPath + "/${scriptName}"));
}
