{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.hello;
    
    signing = {
      key = "FB028A23305D6A65";
      signByDefault = true;
      signer = "/usr/bin/gpg2";
    };

    settings = {
      user = {
        name = "Rafal Ganczarek";
        email = "16733667+ganczarek@users.noreply.github.com";
      };

      core = {
        # Treat spaces before tabs and all kinds of trailing whitespace as an error
        # [default] trailing-space: looks for spaces at the end of a line
        # [default] space-before-tab: looks for spaces before tabs at the beginning of a line
        whitespace = "space-before-tab,-indent-with-non-tab,trailing-space";

        # Make `git rebase` safer on macOS
        # More info: <http://www.git-tower.com/blog/make-git-rebase-safe-on-osx/>
        trustctime = false;

        # Prevent showing files whose names contain non-ASCII symbols as unversioned.
        # http://michael-kuehnel.de/git/2014/11/21/git-mac-osx-and-german-umlaute.html
        precomposeunicode = false;

        # Consider changing, if you are on Windows
        # See https://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration for more info
        autocrlf = "input";

        editor = "nvim";
        excludesfile = "${config.xdg.configHome}/git/ignore";
      };

      diff = {
        # Detect copies as well as renames
        renames = "copies";
        external = "difft";
        algorithm = "histogram";
      };

      "diff \"bin\"" = {
        # Use `hexdump` to diff binary files
        textconv = "hexdump -v -C";
      };

      help = {
        # Automatically correct and execute mistyped commands
        autocorrect = 1;
      };

      # always push the local branch to a remote branch with the same name
      push = { default = "current"; };
      pull = { rebase = false; };
      merge = {
        tool = "meld";
        conflictStyle = "zdiff3";
      };
      rebase = {
        # automatically squash all fixup commits during rebase
        autoSquash = true;
      };
      commit = {
      # https://help.github.com/articles/signing-commits-using-gpg/
        gpgSign = true;
        verbose = true;
      };
      init = { defaultBranch = "main"; };

      "mergetool \"idea\"" = {
        cmd = "/usr/local/bin/idea merge $(cd $(dirname \"$LOCAL\") && pwd)/$(basename \"$LOCAL\") $(cd $(dirname \"$REMOTE\") && pwd)/$(basename \"$REMOTE\") $(cd $(dirname \"$BASE\") && pwd)/$(basename \"$BASE\") $(cd $(dirname \"$MERGED\") && pwd)/$(basename \"$MERGED\")";
        trueExitCode = true;
      };

      transfer = { fsckObjects = true; };
      fetch = { fsckObjects = true; };
      receive = { fsckObjects = true; };
      log = { date = "iso"; };


      alias = {
        lol = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
        logv = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";

        stash-pr = "!sh -c 'stash pull-request $0 $@'";
        hub-pr = "!sh -c 'hub pull-request $0 $@'";

        # git change-commits GIT_COMMITTER_NAME "old name" "new name"
        #change-commits = "!f() { VAR=$1; OLD=$2; NEW=$3; shift 3; git filter-branch --env-filter \"if [ \\"$echo $VAR\\" = \\"$OLD\\" ]; then export $VAR=\\"$NEW\\"; fi\" $@; }; f" ];

        permission-reset = "!git diff -p -R --no-color | grep -E \"^(diff|(old|new) mode)\" --color=never | git apply";

        # Recreate the last commit using the previous commit message (useful if a commit failed to be created)
        recommit = "!git commit -c .git/COMMIT_EDITMSG";
      };
    };
  
    ignores = [
      ".idea"
      "*.iml"
      ".DS_Store" # MacOS
      ".python-version" # pyenv
      ".java-version" # jenv
      ".tool-versions" # asdf
      ".envrc" # direnv
    ];

    includes = [
      { path = "${config.xdg.configHome}/git/config.local"; }
      {
        path = "~/workspace/jlp/.gitconfig";
        condition = "gitdir:~/workspace/jlp/";
      }
    ];

  };
}
