# syntax=docker/dockerfile:experimental

ARG baseimage=ubuntu:20.04
ARG prefix=/usr/local
ARG prefixbase=local
ARG njobs=4

FROM ${baseimage} AS builder
ARG prefix
ARG njobs
ARG pkgs="zlib m4 gmp mpfr mpc isl zstd gcc perl autoconf autoconf-archive \
automake pigz bzip2 xz ncurses readline openssl expat libffi gdbm sqlite \
Python2 Python nghttp2 libunistring libidn2 libpsl curl cmake ninja meson \
pcre libiconv glib pkg-config gettext pcre2 libxml2 libxslt asciidoc \
tcl tk git elfutils binutils bison flex libtool less texinfo gawk cpio zip \
unzip lzip lunzip lzo lzop lz4 file groff libpipeline man-db ed bc patch \
swig Bear ccache llvm lld compiler-rt libunwindnongnu libcxxabi libcxx \
clang libedit lldb ruby libatomic_ops gc guile boost source-highlight \
util-linux popt babeltrace gdb make autogen openssh go rustc \
zsh bash screen libevent tmux lua vim neovim global the_silver_searcher \
the_platinum_searcher gperf highway ripgrep fzf tiff freetype fontconfig \
ghostscript graphviz jdk plantuml jq protobuf rsync dtc strace \
systemtap libbpf bcc bpftrace libcap numactl OpenCSD libpfm perf libpcap \
tcpdump iproute2 nmap libpng jpeg giflib emacs diffutils poke cython numpy \
gstreamer orc gst-plugins-base gst-plugins-good gst-editing-services \
gst-rtsp-server gst-omx opencv v4l-utils"

RUN \
apt-get update && apt-get upgrade -y && \
echo Asia/Tokyo > /etc/timezone && \
DEBIAN_FRONTEND=noninteractive \
apt-get install -y --no-install-recommends tzdata && \
apt-get install -y --no-install-recommends \
wget xz-utils ccache \
make gcc g++ \
texinfo \
pkg-config dpkg-dev \
ca-certificates \
xmlto \
libxt-dev \
libxaw7-dev libxpm-dev
COPY install_toolchain.sh ${prefix}/
RUN --mount=type=cache,target=/root/.ccache --mount=type=cache,target=${prefix}/src \
${prefix}/install_toolchain.sh -p ${prefix} -j ${njobs} "fetch ${pkgs} clang-tools-extra vimdoc-ja opencv_contrib mingw-w64" && \
for p in `echo ${pkgs} | tr - _` ctags; do \
	${prefix}/install_toolchain.sh -p ${prefix} -j ${njobs} install_native_${p} clean shrink_archives || exit; \
done && \
${prefix}/install_toolchain.sh -p ${prefix} -j ${njobs} -t x86_64-w64-mingw32 -l c,c++ install_native_binutils install_cross_gcc clean
COPY Dockerfile ${prefix}/

FROM ${baseimage} AS base
ARG prefix
ARG prefixbase
ARG USER=dev
ARG njobs

COPY --from=builder ${prefix} ${prefix}
COPY --from=builder /etc/ld.so.conf.d/${prefixbase}.conf /etc/ld.so.conf.d/
COPY --from=builder /etc/ld.so.conf.d/${prefixbase}.gcc.conf /etc/ld.so.conf.d/
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
fonts-ricty-diminished \
&& \
wget -O- https://github.com/payatsu/dotfiles/releases/latest/download/dotfiles.tar.gz | tar xzvf - -C /etc/skel --no-same-owner --no-same-permissions && \
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
ENV LANG=ja_JP.UTF-8 SHELL=${prefix}/bin/zsh USER=${USER}
CMD exec ${SHELL} -l
RUN \
sudo mv -v ${prefix}/lib/rustlib/uninstall.sh . && \
${prefix}/install_toolchain.sh -p tmp -j ${njobs} install_native_rustup clean shrink_archives && \
sudo cp -vr tmp/src/rustup ${prefix}/src && \
sudo mv -v uninstall.sh ${prefix}/lib/rustlib && \
rm -vr tmp && \
./.cargo/bin/rustup completions zsh | sudo tee ${prefix}/share/zsh/site-functions/_rustup > /dev/null && \
./.cargo/bin/rustup component add rls rust-analysis rust-src && \
echo colorscheme jellybeans > .vim/vimrc.local.vim && \
vim -c 'try | call dein#update() | finally | qall! | endtry' -N -u .vim/vimrc -U NONE -i NONE -V1 -e -s && \
nvim -c 'try | call dein#update() | finally | qall! | endtry' -N -u .config/nvim/init.vim -U NONE -i NONE -V1 -e -s

FROM base AS daemon
USER root
WORKDIR /
RUN \
useradd sshd && \
apt-get update && apt-get upgrade -y && \
apt-get install -y --no-install-recommends xauth && \
apt-get autoremove -y && apt-get autoclean -y && rm -vr /var/lib/apt/lists/* && \
sed -i -e 's/^#\(X11Forwarding\) no$/\1 yes/' /usr/local/etc/sshd_config
EXPOSE 22
CMD ["/usr/local/sbin/sshd", "-D"]
