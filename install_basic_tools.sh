#!/bin/sh -e

[ -f /etc/issue ] && os=`head -1 /etc/issue | cut -d ' ' -f 1`

case ${os} in
Debian|Ubuntu|Raspbian)
	sed -i -e 's/^# \(deb..*partner\)$/\1/' /etc/apt/sources.list
	apt-get update -y
	apt-get install -y emacs vim
	apt-get install -y zsh
	apt-get install -y screen tmux
	apt-get install -y wget curl zip
	apt-get install -y bison flex m4 autoconf automake libtool binutils gcc g++ gdb make git
	apt-get install -y llvm-dev clang libclang-dev cmake
	apt-get install -y lv nkf ghostscript gv manpages-ja manpages-ja-dev
	apt-get install -y python3 python3-dev ruby ruby-dev
	apt-get install -y doxygen graphviz
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

# apt-get install --yes tgif gnuplot gnuplot-mode
# apt-get install --yes avconv

# apt-get install --yes texlive texlive-math-extra ptex-bin xdvik-ja
# apt-get install --yes dvipdfmx cmap-adobe-japan1 ptex-jisfonts okumura-clsfiles jmpost jbibtex-base jbibtex-bin mendexk dvipsk-ja
# apt-get install --yes texlive-latex-extra
# apt-get install --yes yatex
