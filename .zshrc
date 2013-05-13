#################################################################################################
###    Oh My Zsh Configs    #####################################################################
#################################################################################################

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bcap"

plugins=(git)

# Enabling oh-my-zsh
source $ZSH/oh-my-zsh.sh


#################################################################################################
###    Options    ###############################################################################
#################################################################################################

# Save each line to the history file as it is executed
setopt INC_APPEND_HISTORY

# Don't save lines beginning with a space
setopt HIST_IGNORE_SPACE

# Save function definitions
unsetopt HIST_NO_FUNCTIONS

# Don't save duplicate history lines
setopt HIST_IGNORE_DUPS

# Don't find duplicate history lines
setopt HIST_FIND_NO_DUPS

# Tidy up the line when it is entered into the history by removing any excess blanks that mean nothing to the shell.
setopt HIST_REDUCE_BLANKS

# Don't share history between Z shells
unsetopt SHARE_HISTORY

# Save the time when the command was run, etc
setopt EXTENDED_HISTORY


#################################################################################################
###    Environment Vars    ######################################################################
#################################################################################################

# setting path and fpath in an array form
fpath=(
    ~/.oh-my-zsh/zsh-completions 
    $fpath
)

path=(
    $HOME/bin 
    /usr/local/heroku/bin 
    /usr/local/bin 
    /usr/local/sbin 
    /usr/bin 
    /usr/sbin 
    /bin 
    /sbin 
    $path
)

HISTSIZE=10000
SAVEHIST=10000

# shell general
export EDITOR="vim"
export VISUAL="subl --wait"
export PAGER="less"
export LESS="--chop-long-lines --shift .3 --raw-control-chars"

# maven
export MAVEN_OPTS="-Xmx256m -XX:MaxPermSize=256m"

# Mac brew
if which brew > /dev/null; then
    export BYOBU_PREFIX=$(brew --prefix)
    path=($(brew --prefix coreutils)/libexec/gnubin $path)
fi

# aws stuff
AWS_CREDENTIALS_DIR=$HOME/Dropbox/nix/aws
if [[ -d $AWS_CREDENTIALS_DIR ]]; then
    # personal var do help me out
    export AWS_CREDENTIALS_DIR 

    # boto uses this
    export AWS_CREDENTIAL_FILE=$AWS_CREDENTIALS_DIR/aws-credentials-root

    # AWS tools uses this
    export AWS_ACCESS_KEY=$(grep AWSAccessKeyId $AWS_CREDENTIAL_FILE | cut -d '=' -f 2)
    export AWS_SECRET_KEY=$(grep AWSSecretKey $AWS_CREDENTIAL_FILE | cut -d '=' -f 2)
fi


#################################################################################################
###    Aliases    ###############################################################################
#################################################################################################

alias ls='ls --color=auto'
alias ll='ls -lhp'
alias la='ll -A'

alias today='date +%Y%m%d'
alias now='date +%Y%m%d-%H%M%S'

alias gpg='gpg --personal-cipher-preferences AES256 --personal-compress-preferences ZLIB --armor'
alias encrypt-with-pass='gpg --symmetric'
alias encrypt-with-key='gpg --encrypt --sign --recipient polaco@gmail.com'
alias decrypt='gpg -d'
