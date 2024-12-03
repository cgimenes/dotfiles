.PHONY: archlinux
archlinux:
	cd archlinux && docker build . -t cgimenes/archlinux

php:
	cd archlinux/php && docker build . -t cgimenes/php-dev
	distrobox create -i cgimenes/php-dev -n php -Y

ruby:
	cd archlinux/ruby && docker build . -t cgimenes/ruby-dev
	distrobox create -i cgimenes/ruby-dev -n ruby -Y
