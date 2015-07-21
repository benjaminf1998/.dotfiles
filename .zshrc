# TMUX
#loc=`tty`
#loc=${loc:5:8}
#if [[ $loc =~ tty ]];then
#    echo tty
#else
#    if which tmux 2>&1 >/dev/null; then
#        # if no session is started, start a new session
#        test -z ${TMUX} && tmux
#        # when quitting tmux, try to attach
#        while test -z ${TMUX}; do
#        tmux attach || break
#        done
#    fi
#fi
alias default="tmux a -t default ||tmux new -s default"
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


#Set the auto completion on
autoload -U compinit
compinit
compdef _id3v2 id3v2 mid3v2

#Let's set some options
setopt correctall autocd auto_resume autopushd HIST_IGNORE_DUPS BANG_HIST HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_SPACE HIST_VERIFY histexpiredupsfirst histreduceblanks longlistjobs extendedglob

#Set some ZSH styles
#zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select=0

HISTFILE=~/.zsh-histfile
HISTSIZE=100000
SAVEHIST=100000
bindkey -e
# Prompt configuration

local username_format
#warning coloration to username when run as root
if [ $EUID -eq 0 ]; then
        username_format="%F{red}"
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
RPROMPT='%1(j.%F{yellow}jobs:%j;%f .)%(?.%F{green}ok%f.%F{red}%?%f)' #exit code of last job notation
#Aliases
##ls to show hidden files, color it up, and group stuff sensibly
alias ls='ls -A --color --group-directories-first' #I like color
alias mpdscribb="mpdscribble --conf ~/.config/mpdscribble/mpdscribble.conf"
alias ipinfo="curl ipinfo.io"
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"
alias aurdate='yaourt -Syua --devel' #update repos/aur packages
alias orphans='sudo pacman -Rns $(pacman -Qtdq)' #recursively remove orphaned packages
alias mkserver='python -m http.server'
alias dirsizes='find . -maxdepth 1 -type d -print0 | xargs -0 du -skh | sort -rn'
alias umd='sshfs bfelber@vclfs.eng.umd.edu:/ /mnt/UMD -C -p 22' #remount UMD filesystem
alias grep='grep --binary-files=without-match --color=auto --directories=recurse --line-number'
#Functions
#This should all be in $HOME/bin, but fuck you
paux(){
    ps aux|head -1
    ps aux|grep $1 |grep -v "grep"
}
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
get4x4(){
pushd
cd ~/Pictures/Charts
wget "http://www.tapmusic.net/lastfm/collage.php?user=inthedeeptime&type=7day&size=4x4&caption=true"
mv ./collage.php* ./4x4-$(date +"%m-%d-%y").jpg
popd
}
background(){
    while :
    do
        feh --bg-scale --randomize ~/Pictures/Backgrounds/Music/*
        read x
    done
}
timer(){
    x=0;watcher=0;
    while [ $watcher = 0 ]
    do
        let "x = $x + 1"
        let "q = $x / 60"
        let "z = $x % 60"
        echo "$q mins $z secs"
        if [ $x -eq $1 ];then;
            notify-send "UR DONE BRUH" "Time's up" --icon=system-shutdown
            watcher=1
        fi;sleep 1;clear
done
}
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
screenlow(){
    avconv -f x11grab -r 25 -s 1680x1050 -i :0.0 /tmp/$1.mp4
}
screenhigh(){
    ffmpeg -f x11grab -r 25 -s 1680x1050 -i :0.0 -vcodec libx264 -preset ultrafast -crf 0 /tmp/$1.mkv
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
muxav() {
  ffmpeg -i ${1:r}.mp4 -i ${1:r}.m4a -map 0:v -map 1:a -codec copy -shortest ${1:r}.muxed.mp4
}
findall(){
    find . -name "$1*"
}
function extract {
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)   tar xvjf $1    ;;
			*.tar.gz)    tar xvzf $1    ;;
			*.bz2)       bunzip2 $1     ;;
			*.rar)       unrar x $1       ;;
			*.gz)        gunzip $1      ;;
			*.tar)       tar xvf $1     ;;
			*.tbz2)      tar xvjf $1    ;;
			*.tgz)       tar xvzf $1    ;;
			*.zip)       unzip $1       ;;
			*.Z)         uncompress $1  ;;
			*.7z)        7z x $1        ;;
			*)           echo "don't know how to extract '$1'..." ;;
		esac
	else
		echo "'$1' is not a valid file!"
	fi
 }
function color256 {
	for fgbg in 38 48 ; do #Foreground/Background
		for color in {0..256} ; do #Colors
			#Display the color
			echo -en "\e[${fgbg};5;${color}m ${color}\t\e[0m"
			#Display 10 colors per lines
			if [ $((($color + 1) % 10)) == 0 ] ; then
				echo #New line
			fi
		done
		echo #New line
	done
}
function connect(){
    sudo ip link set wlp3s0 up
    sudo iw dev wlp3s0 connect $1
    sudo dhcpcd wlp3s0
    }
webm(){
    x=$1
    x=${x%.mkv}.webm
    echo $x
    ffmpeg -i $1 -c:v libvpx -crf 4 -b:v 1500K -vf scale=1200:-1 "$xwebm"
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
say() {
    if [[ "${1}" =~ -[a-z]{2} ]]; then
        local lang=${1#-};
        local text="${*#$1}";
    else
        local lang=${LANG%_*};
        local text="$*";
    fi;
    mpv "http://translate.google.com/translate_tts?ie=UTF-8&tl=${lang}&q=${text}"  &> /dev/null
    }
export
PATH=$PATH:$HOME/bin:$HOME/opt/go/bin:/usr/local/sbin:/usr/local/texlive/2014/bin/i386-linux:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
export MANPATH=:/usr/local/texlive/2014/texfm-dist/doc/man:
export GOPATH=~/go
export GOROOT=~/opt/go
export PATH=$PATH:~/go/bin
export EDITOR=emacs
export BLOCK_SIZE=human-readable
clear
mesg ne
#suffixes
alias -s mp3=mpv
alias -s flac=mpv
alias -s go=emacs
alias -s epub=firefox
export disk="/run/media/benjamin/B392-AB62/"
source /usr/share/doc/pkgfile/command-not-found.zsh
