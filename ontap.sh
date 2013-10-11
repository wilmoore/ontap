function ontap {

  local APPNAME='ontap'
  local VERSION='0.0.1'
  local ONTAPRC=~/.ontaprc
  local CURYEAR='2013'

  # argument parsing
  case "$1" in

    "")

      while read line; do 

        # skip commented or blank lines
        [[ "$line" =~ ^\s?# ]] && continue
        [[ "$line" =~ ^\s?$ ]] && continue

        # parse line
        local command=$(echo $line | cut -d" " -f1)
        local formula=$(echo $line | cut -d" " -f2)
        local taprepo=$formula

        # install
        if [[ "$command" = "install" ]]; then
          brew install "$formula"
          continue
        fi

        # tap
        if [[ "$command" = "tap"     ]]; then
          brew tap --repair "$taprepo" 2>/dev/null | head -1 | grep -sqE '^Pruned 0' && \
            printf "\e[4;31m%s\e[0m: %s\n" "Warning" "$taprepo already tapped"       && \
            continue
          brew tap "$taprepo"
        fi

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
