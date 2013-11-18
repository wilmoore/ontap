function ontap {

  local APPNAME='ontap'
  local VERSION='0.1.0'
  local ONTAPRC=~/.ontaprc
  local CURYEAR='2013'

  # argument parsing
  case "$1" in

    "")

      # $ONTAPRC should exist; otherwise, noop
      [[ -e "$ONTAPRC" ]] || ONTAPRC=/dev/null

      # update formulae
      brew update

      # upgrade to avoid install errors (plus it's a good idea anyhow)
      brew upgrade

      while read line; do

        # skip commented or blank lines
        [[ "$line" =~ ^\s?# ]] && continue
        [[ "$line" =~ ^\s?$ ]] && continue

        # parse line
        local command="$(echo $line | awk '{ print $1 }')"
        local formula="$(echo $line | awk '{ print $2 }')"
        local taprepo="$formula"
        local options="$(echo $line | awk '{$1=$2=""; print}' | xargs)"

        # install
        if [[ "$command" = "install" ]]; then

          if [[ -n "$options" ]]; then
            brew install $formula $options
          else
            brew install "$formula"
          fi

          hash -r
          continue
        fi

        # cask-install
        if [[ "$command" = "cask-install" ]]; then

          if [[ -n "$options" ]]; then
            brew cask info $formula | grep -qE '^Not installed' && brew cask install $formula $options && contine
            printf "\e[4;31m%s\e[0m: %s\n" "Warning" "$formula already installed" && continue
          else
            brew cask info $formula | grep -qE '^Not installed' && brew cask install "$formula" && continue
            printf "\e[4;31m%s\e[0m: %s\n" "Warning" "$formula already installed" && continue
          fi

          hash -r
          continue
        fi

        # cask-alfred
        if [[ "$command" = "cask-alfred" ]]; then
          brew cask alfred "$formula"
          continue
        fi

        # unlink
        if [[ "$command" = "unlink" ]]; then
          brew unlink "$formula"
          hash -r
          continue
        fi

        # tap
        if [[ "$command" = "tap"     ]]; then
          brew tap --repair "$taprepo" 2>/dev/null | head -1 | grep -sqE '^Pruned 0' && \
            printf "\e[4;31m%s\e[0m: %s\n" "Warning" "$taprepo already tapped"       && \
            continue
          brew tap "$taprepo"
        fi

        # command not supported
        printf "\e[4;31m%s\e[0m: %s\n" "Error" "$command not supported"
        return 1

      done <$ONTAPRC

      return 0
      ;;

    -v|--version)

      echo "$APPNAME version $VERSION"
      echo ""

      return 0
      ;;

    -h|--help|*)

      cat <<USAGESTRING
      Usage: ${APPNAME}

        Options:

         -v, --version  Display the version of ${PROGNAME}.
         -h, --help     Display help information.

      ----
      ${APPNAME}@${VERSION}
      © 2013-${CURYEAR} Wil Moore III, All rights reserved.

USAGESTRING

      return 0
      ;;

  esac

}
