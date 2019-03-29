FROM ubuntu

RUN apt-get update && apt-get upgrade -y

COPY install_toolchain.sh .
ARG prefix=/usr/local

RUN apt-get install -y --no-install-recommends wget xz-utils && \
./install_toolchain.sh -p ${prefix} -j 4 install_prerequisites

#======================================================================
# FIXME: build error for go 1.12.1 with go 1.10.3(GCC8.3.0)
#======================================================================
RUN apt-get install -y --no-install-recommends libz-dev bison texinfo && \
for p in binutils elfutils gmp mpfr mpc isl gcc; do\
	./install_toolchain.sh -p ${prefix} -j 4 install_native_${p} || exit; \
done && \
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
openssh-client libssl-dev libcurl4-openssl-dev libexpat1-dev libpcre2-dev asciidoc xmlto gettext tcl-dev tk-dev && \
./install_toolchain.sh -p ${prefix} -j 4 install_native_git && \
apt-get install -y --no-install-recommends libffi-dev ca-certificates && \
for p in python ruby go; do \
	./install_toolchain.sh -p ${prefix} -j 4 go_ver=1.11.6 install_native_${p} || exit; \
done && \
apt-get install -y --no-install-recommends libncurses5-dev libreadline-dev && \
./install_toolchain.sh -p ${prefix} -j 4 install_native_gdb && \
for p in zsh bash; do \
	./install_toolchain.sh -p ${prefix} -j 4 install_native_${p} || exit; \
done && \
for p in screen libevent tmux; do \
	./install_toolchain.sh -p ${prefix} -j 4 install_native_${p} || exit; \
done && \
apt-get install -y --no-install-recommends graphviz openjdk-11-jre && \
for p in plantuml patch; do \
	./install_toolchain.sh -p ${prefix} -j 4 install_native_${p} || exit; \
done && ./install_toolchain.sh -p ${prefix} clean

# FIXME: 'webkit2gtk-4.0' may be required for emacs. disable 'exec-shield' also may be required.
RUN apt-get install -y --no-install-recommends libperl-dev libpng-dev libtiff-dev libjpeg-dev libgif-dev libxpm-dev && \
for p in lua vim libiconv ctags; do \
	./install_toolchain.sh -p ${prefix} -j 4 install_native_${p} || exit; \
done && \
apt-get install -y --no-install-recommends gperf && \
for p in global the_silver_searcher the_platinum_searcher highway; do \
	./install_toolchain.sh -p ${prefix} -j 4 install_native_${p} || exit; \
done && \
apt-get install -y --no-install-recommends libbz2-dev libedit-dev swig && \
for p in cmake llvm libcxx libcxxabi compiler_rt cfe; do \
	./install_toolchain.sh -p ${prefix} -j 4 force_install=yes install_native_${p} || exit; \
done && ./install_toolchain.sh -p ${prefix} clean

ARG username=dev
COPY dotfiles /etc/skel
RUN rm -v /etc/skel/install.sh /etc/skel/seq.puml && \
echo `which zsh` >> /etc/shells && groupadd ${username} && \
useradd -g ${username} -m -s `which zsh` ${username} && \
echo root:root | chpasswd && \
echo ${username}:${username} | chpasswd && \
apt-get install -y --no-install-recommends language-pack-ja && \
apt-get autoremove -y && apt-get autoclean -y
USER ${username}
WORKDIR /home/${username}
ENV LANG=ja_JP.utf8 SHELL=/usr/local/bin/zsh
CMD ["/usr/local/bin/zsh", "-l"]
RUN echo 'colorscheme molokai' > .vim/vimrc.local.vim
