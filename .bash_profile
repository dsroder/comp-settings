export PATH="/usr/local/bin:$HOME/.node_modules_global/bin:$HOME/.composer/vendor/bin:/Applications/MAMP/Library/bin/~/.rbenv/shims:$HOME/.rbenv/bin:$PATH"

if [ -n "$BASH_VERSION" ] && [ -f $HOME/.bashrc ];then
    source $HOME/.bashrc
fi

eval "$(rbenv init -)"

#  Customize BASH PS1 prompt to show current GIT repository and branch.
#  by Mike Stewart - http://MediaDoneRight.com

#  SETUP CONSTANTS
#  Bunch-o-predefined colors.  Makes reading code easier than escape sequences.
#  I don't remember where I found this.  o_O
# --- I changed the format of the variables to allow for use in
# --- the color_branch function. (KEC)

# Reset
Color_Off="\033[0m"       # Text Reset

# Regular Colors
Black="\033[0;30m"        # Black
Red="\033[0;31m"          # Red
Green="\033[0;32m"        # Green
Yellow="\033[0;33m"       # Yellow
Blue="\033[0;34m"         # Blue
Purple="\033[0;35m"       # Purple
Cyan="\033[0;36m"         # Cyan
White="\033[0;37m"        # White

# Bold
BBlack="\033[1;30m"       # Black
BRed="\033[1;31m"         # Red
BGreen="\033[1;32m"       # Green
BYellow="\033[1;33m"      # Yellow
BBlue="\033[1;34m"        # Blue
BPurple="\033[1;35m"      # Purple
BCyan="\033[1;36m"        # Cyan
BWhite="\033[1;37m"       # White

# Underline
UBlack="\033[4;30m"       # Black
URed="\033[4;31m"         # Red
UGreen="\033[4;32m"       # Green
UYellow="\0333[4;33m"      # Yellow
UBlue="\033[4;34m"        # Blue
UPurple="\033[4;35m"      # Purple
UCyan="\033[4;36m"        # Cyan
UWhite="\033[4;37m"       # White

# Background
On_Black="\033[40m"       # Black
On_Red="\033[41m"         # Red
On_Green="\033\033[42m"       # Green
On_Yellow="\033[43m"      # Yellow
On_Blue="\033[44m"        # Blue
On_Purple="\033[45m"      # Purple
On_Cyan="\033[46m"        # Cyan
On_White="\033[47m"       # White

# High Intensty
IBlack="\033[0;90m"       # Black
IRed="\033[0;91m"         # Red
IGreen="\033[0;92m"       # Green
IYellow="\033[0;93m"      # Yellow
IBlue="\033[0;94m"        # Blue
IPurple="\033[0;95m"      # Purple
ICyan="\033[0;96m"        # Cyan
IWhite="\033[0;97m"       # White

# Bold High Intensty
BIBlack="\033[1;90m"      # Black
BIRed="\033[1;91m"        # Red
BIGreen="\033[1;92m"      # Green
BIYellow="\033[1;93m"     # Yellow
BIBlue="\033[1;94m"       # Blue
BIPurple="\033[1;95m"     # Purple
BICyan="\033[1;96m"       # Cyan
BIWhite="\033[1;97m"      # White

# High Intensty backgrounds
On_IBlack="\033[0;100m"   # Black
On_IRed="\033[0;101m"     # Red
On_IGreen="\033[0;102m"   # Green
On_IYellow="\033[0;103m"  # Yellow
On_IBlue="\033[0;104m"    # Blue
On_IPurple="\033[10;95m"  # Purple
On_ICyan="\033[0;106m"    # Cyan
On_IWhite="\033\033[0;107m"   # White

# Various variables you might want for your PS1 prompt instead
date="\d"
time12h="\T"
time12a="\@"
pathFull="\w"
pathshort="\W"
newLine="\n"

# --- Will add an asterisk to the end of the branch name if dirty
# --- uncomment the function then add $(git_dirty) to parse_git_branch
# --- for example ... -e "s/* \(.*\)/$(color_branch)[\1$(git_dirty)]/"
function git_dirty() {
[[ $(git status --porcelain 2> /dev/null) != "" ]] && echo "‼"
}

# --- Changes the color of the branch name in the prompt depending on whether
# --- git is dirty or clean
function color_branch() {
  local git_status="$(git status --porcelain 2> /dev/null)"

  if [[ $git_status != "" ]]; then
    echo -ne "$IRed" #Color for a dirty git

  else
    echo -ne "$IGreen" #Color for a clean git
 fi
}
function reset(){
  echo -ne "$IWhite"
}
# --- Adds the branch to the prompt, this is where you should add git_dirty or color_branch
# --- for example ... -e "s/* \(.*\)/$(color_branch)[\1$(git_dirty)]/"
function parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ [$(color_branch)\1$(git_dirty)$(reset)]/"
}

export PKG_CONFIG_PATH="/opt/X11/lib/pkgconfig"

# --- prompt
export PS1="$newLine\[$IBlack\]$date | $time12a \[$newLine\]\[\033[38;5;24m\]\u \[\033[38;5;208m\]$pathFull\[$IWhite\]\$(parse_git_branch)\[$Color_Off\]$newLine\$ "
export PS2="=> "
# --- sets colors for background
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad
# ExFxBxDxCxegedabagacad
# --- allows for color in ls, and add slash to file list
alias ls='ls -GFh'

# --- a more meaningful history
alias gl='git log --all --decorate --graph --oneline'

function live_git_log(){
while :
do
    clear
    git --no-pager log --graph --pretty=oneline --abbrev-commit --decorate --all $*
    sleep 1
done
}

alias gitlive=live_git_log

alias sam='cd ~/Sites/sourceamerica/'
alias csra='cd ~/Sites/csra'
alias sites='cd ~/Sites/'

alias hosts='sudo vi /etc/hosts'

alias flushdns='dscacheutil -flushcache; sudo killall -HUP mDNSResponder; echo "DNS Cache Cleared";'

alias glog='git log --oneline'

alias localbuild='ng build --prod --deploy-url="/wp-content/themes/local/dist/"';

alias drush6='/opt/drush6/vendor/bin/drush';

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
