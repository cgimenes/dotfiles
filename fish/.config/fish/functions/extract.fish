function extract
    if test (count $argv) -eq 0
        echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
        echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
        return 1
    end
    for n in $argv
        if test -f $n
            switch $n
                case '*.zip'
                    unzip $n
                case '*.tar' '*.7z' '*.gz' '*.xz' '*.lzma' '*.bz' '*.bz2' '*.lz4' '*.sz' '*.zst' '*.rar' '*.tar.bz2' '*.tar.gz' '*.tar.xz' '*.tbz2' '*.tgz' '*.txz'
                    ouch d $n
                case '*.cbt'
                    tar xvf $n
                case '*.cbr'
                    unrar x -ad ./$n
                case '*.cbz' '*.epub'
                    unzip ./$n
                case '*.z'
                    uncompress ./$n
                case '*.arj' '*.cab' '*.cb7' '*.chm' '*.deb' '*.dmg' '*.iso' '*.lzh' '*.msi' '*.pkg' '*.rpm' '*.udf' '*.wim' '*.xar'
                    7z x ./$n
                case '*.exe'
                    cabextract ./$n
                case '*.cpio'
                    cpio -id < ./$n
                case '*.cba' '*.ace'
                    unace x ./$n
                case '*'
                    echo "extract: '$n' - unknown archive method"
                    return 1
            end
        else
            echo "'$n' - file does not exist"
            return 1
        end
    end
end
