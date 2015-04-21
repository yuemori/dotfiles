# .bash_profile
stty stop undef

alias vi='vim'
alias ls='ls -CF'
alias ll='ls -ALFh --show-control-chars --color=auto'
alias la='ls -CFal'
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'
alias ps='ps --sort=start_time'

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin

export PATH=$PATH:/sbin:/usr/sbin
export EDITOR='/usr/bin/vim'
# export LANG='ja_JP.UTF-8'
# export LC_ALL='ja_JP.UTF-8'
# export LC_MESSAGES='ja_JP.UTF-8'
