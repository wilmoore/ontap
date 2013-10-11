function ontap {

  local APPNAME='ontap'
  local VERSION='0.0.1'
  local ONTAPRC=~/.ontaprc

  # argument parsing
  case "$1" in

    install)

      while read line
      do 

        # skip commented or blank lines
        [[ "$line" =~ ^\s?# ]] && continue
        [[ "$line" =~ ^\s?$ ]] && continue

        # parse line
        local command=$(echo $line | cut -d" " -f1)
        local formula=$(echo $line | cut -d" " -f2)
        local taprepo=$formula

        # install or tap
        [[ "$command" = "install" ]] && brew install "$formula"
        [[ "$command" = "tap"     ]] && brew tap     "$taprepo"

      done <$ONTAPRC

      return 0
      ;;

    -v|--version)

      echo "$APPNAME version $VERSION"

      return 0
      ;;

    -h|--help|*)

      echo "$APPNAME $VERSION"
      echo ''
      echo "Usage: $APPNAME install"
      echo ''

      return 0
      ;;

  esac

}

ontap install
