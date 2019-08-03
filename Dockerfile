ARG baseimage=ubuntu
ARG prefix=/usr/local
ARG prefixbase=local
ARG njobs=4

FROM ${baseimage} AS builder
ARG prefix
ARG njobs
ARG pkgs="zlib binutils gmp mpfr mpc isl gcc \
bzip2 elfutils m4 bison flex perl autoconf autoconf-archive automake libtool texinfo \
gawk xz lzip ed bc curl cmake libffi Python2 Python ninja meson Bear libiconv glib pkg-config \
ruby tcl tk libunistring libatomic_ops gc guile gdb gettext git go rustc \
zsh bash screen libevent tmux plantuml patch lua vim ctags global \
the_silver_searcher the_platinum_searcher highway fzf jq protobuf swig dtc \
lld llvm compiler-rt libunwind libcxxabi libcxx cfe boost"

RUN apt-get update && apt-get upgrade -y
COPY install_toolchain.sh .
RUN \
echo Asia/Tokyo > /etc/timezone && \
DEBIAN_FRONTEND=noninteractive \
apt-get install -y --no-install-recommends tzdata && \
apt-get install -y --no-install-recommends \
wget xz-utils \
make gcc g++ \
bison texinfo \
libncurses5-dev libreadline-dev \
openssh-client libssl-dev ca-certificates \
libexpat1-dev libpcre2-dev asciidoc xmlto \
graphviz openjdk-11-jre \
libgtk-3-dev libxft-dev libxt-dev \
gperf \
libedit-dev && \
./install_toolchain.sh -p ${prefix} -j ${njobs} go_ver=1.11.12 "fetch `echo ${pkgs} | sed -e 's/\<ctags\>//'` clang-tools-extra vimdoc-ja mingw-w64"
RUN \
: "FIXME: can't build Emacs26 in Dockerfile. webkit2gtk-4.0-dev libpng-dev libtiff-dev libjpeg-dev libgif-dev libxpm-dev" && \
for p in `echo ${pkgs} | tr - _`; do \
	./install_toolchain.sh -p ${prefix} -j ${njobs} go_ver=1.11.12 install_native_${p} || exit; \
done && \
./install_toolchain.sh -p ${prefix} -j ${njobs} force_install=yes install_native_go && \
./install_toolchain.sh -p ${prefix} -j ${njobs} -t x86_64-w64-mingw32 -l c,c++ install_cross_binutils install_cross_gcc && \
./install_toolchain.sh -p ${prefix} clean convert_archives

FROM ${baseimage} AS dev
ARG prefix
ARG prefixbase
ARG username=dev
ARG njobs

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
libssl-dev ca-certificates \
libexpat1 libpcre2-8-0 libxml2 \
graphviz openjdk-11-jre \
libgtk-3-0 libxft2 libxt6 \
libedit2 \
openssh-client \
sudo locales \
&& \
ldconfig && \
rm -v /etc/skel/install.sh /etc/skel/seq.puml && \
echo . ${prefix}/set_path.sh > /etc/skel/.sh/.local.pre && \
echo . '${HOME}'/.sh/.local.pre > /etc/skel/.zsh/.zshrc.local.pre && \
echo . '${HOME}'/.sh/.local.pre > /etc/skel/.bash/.bashrc.local.pre && \
echo `which zsh` >> /etc/shells && \
groupadd ${username} && \
useradd -g ${username} -m -s `which zsh` ${username} && \
echo root:root | chpasswd && \
echo ${username}:${username} | chpasswd && \
sed -i -e '/^root\>/a'${username}'	ALL=(ALL:ALL) NOPASSWD: ALL' /etc/sudoers && \
apt-get autoremove -y && apt-get autoclean -y && \
sed -i -e 's/^# \(ja_JP\.UTF-8 UTF-8\)$/\1/' /etc/locale.gen && \
locale-gen
USER ${username}
WORKDIR /home/${username}
ENV LANG=ja_JP.utf8 SHELL=${prefix}/bin/zsh USER=${username}
CMD exec ${SHELL} -l
COPY install_toolchain.sh .
RUN \
sudo mv -v /usr/local/lib/rustlib/uninstall.sh . && \
./install_toolchain.sh -p tmp -j ${njobs} install_native_rustup clean convert_archives && \
sudo cp -vr tmp/src/rustup ${prefix}/src && \
sudo mv -v uninstall.sh /usr/local/lib/rustlib && \
rm -vr tmp install_toolchain.sh && \
./.cargo/bin/rustup completions zsh | sudo tee /usr/local/share/zsh/site-functions/_rustup > /dev/null && \
echo colorscheme molokai > .vim/vimrc.local.vim && \
vim -c 'try | call dein#update() | finally | qall! | endtry' -N -u .vim/vimrc -U NONE -i NONE -V1 -e -s
