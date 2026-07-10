function zipfind
    for f in *.zip
        echo "$f: "
        unzip -l $f | grep -i $argv[1]
    end
end
