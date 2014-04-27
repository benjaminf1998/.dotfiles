#export TERM="xterm"
#
# ~/.bashrc
#

[[ $- != *i* ]] && return

#PS1='[\u@\h \W]\$ '
#ALIASES:
#general
alias ls='ls -a --color=always --group-directories-first'
alias l='ls -CaFult'
alias ipinfo="curl ipinfo.io" 
alias findall='find *'
alias diskspace="du -S | sort -n -r | more"
alias emacs='emacs -nw --no-splash'
alias mkserver='python -m SimpleHTTPServer'
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
function each() {
    for dir in */; do
	echo "${dir}:"
	cd $dir
	$@ 
	cd ..
    done  
}

#Servers
alias binx='ssh befelber@binx.mbhs.edu'

#Dot path changes
alias .='cd ../'
alias ..='cd ../../'
alias ...='cd ../../../'
alias ....='cd ../../../../'

#FUNCTIONS
cd(){
builtin cd $1
ls
}



RESET="\[\e[0m\]"

DBLACK="\[\e[49;30m\]"
DRED="\[\e[49;31m\]"
DGREEN="\[\e[49;32m\]"
DYELLOW="\[\e[49;33m\]"
DBLUE="\[\e[49;34m\]"
DPURPLE="\[\e[49;35m\]"
DCYAN="\[\e[49;36m\]"
DGRAY="\[\e[49;37m\]"
DWHITE="\[\e[49;39m\]"

BBLACK="\[\e[01;30m\]"
BRED="\[\e[01;31m\]"
BGREEN="\[\e[01;32m\]"
BYELLOW="\[\e[01;33m\]"
BBLUE="\[\e[01;34m\]"
BPURPLE="\[\e[01;35m\]"
BCYAN="\[\e[01;36m\]"
BGRAY="\[\e[01;37m\]"
BWHITE="\[\e[01;39m\]"

PYELLOW="\[\e[38;5;11m\]"
PGRAY="\[\e[38;5;240m\]"


UNDERLINE="\[\e[4m\]"

export PS1="\
⌠┌\
${RESET}\
${DBLUE}\
{\
${RESET}\
${BCYAN}\
\u\
${RESET}\
${DBLUE}\
@\
${RESET}\
${BGREEN}\
\h\
${RESET}\
${DBLUE}\
:\
[\
${RESET}\
${DYELLOW}\
${UNDERLINE}\
\w\
${RESET}\
${DBLUE}\
]\
}\
»\
${RESET}
⌡└─\$ ›\
${RESET}"

export PATH='/usr/lib/python3.4/site-packages/bin:/usr/local/sbin:/usr/local/bi
n:/usr/bin:/usr/bin/core_perl:/home/xeno:/home/xeno/bin/'

function findall {
	find . -name "$1*"
}

function mkcd {
	mkdir $1
	cd $1
}

function unmeta {
	cat $1 > $2
	mv $2 $1
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

function up {
	local d=""
	limit=$1
	for ((i=1 ; i <= limit ; i++))
		do
			d=$d/..
		done
	d=$(echo $d | sed 's/^\///')
	if [ -z "$d" ]; then
		d=..
	fi
	cd $d
}

function ascii {
	for i in {1..256};
		do p=" $i";
		echo -e "${p: -3} \\0$(($i/64*100+$i%64/8*10+$i%8))";
		done|cat -t|column -c120
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

function hg {
	history | grep $* ;
}

function symlist {
	find ./ -type l -ls
}

alias dirsizes='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
alias symlink="ln -s"
alias gpp='g++ *.cpp'
alias chdist='chmod 755'
alias chpriv='chmod 700'
alias chpub='chmod 777'

LS_COLORS='di=1;92:cd=31:ex=1;32:fi=1;31:*.sh=1;95'
export LS_COLORS

#if [ "$PS1" != "" -a "${STARTED_SCREEN:-x}" = x  -a "${SSH_TTY:-x}" != x ]
#then
#	STARTED_SCREEN=1 ; export STARTED_SCREEN
#	[ -d $HOME/lib/screen-logs ] || mkdir -p $HOME/lib/screen-logs
#
#	sleep 1
#	screen -U -RR && exit 0
#
#	echo "Recovering from network disconnect."
#fi

#0   = default colour
#1   = bold
#4   = underlined
#5   = flashing text
#7   = reverse field
#31  = red
#32  = green
#33  = orange
#34  = blue
#35  = purple
#36  = cyan
#37  = grey
#40  = black background
#41  = red background
#42  = green background
#43  = orange background
#44  = blue background
#45  = purple background
#46  = cyan background
#47  = grey background
#90  = dark grey
#91  = light red
#92  = light green
#93  = yellow
#94  = light blue
#95  = light purple
#96  = turquoise
#100 = dark grey background
#101 = light red background
#102 = light green background
#103 = yellow background
#104 = light blue background
#105 = light purple background
#106 = turquoise background

#di = directory
#fi = file
#ln = symbolic link
#pi = fifo file
#so = socket file
#bd = block (buffered) special file
#cd = character (unbuffered) special file
#or = symbolic link pointing to a non-existent file (orphan)
#mi = non-existent file pointed to by a symbolic link (visible when you type ls -l)
#ex = file which is executable (ie. has 'x' set in permissions).
#cowsay -f $(ls /usr/share/cowsay/cows/ | shuf -n1) $(fortune)
export PATH=$PATH:/home/16/befelber/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/16/befelber:/home/16/befelber/bin/aesthetics
