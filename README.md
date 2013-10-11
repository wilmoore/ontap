# Automate your favorite formulae and taps

`ontap` reads your `~/.ontaprc` and takes action on any `install FORMULA` or `tap REPO` lines it finds.

## Install

    % curl -sSL https://raw.github.com/wilmoore/ontap/master/ontap.sh > /tmp/ontap.sh
    % source /tmp/ontap.sh

**NOTE**: optionally, put `ontap.sh` somewhere a little more permanent and `source` it via your `.bashrc` or `.zshrc`.

## Configure

    % $EDITOR ~/.ontaprc

![](https://cloudup.com/ceBATd5bKAu+)

## Grab everything that is on tap

    % ontap

![](https://cloudup.com/cmZTLXBkeGV+)

## LICENSE

  MIT

