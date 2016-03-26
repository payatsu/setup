#!/bin/sh -e

os=`head -1 /etc/issue | cut -d ' ' -f 1`

case ${os} in
	Debian|Ubuntu)
		sed -i -e 's/^# \(deb..*partner\)$/\1/' /etc/apt/sources.list
		apt-get update
		apt-get install --yes emacs vim
		apt-get install --yes zsh
		apt-get install --yes screen
		apt-get install --yes wget curl zip
		apt-get install --yes lv nkf ghostscript gv manpages-ja manpages-ja-dev
		apt-get install --yes g++ git llvm-dev clang libclang-dev cmake
		apt-get install --yes python3
		apt-get install --yes doxygen graphviz
		;;
	Red|CentOS|\\S)
		yum update
		yum install -y emacs vim
		yum install -y zsh
		yum install -y screen
		yum install -y wget curl zip
		yum install -y gcc gcc-c++ binutils gdb make git bison flex m4 autoconf automake libtool
		yum install -y python
		yum install -y doxygen graphviz
		;;
	*)
		echo Unsupported OS: ${os} >&2; exit 1
		;;
esac

# apt-get install --yes tgif gnuplot gnuplot-mode
# apt-get install --yes avconv

# apt-get install --yes texlive texlive-math-extra ptex-bin xdvik-ja
# apt-get install --yes dvipdfmx cmap-adobe-japan1 ptex-jisfonts okumura-clsfiles jmpost jbibtex-base jbibtex-bin mendexk dvipsk-ja
# apt-get install --yes texlive-latex-extra
# apt-get install --yes yatex
