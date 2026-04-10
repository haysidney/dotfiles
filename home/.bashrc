# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi


# Put your fun stuff here.
if [ "$TERM" != "linux" ]; then eval "$(zellij setup --generate-auto-start bash)"; fi

export EDITOR=/usr/bin/micro

export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoredups

alias ls="ls -la"
alias df="df -h"

alias startllama="systemctl --user start llama-server"
alias stopllama="systemctl --user stop llama-server"
alias upgrademyshit="sudo emerge --sync && sudo emerge --ask --verbose --update --deep --newuse @world; flatpak update; sudo emerge --depclean"
alias upgrademyshitnosync="sudo emerge --ask --verbose --update --deep --newuse @world; flatpak update; sudo emerge --depclean"

function jaicasual {
  jai -j "$(basename $PWD)" -mcasual "$@"
}

eval "$(thefuck --alias)"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	# Fix yazi image preview on zellij
	TERM="xterm-kitty" yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/sidney/.lmstudio/bin"
# End of LM Studio CLI section


# uv
export PATH="/home/sidney/.local/bin:$PATH"

export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$HOME/.dotnet:$HOME/.dotnet/tools

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# JAI
if df /tmp 2>/dev/null | grep -q jai; then
    JAI_INDICATOR="[jail] "
else
    JAI_INDICATOR=""
fi
export PS1="${JAI_INDICATOR}${PS1}"
