ARG baseimage=ubuntu:18.04
ARG prefix=/usr/local
ARG prefixbase=local
ARG njobs=4

FROM ${baseimage} AS builder
ARG prefix
ARG njobs
ARG pkgs="zlib binutils m4 gmp mpfr mpc isl gcc \
bzip2 elfutils bison flex perl autoconf autoconf-archive automake libtool ncurses readline less texinfo \
gawk cpio xz zip unzip lzip lunzip lzo lzop lz4 zstd file groff gdbm libpipeline man-db ed bc patch ccache \
pcre swig libffi openssl Python2 Python libxml2 libiconv ninja meson glib pkg-config nghttp2 curl cmake Bear \
llvm lld compiler-rt libunwind libcxxabi libcxx clang libedit lldb \
ruby expat tcl tk libunistring libatomic_ops gc guile boost source-highlight util-linux popt babeltrace gdb make \
autogen gettext pcre2 asciidoc git openssh go rustc zsh bash screen libevent tmux lua vim neovim global \
the_silver_searcher the_platinum_searcher gperf highway fzf graphviz jdk plantuml jq protobuf rsync dtc \
strace systemtap libpng tiff jpeg giflib"

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
ca-certificates \
xmlto \
libxt-dev \
libxaw7-dev libxpm-dev
COPY install_toolchain.sh ${prefix}/
RUN \
${prefix}/install_toolchain.sh -p ${prefix} -j ${njobs} "fetch ${pkgs} clang-tools-extra vimdoc-ja mingw-w64"
RUN \
for p in `echo ${pkgs} | tr - _` ctags; do \
	${prefix}/install_toolchain.sh -p ${prefix} -j ${njobs} install_native_${p} clean shrink_archives || exit; \
done
RUN \
${prefix}/install_toolchain.sh -p ${prefix} -j ${njobs} -t x86_64-w64-mingw32 -l c,c++ install_native_binutils install_cross_gcc clean
COPY Dockerfile ${prefix}/

FROM ${baseimage} AS dev
ARG prefix
ARG prefixbase
ARG USER=dev
ARG njobs

COPY --from=builder ${prefix} ${prefix}
COPY --from=builder /etc/ld.so.conf.d/${prefixbase}.conf /etc/ld.so.conf.d/
COPY --from=builder /etc/ld.so.conf.d/${prefixbase}.gcc.conf /etc/ld.so.conf.d/
COPY dotfiles /etc/skel
RUN \
ldconfig && \
apt-get update && apt-get upgrade -y && \
echo Asia/Tokyo > /etc/timezone && \
DEBIAN_FRONTEND=noninteractive \
apt-get install -y --no-install-recommends tzdata locales && \
apt-get install -y --no-install-recommends \
libc6-dev wget \
ca-certificates \
libxt6 \
libxaw7 libxpm4 \
sudo \
&& \
rm -v /etc/skel/install.sh /etc/skel/seq.puml && \
echo . ${prefix}/set_path.sh > /etc/skel/.sh/.local.pre && \
echo . '${HOME}'/.sh/.local.pre > /etc/skel/.zsh/.zshrc.local.pre && \
echo . '${HOME}'/.sh/.local.pre > /etc/skel/.bash/.bashrc.local.pre && \
echo `which zsh` >> /etc/shells && \
groupadd ${USER} && \
useradd -g ${USER} -m -s `which zsh` ${USER} && \
echo root:root | chpasswd && \
echo ${USER}:${USER} | chpasswd && \
sed -i -e '/^root\>/a'${USER}'	ALL=(ALL:ALL) NOPASSWD: ALL' /etc/sudoers && \
apt-get autoremove -y && apt-get autoclean -y && rm -vr /var/lib/apt/lists/* && \
sed -i -e 's/^# \(ja_JP\.UTF-8 UTF-8\)$/\1/' /etc/locale.gen && \
locale-gen
USER ${USER}
WORKDIR /home/${USER}
ENV LANG=ja_JP.utf8 SHELL=${prefix}/bin/zsh USER=${USER}
CMD exec ${SHELL} -l
RUN \
sudo mv -v ${prefix}/lib/rustlib/uninstall.sh . && \
${prefix}/install_toolchain.sh -p tmp -j ${njobs} install_native_rustup clean shrink_archives && \
sudo cp -vr tmp/src/rustup ${prefix}/src && \
sudo mv -v uninstall.sh ${prefix}/lib/rustlib && \
rm -vr tmp && \
./.cargo/bin/rustup completions zsh | sudo tee ${prefix}/share/zsh/site-functions/_rustup > /dev/null && \
./.cargo/bin/rustup component add rls && \
echo colorscheme jellybeans > .vim/vimrc.local.vim && \
vim -c 'try | call dein#update() | finally | qall! | endtry' -N -u .vim/vimrc -U NONE -i NONE -V1 -e -s && \
nvim -c 'try | call dein#update() | finally | qall! | endtry' -N -u .config/nvim/init.vim -U NONE -i NONE -V1 -e -s
