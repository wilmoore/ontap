## Declare and install homebrew formulae and taps

> deprecated in favor of brew bundle and brew bundle-dir

`ontap` reads your `~/.ontaprc` and takes action on any `install FORMULA`, `unlink FORMULA` or `tap REPO` lines it finds.

## Install

    % curl -sSL https://raw.github.com/wilmoore/ontap/master/ontap.sh > /tmp/ontap.sh
    % source /tmp/ontap.sh

**NOTE**: optionally, put `ontap.sh` somewhere a little more permanent and `source` it via your `.bashrc` or `.zshrc`.

## Configure

    % $EDITOR ~/.ontaprc

![](https://cloudup.com/cURLdBDcAWG+)

[example ~/.ontaprc](https://github.com/wilmoore/dotfiles/blob/master/active/.ontaprc)

## Grab everything that is on tap

    % ontap

![](https://cloudup.com/cmZTLXBkeGV+)

## LICENSE

  MIT

