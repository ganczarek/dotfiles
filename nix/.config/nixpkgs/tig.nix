{ pkgs, config, ... }:

{
  home.file."${config.xdg.configHome}/tig/config".text = ''
    # allows to amend commit in status view with 'a' binding
    bind status a !?git commit --amend

    #bind main = !git commit --fixup=%(commit)
    #bind main <Ctrl-R> !git rebase --autosquash -i %(commit)
  '';
}
