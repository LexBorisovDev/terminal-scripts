# Some good standards, which are not used if the user
# creates his/her own .bashrc/.bash_profile

# --show-control-chars: help showing Korean or accented characters
alias ls='ls -F --color=auto --show-control-chars'
alias ll='ls -l'

# ========= FUNCTIONS =========
source /c/Users/lborisov/terminal/scripts/git-bash/shell/mkcd.sh
source /c/Users/lborisov/terminal/scripts/git-bash/shell/show-items.sh
source /c/Users/lborisov/terminal/scripts/git-bash/shell/show-history.sh
source /c/Users/lborisov/terminal/scripts/git-bash/shell/delete-history.sh

source /c/Users/lborisov/terminal/scripts/git-bash/shell/navigation/navigate.sh
source /c/Users/lborisov/terminal/scripts/git-bash/shell/navigation/dev.sh
source /c/Users/lborisov/terminal/scripts/git-bash/shell/navigation/practice.sh
source /c/Users/lborisov/terminal/scripts/git-bash/shell/navigation/projects.sh
source /c/Users/lborisov/terminal/scripts/git-bash/shell/navigation/go-back.sh
source /c/Users/lborisov/terminal/scripts/git-bash/shell/navigation/go-forward.sh
source /c/Users/lborisov/terminal/scripts/git-bash/shell/navigation/program-files.sh
source /c/Users/lborisov/terminal/scripts/git-bash/shell/navigation/scripts.sh
source /c/Users/lborisov/terminal/scripts/git-bash/shell/navigation/ps1.sh
source /c/Users/lborisov/terminal/scripts/git-bash/shell/navigation/seneca.sh
source /c/Users/lborisov/terminal/scripts/git-bash/shell/navigation/user.sh

source /c/Users/lborisov/terminal/scripts/git-bash/dev/react/create-react-app.sh

source /c/Users/lborisov/terminal/scripts/git-bash/apps/notepad.sh


# ========= DEV =========
alias p='practice'
alias j='projects'
alias cra='create-react-app'

# ========= NAVIGATION =========
alias gb='go-back'
alias go='go-forward'
alias gf='go-forward'
alias pf='program-files'
alias usr='user'
alias sen='seneca'

# ========= ALIASES =========
alias edit-aliases='code ~/.bash_aliases'
alias source-aliases='source ~/.bash_aliases'
alias ea='edit-aliases'
alias sa='source-aliases'

# ========= SHELL =========
alias c='clear'
alias z='show-items'
alias dh="delete-history"
alias his="show-history"

# ========= APPS =========
alias np='notepad'

case "$TERM" in
xterm*)
	# The following programs are known to require a Win32 Console
	# for interactive usage, therefore let's launch them through winpty
	# when run inside `mintty`.
	for name in node ipython php php5 psql python2.7
	do
		case "$(type -p "$name".exe 2>/dev/null)" in
		''|/usr/bin/*) continue;;
		esac
		alias $name="winpty $name.exe"
	done
	;;
esac
