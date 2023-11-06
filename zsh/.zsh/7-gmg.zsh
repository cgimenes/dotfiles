if ! [ -x "$(command -v go-many-git)" ]; then
  echo "Installing gmg"
  go install github.com/abrochard/go-many-git@latest
fi
