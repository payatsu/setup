FROM ubuntu

RUN apt-get update && apt-get upgrade -y

COPY install_toolchain.sh .
ARG prefix=/usr/local

RUN apt-get install -y --no-install-recommends wget xz-utils &&\
./install_toolchain.sh -p ${prefix} -j 4 install_prerequisites

RUN apt-get install -y --no-install-recommends libz-dev bison texinfo &&\
for p in binutils elfutils gmp mpfr mpc isl gcc; do\
	./install_toolchain.sh -p ${prefix} -j 4 install_native_${p} || exit;\
done && ./install_toolchain.sh -p ${prefix} clean

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends libssl-dev libcurl4-openssl-dev libexpat1-dev libpcre2-dev asciidoc xmlto gettext tcl-dev tk-dev &&\
./install_toolchain.sh -p ${prefix} -j 4 install_native_git clean

#======================================================================
# FIXME: build error for go 1.12.1 with go 1.10.3(GCC8.3.0)
#======================================================================
RUN apt-get install -y --no-install-recommends libffi-dev ca-certificates &&\
for p in python ruby go; do\
	./install_toolchain.sh -p ${prefix} -j 4 go_ver=1.11.6 install_native_${p} || exit;\
done && ./install_toolchain.sh -p ${prefix} clean

RUN apt-get install -y --no-install-recommends libncurses5-dev libreadline-dev &&\
./install_toolchain.sh -p ${prefix} -j 4 install_native_gdb clean

RUN for p in zsh bash; do\
	./install_toolchain.sh -p ${prefix} -j 4 install_native_${p} || exit;\
done && ./install_toolchain.sh -p ${prefix} clean

RUN for p in screen libevent tmux; do\
	./install_toolchain.sh -p ${prefix} -j 4 install_native_${p} || exit;\
done && ./install_toolchain.sh -p ${prefix} clean

RUN apt-get install -y --no-install-recommends graphviz &&\
for p in plantuml patch; do\
	./install_toolchain.sh -p ${prefix} -j 4 install_native_${p} || exit;\
done && ./install_toolchain.sh -p ${prefix} clean

# FIXME: 'webkit2gtk-4.0' may be required for emacs.
RUN apt-get install -y --no-install-recommends libperl-dev libpng-dev libtiff-dev libjpeg-dev libgif-dev libxpm-dev &&\
for p in lua vim libiconv ctags; do\
	./install_toolchain.sh -p ${prefix} -j 4 install_native_${p} || exit;\
done && ./install_toolchain.sh -p ${prefix} clean

RUN for p in global the_silver_searcher the_platinum_searcher gperf highway; do\
	./install_toolchain.sh -p ${prefix} -j 4 install_native_${p} || exit;\
done && ./install_toolchain.sh -p ${prefix} clean
