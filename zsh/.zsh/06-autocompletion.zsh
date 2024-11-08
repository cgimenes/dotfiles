# Cache completion results
() {
	setopt local_options
	setopt extendedglob

	local zcd=${1}
	local zcomp_hours=${2:-24} # how often to regenerate the file
	local lock_timeout=${2:-1} # change this if compinit normally takes longer to run
	local lockfile=${zcd}.lock

	if [ -f ${lockfile} ]; then
		if [[ -f ${lockfile}(#qN.mm+${lock_timeout}) ]]; then
			(
				echo "${lockfile} has been held by $(< ${lockfile}) for longer than ${lock_timeout} minute(s)."
				echo "This may indicate a problem with compinit"
			) >&2
		fi
		# Exit if there's a lockfile; another process is handling things
		return
	else
		# Create the lockfile with this shell's PID for debugging
		echo $$ > ${lockfile}
		# Ensure the lockfile is removed
		trap "rm -f ${lockfile}" EXIT
	fi

	autoload -Uz compinit

	if [[ -n ${zcd}(#qN.mh+${zcomp_hours}) ]]; then
		# The file is old and needs to be regenerated
		compinit
	else
		# The file is either new or does not exist. Either way, -C will handle it correctly
		compinit -C
	fi
} ${ZDOTDIR:-$HOME}/.zcompdump

# fixme - the load process here seems a bit bizarre
zmodload -i zsh/complist

unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu         # show completion menu on successive tab press
setopt complete_in_word
setopt always_to_end

# should this be in keybindings?
bindkey -M menuselect '^o' accept-and-infer-next-history
zstyle ':completion:*:*:*:*:*' menu select

# case insensitive (all), partial-word and substring completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'

# Complete . and .. special directories
zstyle ':completion:*' special-dirs true

zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

zstyle ':completion:*:*:*:*:processes' command "ps -u $USERNAME -o pid,user,comm -w -w"

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path $ZSH_CACHE_DIR

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
        clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
        gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
        ldap lp mail mailman mailnull man messagebus mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
        operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
        usbmux uucp vcsa wwwrun xfs '_*'

# ... unless we really want to.
zstyle '*' single-ignored show

if [[ ${COMPLETION_WAITING_DOTS:-false} != false ]]; then
  expand-or-complete-with-dots() {
    # use $COMPLETION_WAITING_DOTS either as toggle or as the sequence to show
    [[ $COMPLETION_WAITING_DOTS = true ]] && COMPLETION_WAITING_DOTS="%F{red}…%f"
    # turn off line wrapping and print prompt-expanded "dot" sequence
    printf '\e[?7l%s\e[?7h' "${(%)COMPLETION_WAITING_DOTS}"
    zle expand-or-complete
    zle redisplay
  }
  zle -N expand-or-complete-with-dots
  # Set the function as the default tab completion widget
  bindkey -M emacs "^I" expand-or-complete-with-dots
  bindkey -M viins "^I" expand-or-complete-with-dots
  bindkey -M vicmd "^I" expand-or-complete-with-dots
fi
