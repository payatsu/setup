#!/bin/sh -e

[ -f /etc/issue ] && os=`head -1 /etc/issue | cut -d ' ' -f 1`

case ${os} in
Debian|Ubuntu|Raspbian)
	sed -i -e 's/^# \(deb..*partner\)$/\1/' /etc/apt/sources.list
	apt update -y
	apt install -y emacs vim-gtk3 exuberant-ctags global
	apt install -y fonts-ricty-diminished
	apt install -y zsh
	apt install -y screen tmux
	apt install -y wget curl zip
	apt install -y bison flex m4 autoconf automake libtool binutils gcc g++ gdb make git
	apt install -y llvm-dev clang libclang-dev cmake
	apt install -y lv nkf ghostscript gv manpages-ja manpages-ja-dev
	apt install -y python3 python3-dev ruby ruby-dev
	apt install -y doxygen graphviz
	;;
Red|CentOS|\\S)
	yum update -y
	yum install -y emacs vim
	yum install -y zsh
	yum install -y screen tmux
	yum install -y wget curl zip
	yum install -y bison flex m4 autoconf automake libtool binutils gcc gcc-c++ gdb make git
	yum install -y python ruby
	yum install -y doxygen graphviz
	;;
*)
	case `uname -o` in
	Msys)
		pacman -Syu --noconfirm
		pacman -S --noconfirm --needed emacs vim
		pacman -S --noconfirm --needed zsh
		pacman -S --noconfirm --needed tmux
		pacman -S --noconfirm --needed wget curl zip
		pacman -S --noconfirm --needed bison flex m4 autoconf automake libtool binutils gcc gdb make
		pacman -S --noconfirm --needed cmake
		pacman -S --noconfirm --needed man
		pacman -S --noconfirm --needed mingw-w64-{i686,x86_64}-{gcc,gdb,cmake}
		[ -f /c/msys64/msys2_shell.cmd ] && sed -i -e 's/^rem \(set MSYS2_PATH_TYPE=inherit\)$/\1/' /c/msys64/msys2_shell.cmd
		[ -f /c/msys32/msys2_shell.cmd ] && sed -i -e 's/^rem \(set MSYS2_PATH_TYPE=inherit\)$/\1/' /c/msys32/msys2_shell.cmd
		;;
	*)
		echo Unsupported OS: \'${os}\' >&2; exit 1
		;;
	esac
	;;
esac
exit 0

# apt install --yes tgif gnuplot gnuplot-mode
# apt install --yes avconv

# apt install --yes texlive texlive-math-extra ptex-bin xdvik-ja
# apt install --yes dvipdfmx cmap-adobe-japan1 ptex-jisfonts okumura-clsfiles jmpost jbibtex-base jbibtex-bin mendexk dvipsk-ja
# apt install --yes texlive-latex-extra
# apt install --yes yatex
