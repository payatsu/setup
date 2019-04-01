ARG baseimage=ubuntu
ARG prefix=/usr/local

FROM ${baseimage} AS builder
ARG prefix

RUN apt-get update && apt-get upgrade -y
COPY install_toolchain.sh .
RUN echo Asia/Tokyo > /etc/timezone && \
DEBIAN_FRONTEND=noninteractive \
apt-get install -y --no-install-recommends tzdata && \
apt-get install -y --no-install-recommends \
wget xz-utils \
make gcc g++ autoconf automake \
libz-dev libbz2-dev bison texinfo \
libncurses5-dev libreadline-dev \
openssh-client libssl-dev libcurl4-openssl-dev ca-certificates \
libexpat1-dev libpcre2-dev asciidoc xmlto gettext tcl-dev tk-dev \
libffi-dev \
graphviz openjdk-11-jre \
libperl-dev libpython-dev libgnomeui-dev libxt-dev \
gperf \
libedit-dev swig && \
: "FIXME: build error for go 1.12.1 with go 1.10.3(GCC8.3.0)" && \
: "FIXME: can't build Emacs26 in Dockerfile. webkit2gtk-4.0-dev libpng-dev libtiff-dev libjpeg-dev libgif-dev libxpm-dev" && \
for p in binutils elfutils gmp mpfr mpc isl gcc git python ruby go gdb \
zsh bash screen libevent tmux plantuml patch lua vim libiconv ctags \
global the_silver_searcher the_platinum_searcher highway fzf; do \
	./install_toolchain.sh -p ${prefix} -j 4 go_ver=1.11.6 install_native_${p} || exit; \
done && \
for p in cmake llvm libcxx libcxxabi compiler_rt cfe; do \
	./install_toolchain.sh -p ${prefix} -j 4 force_install=yes install_native_${p} || exit; \
done && ./install_toolchain.sh -p ${prefix} clean

FROM ${baseimage}
ARG prefix
ARG username=dev

COPY --from=builder ${prefix} ${prefix}
COPY dotfiles /etc/skel
RUN \
ldconfig && \
rm -v /etc/skel/install.sh /etc/skel/seq.puml && \
echo `which zsh` >> /etc/shells && groupadd ${username} && \
useradd -g ${username} -m -s `which zsh` ${username} && \
echo root:root | chpasswd && \
echo ${username}:${username} | chpasswd && \
apt-get update && \
apt-get install -y --no-install-recommends language-pack-ja && \
apt-get autoremove -y && apt-get autoclean -y
USER ${username}
WORKDIR /home/${username}
ENV LANG=ja_JP.utf8 SHELL=${prefix}/bin/zsh
CMD ${SHELL} -l
RUN echo 'colorscheme molokai' > .vim/vimrc.local.vim && \
vim -c 'try | call dein#update() | finally | qall! | endtry' -N -u .vim/vimrc -U NONE -i NONE -V1 -e -s
