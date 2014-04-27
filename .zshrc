# TMUX
if which tmux 2>&1 >/dev/null; then
    # if no session is started, start a new session
    test -z ${TMUX} && tmux

    # when quitting tmux, try to attach
    while test -z ${TMUX}; do
        tmux attach || break
    done
fi
#Color table from: http://www.understudy.net/custom.html
fg_black=%{$'\e[0;30m'%}
fg_red=%{$'\e[0;31m'%}
fg_green=%{$'\e[0;32m'%}
fg_brown=%{$'\e[0;33m'%}
fg_blue=%{$'\e[0;34m'%}
fg_purple=%{$'\e[0;35m'%}
fg_cyan=%{$'\e[0;36m'%}
fg_lgray=%{$'\e[0;37m'%}
fg_dgray=%{$'\e[1;30m'%}
fg_lred=%{$'\e[1;31m'%}
fg_lgreen=%{$'\e[1;32m'%}
fg_yellow=%{$'\e[1;33m'%}
fg_lblue=%{$'\e[1;34m'%}
fg_pink=%{$'\e[1;35m'%}
fg_lcyan=%{$'\e[1;36m'%}
fg_white=%{$'\e[1;37m'%}
#Text Background Colors
bg_red=%{$'\e[0;41m'%}
bg_green=%{$'\e[0;42m'%}
bg_brown=%{$'\e[0;43m'%}
bg_blue=%{$'\e[0;44m'%}
bg_purple=%{$'\e[0;45m'%}
bg_cyan=%{$'\e[0;46m'%}
bg_gray=%{$'\e[0;47m'%}
#Attributes
at_normal=%{$'\e[0m'%}
at_bold=%{$'\e[1m'%}
at_italics=%{$'\e[3m'%}
at_underl=%{$'\e[4m'%}
at_blink=%{$'\e[5m'%}
at_outline=%{$'\e[6m'%}
at_reverse=%{$'\e[7m'%}
at_nondisp=%{$'\e[8m'%}
at_strike=%{$'\e[9m'%}
at_boldoff=%{$'\e[22m'%}
at_italicsoff=%{$'\e[23m'%}
at_underloff=%{$'\e[24m'%}
at_blinkoff=%{$'\e[25m'%}
at_reverseoff=%{$'\e[27m'%}
at_strikeoff=%{$'\e[29m'%}

#PROMPT="
#${fg_lgreen}%n@${at_underl}%m${at_underloff}${fg_white}[${fg_cyan}%~${fg_white\}]
#[${fg_green}%T${fg_white}]:${at_normal}"

#Set the auto completion on
autoload -U compinit
compinit

#Let's set some options
setopt correctall
setopt autocd
setopt auto_resume

## Enables the extgended globbing features
setopt extendedglob

#Set some ZSH styles
#zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select=0

HISTFILE=~/.zsh-histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# Prompt configuration

local username_format
if [ $EUID -eq 0 ]; then
        username_format="%F{blue}"
else
        username_format="%F{cyan}"
fi
bracket_format="%F{blue}"
at_format="%F{cyan}"
host_format="%B%F{brown}"
dir_format="%F{green}"
reset="%f%k%b"
PROMPT="${bracket_format}[${reset}${username_format}%n${reset}${at_format}@${re\
set}${host_format}%m${reset} ${dir_format}%~${reset}${bracket_format}]${reset} \
"
RPROMPT='%F{green}[%F{blue}%t %W%F{green}]%F{blue}'
alias lh="ls -lh"
alias ldir='ls -d */'
#Aliases
##ls, the common ones I use a lot shortened for rapid fire usage
alias ls='ls -A --color' #I like color
alias l='ls -lAFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
#alias mpv='mpv --fs --framedrop=yes'
#alias mpdviz="mpdviz -i --imode='256'"
#alias pipetobash=mybash
#alias optiscrot=nicescrot
alias mpdscribb="mpdscribble --conf ~/.config/mpdscribble/mpdscribble.conf"
alias ipinfo="curl ipinfo.io"
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"
cd(){
builtin cd $1
ls
}
get3x3(){
pushd
cd ~/Pictures/Charts
wget "http://www.tapmusic.net/lastfm/collage.php?user=inthedeeptime&type=7day&size=3x3&caption=true"
mv ./collage.php* ./3x3-$(date +"%m-%d-%y").jpg
popd
}
get5x5(){
pushd
cd ~/Pictures/Charts
wget "http://www.tapmusic.net/lastfm/collage.php?user=inthedeeptime&type=7day&size=5x5&caption=true"
mv ./collage.php* ./5x5-$(date +"%A-%m-%d-%y").jpg
popd
}
#cg(){
#x=$1
#read -p 'Search for what?' query
#cat $1 |grep $query
#echo -n $
#}
cl(){
cat $1 |less
}

#ncmpcpp(){
#if $(ps -e|grep mpdscribble); then
#    ncmpcpp
#else
#    mpdscribb
#    ncmpcpp
#fi
#}
#nicescrot()
#{
#read -p "Filename: " filename
#scrot -cd 3 "$filename";optipng '$filename'
#} 
#mybash()
#{
#echo "$1"|bash
#}
##cd, because typing the backslash is A LOT of work!!
alias .='cd ../'
alias ..='cd ../../'
alias ...='cd ../../../'
alias ....='cd ../../../../'
# SSH aliases - short cuts to ssh to a host
alias binx='ssh befelber@binx.mbhs.edu'
alias ramu='ssh befelber@systemic.io'
alias emacs='emacs -nw --no-splash'
alias mkserver='python -m SimpleHTTPServer'

# Screen aliases - add a new screen , or entire session, name it, then ssh to the host
#alias sshost='screen -t HOST shost'# Enable compsys completion.
#START USEFUL SCRIPTS
function ram() {
  local sum
  local items
  local app="$1"
  if [ -z "$app" ]; then
echo "First argument - pattern to grep from processes"
  else
      sum=0
    for i in `ps aux | grep -i "$app" | grep -v "grep" | awk '{print $6}'`; do
	sum=$(($i + $sum))
    done
    sum=$(echo "scale=2; $sum / 1024.0" | bc)
    if [[ $sum != "0" ]]; then
	echo "${fg[blue]}${app}${reset_color} uses ${fg[green]}${sum}${reset_color} MBs of RAM."
    else
	echo "There are no processes with pattern '${fg[blue]}${app}${reset_color}' are running."
    fi
fi
}
screengrab(){
    avconv -f x11grab -r 25 -s 1680x1050 -i :0.0 /tmp/$1.mp4
}
function each() {
  for dir in */; do
      echo "${dir}:"
      cd $dir
      $@
      cd ..
  done
}
up(){
LIMIT=$1
P=$PWD
for ((i=1; i <= LIMIT; i++))
do
    P=$P/..
done
cd $P
export MPWD=$P
}
pissoff(){
for i in read q
do
echo "$q"
done <$1
}
back(){
LIMIT=$1
P=$MPWD
for ((i=1; i <= LIMIT; i++))
do
    P=${P%/..}
done
cd $P
export MPWD=$P
}
export PATH=$PATH:/home/16/befelber/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/16/befelber:/home/16/befelber/bin/aesthetics
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
#cowsay -f $(ls /usr/share/cowsay/cows/ | shuf -n1) $(fortune)
set completion-ignore-case on
clear
#echo "Current Users:"
#finger |grep -v befelber|grep -v Login
mesg ne
