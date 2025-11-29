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

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	# Fix yazi image preview on zellij
	TERM="xterm-kitty" yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
