ARG baseimage=ubuntu:18.04
ARG prefix=/usr/local
ARG prefixbase=local
ARG njobs=4

FROM ${baseimage} AS builder
ARG prefix
ARG njobs
ARG pkgs="zlib binutils m4 gmp mpfr mpc isl gcc \
bzip2 elfutils bison flex perl autoconf autoconf-archive automake libtool ncurses readline texinfo \
gawk cpio xz zip unzip lzip lunzip lzo lzop lz4 zstd ed bc patch ccache pcre swig libffi Python2 Python libxml2 \
libiconv ninja meson glib pkg-config nghttp2 curl cmake Bear \
llvm lld compiler-rt libunwind libcxxabi libcxx cfe libedit lldb \
ruby expat tcl tk libunistring libatomic_ops gc guile boost source-highlight util-linux babeltrace gdb \
gettext pcre2 git openssh go rustc zsh bash screen libevent tmux lua vim ctags global \
the_silver_searcher the_platinum_searcher gperf highway fzf graphviz jdk plantuml jq protobuf rsync dtc"

RUN \
apt-get update && apt-get upgrade -y && \
echo Asia/Tokyo > /etc/timezone && \
DEBIAN_FRONTEND=noninteractive \
apt-get install -y --no-install-recommends tzdata && \
apt-get install -y --no-install-recommends \
wget xz-utils \
make gcc g++ \
texinfo \
pkg-config \
libssl-dev ca-certificates \
libpopt-dev \
asciidoc xmlto \
libxt-dev
COPY install_toolchain.sh ${prefix}/install_toolchain.sh
COPY Dockerfile ${prefix}/Dockerfile
RUN \
${prefix}/install_toolchain.sh -p ${prefix} -j ${njobs} "fetch `echo ${pkgs} | sed -e 's/\<ctags\>//'` clang-tools-extra vimdoc-ja mingw-w64"
RUN \
: "FIXME: can't build Emacs26 in Dockerfile. webkit2gtk-4.0-dev libpng-dev libtiff-dev libjpeg-dev libgif-dev libxpm-dev" && \
for p in `echo ${pkgs} | tr - _`; do \
	${prefix}/install_toolchain.sh -p ${prefix} -j ${njobs} install_native_${p} clean || exit; \
done && \
for p in make; do \
	${prefix}/install_toolchain.sh -p ${prefix} -j ${njobs} ${p}_ver=git install_native_${p} clean || exit; \
done && \
${prefix}/install_toolchain.sh -p ${prefix} -j ${njobs} -t x86_64-w64-mingw32 -l c,c++ install_cross_binutils install_cross_gcc clean convert_archives

FROM ${baseimage} AS dev
ARG prefix
ARG prefixbase
ARG username=dev
ARG njobs

COPY --from=builder ${prefix} ${prefix}
COPY --from=builder /etc/ld.so.conf.d/${prefixbase}.conf /etc/ld.so.conf.d/${prefixbase}.conf
COPY dotfiles /etc/skel
RUN \
ldconfig && \
apt-get update && apt-get upgrade -y && \
echo Asia/Tokyo > /etc/timezone && \
DEBIAN_FRONTEND=noninteractive \
apt-get install -y --no-install-recommends tzdata locales && \
apt-get install -y --no-install-recommends \
libc6-dev wget less file man-db \
libssl-dev ca-certificates \
libpopt0 \
libxt6 \
sudo \
&& \
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
apt-get autoremove -y && apt-get autoclean -y && rm -vr /var/lib/apt/lists/* && \
sed -i -e 's/^# \(ja_JP\.UTF-8 UTF-8\)$/\1/' /etc/locale.gen && \
locale-gen
USER ${username}
WORKDIR /home/${username}
ENV LANG=ja_JP.utf8 SHELL=${prefix}/bin/zsh USER=${username}
CMD exec ${SHELL} -l
RUN \
sudo mv -v ${prefix}/lib/rustlib/uninstall.sh . && \
${prefix}/install_toolchain.sh -p tmp -j ${njobs} install_native_rustup clean convert_archives && \
sudo cp -vr tmp/src/rustup ${prefix}/src && \
sudo mv -v uninstall.sh ${prefix}/lib/rustlib && \
rm -vr tmp && \
./.cargo/bin/rustup completions zsh | sudo tee ${prefix}/share/zsh/site-functions/_rustup > /dev/null && \
echo colorscheme molokai > .vim/vimrc.local.vim && \
vim -c 'try | call dein#update() | finally | qall! | endtry' -N -u .vim/vimrc -U NONE -i NONE -V1 -e -s
