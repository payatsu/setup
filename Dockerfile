ARG baseimage=ubuntu
ARG prefix=/usr/local
ARG prefixbase=local

FROM ${baseimage} AS builder
ARG prefix
ARG njobs=4

RUN apt-get update && apt-get upgrade -y
COPY install_toolchain.sh .
RUN \
echo Asia/Tokyo > /etc/timezone && \
DEBIAN_FRONTEND=noninteractive \
apt-get install -y --no-install-recommends tzdata && \
apt-get install -y --no-install-recommends \
wget xz-utils \
make gcc g++ \
libz-dev libbz2-dev bison texinfo \
libncurses5-dev libreadline-dev \
openssh-client libssl-dev libcurl4-openssl-dev ca-certificates \
libexpat1-dev libpcre2-dev asciidoc xmlto gettext \
graphviz openjdk-11-jre \
libgnomeui-dev libxt-dev \
gperf \
libedit-dev swig && \
: "FIXME: can't build Emacs26 in Dockerfile. webkit2gtk-4.0-dev libpng-dev libtiff-dev libjpeg-dev libgif-dev libxpm-dev" && \
for p in \
binutils gmp mpfr mpc isl gcc \
elfutils bison flex m4 perl autoconf automake libtool xz lzip ed bc cmake \
libffi old_python python ninja meson libiconv glib pkg_config \
ruby tcl tk libunistring libatomic_ops gc guile gdb git go \
zsh bash screen libevent tmux plantuml patch lua vim ctags global \
the_silver_searcher the_platinum_searcher highway fzf; do \
	./install_toolchain.sh -p ${prefix} -j ${njobs} go_ver=1.11.9 install_native_${p} || exit; \
done && \
./install_toolchain.sh -p ${prefix} -j ${njobs} force_install=yes install_native_go && \
for p in llvm libcxx libcxxabi compiler_rt cfe clang_tools_extra; do \
	./install_toolchain.sh -p ${prefix} -j ${njobs} force_install=yes install_native_${p} || exit; \
done && ./install_toolchain.sh -p ${prefix} clean

FROM ${baseimage} AS dev
ARG prefix
ARG prefixbase
ARG username=dev

COPY --from=builder ${prefix} ${prefix}
COPY --from=builder /etc/ld.so.conf.d/${prefixbase}.conf /etc/ld.so.conf.d/${prefixbase}.conf
COPY dotfiles /etc/skel
RUN \
apt-get update && apt-get upgrade -y && \
echo Asia/Tokyo > /etc/timezone && \
DEBIAN_FRONTEND=noninteractive \
apt-get install -y --no-install-recommends tzdata && \
apt-get install -y --no-install-recommends \
libc6-dev wget less make file man-db \
libreadline7 \
libssl1.1 libcurl4-openssl-dev ca-certificates \
libexpat1 libpcre2-8-0 libxml2 \
graphviz openjdk-11-jre \
libgnomeui-0 libxt6 \
libedit2 \
&& \
ldconfig && \
rm -v /etc/skel/install.sh /etc/skel/seq.puml && \
echo `which zsh` >> /etc/shells && groupadd ${username} && \
useradd -g ${username} -m -s `which zsh` ${username} && \
echo root:root | chpasswd && \
echo ${username}:${username} | chpasswd && \
apt-get update && \
apt-get install -y --no-install-recommends locales && \
apt-get autoremove -y && apt-get autoclean -y && \
sed -i -e 's/^# \(ja_JP\.UTF-8 UTF-8\)$/\1/' /etc/locale.gen && \
locale-gen
USER ${username}
WORKDIR /home/${username}
ENV LANG=ja_JP.utf8 SHELL=${prefix}/bin/zsh
CMD ${SHELL} -l
RUN \
echo 'colorscheme molokai' > .vim/vimrc.local.vim && \
vim -c 'try | call dein#update() | finally | qall! | endtry' -N -u .vim/vimrc -U NONE -i NONE -V1 -e -s
