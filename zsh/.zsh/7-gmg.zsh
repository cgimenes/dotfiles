if ! [ -x "$(command -v go-many-git)" ]; then
  go get -u github.com/abrochard/go-many-git
  go install github.com/abrochard/go-many-git
fi
