SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
 else
    for n in "$@"
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.zip)
                            unzip "$n"         ;;
            *.tar|*.7z|*.gz|*.xz|*.lzma|*.bz|*.bz2|*.lz4|*.sz|*.zst|*.rar|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz)
                            ouch d "$n"        ;;
            *.cbt)          tar xvf "$n"       ;;
            *.cbr)          unrar x -ad ./"$n" ;;
            *.cbz|*.epub)   unzip ./"$n"       ;;
            *.z)            uncompress ./"$n"  ;;
            *.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                            7z x ./"$n"        ;;
            *.exe)          cabextract ./"$n"  ;;
            *.cpio)         cpio -id < ./"$n"  ;;
            *.cba|*.ace)    unace x ./"$n"      ;;
            *)
                            echo "extract: '$n' - unknown archive method"
                            return 1
                            ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

IFS=$SAVEIFS
