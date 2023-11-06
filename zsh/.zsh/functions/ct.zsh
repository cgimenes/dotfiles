ct () {
  set -x

  command_name=!:0
  echo $command_name
    case command_name in
      g|git)
        dir=!:-1
        ;;
      mkdir)
        dir=!:-1
        ;;

    esac
    cd $dir;
}
