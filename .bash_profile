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
	source ~/.bashrc
fi

if [ -z "$(which pyenv)" ];then
  export PATH="$HOME/.pyenv/bin:$PATH"
fi

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

if [ -z "$(which rbenv)" ];then
  export PATH="$HOME/.rbenv/bin:$PATH"
fi

eval "$(rbenv init -)"

# User specific environment and startup programs

PATH=$PATH:$HOME/bin

export PATH=$PATH:/sbin:/usr/sbin
export EDITOR='/usr/bin/vim'
# export LANG='ja_JP.UTF-8'
# export LC_ALL='ja_JP.UTF-8'
# export LC_MESSAGES='ja_JP.UTF-8'

