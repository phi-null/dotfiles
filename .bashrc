# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

export cmd_count=$(history | wc -l)
showexit() {
  local s="$?"
  local cmd_count_tmp=$(history | wc -l)
  if [[ $cmd_count_tmp -eq $cmd_count ]]; then
    :
  elif [[ $s -eq 0 ]]; then
    export cmd_count=$(history | wc -l)
  else
    export cmd_count=$(history | wc -l)
    echo -e "\e[1;31mError exited $s"
  fi
}
PROMPT_COMMAND=showexit

# Prompt Customize
export PS1="\n\[\e[1;36m\]\u@\$(uname -n) \[\e[1;37m\]\t \[\e[1;35m\]\$(pwd)\n\[\e[1;33m\]\\$ "
export PS2="\[\e[1;33m\]> "
trap "tput sgr0" DEBUG

# options
shopt -s histappend
shopt -s histverify
shopt -s histreedit
shopt -s checkwinsize
shopt -s checkhash
shopt -s cdable_vars
shopt -s no_empty_cmd_completion
export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export HISTIGNORE=history

# less option
export LESS='-i -M -R -S -x2'

# git pager
export GIT_PAGER=cat

# ls color
eval `dircolors ~/.colorrc`
alias ls='ls -h --color=auto'

