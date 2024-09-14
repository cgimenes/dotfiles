function zfind {
    for f in *.zip; do echo "$f: "; unzip -l $f | grep -i $1; done
}
