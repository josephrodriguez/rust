FROM ubuntu:latest

# Install dependencies
RUN apt update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        bash \
        bzip2 \
        cmake \
        clang \
        cpio \
        curl \
        g++ \
        g++-aarch64-linux-gnu \
        g++-mingw-w64-x86-64 \
        gcc \
        gcc-x86-64-linux-gnu \
        git \
        gzip \
        libbz2-dev \
        libgmp-dev \
        libmpc-dev \
        libmpfr-dev \
        libssl-dev \
        libudev-dev \
        libxml2-dev \
        llvm-dev \
        make \
        mingw-w64 \
        patch \
        sed \
        tar \
        uuid-dev \
        xz-utils \
        zlib1g-dev \
    && apt-get clean \
    && apt-get autoclean \
    && apt-get autoremove --purge \
    && rm -rf /var/lib/apt/lists/*

# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y 

# Install MacOSX cross compiler
RUN git clone https://github.com/tpoechtrager/osxcross \
     && curl -LO https://github.com/joseluisq/macosx-sdks/releases/download/13.3/MacOSX13.3.sdk.tar.xz \
     && mv MacOSX13.3.sdk.tar.xz osxcross/tarballs/ \
     && cd osxcross \
     && UNATTENDED=yes OSX_VERSION_MIN=10.12 ./build.sh

ENV PATH="/root/.cargo/bin:${PATH}"
ENV PATH="/osxcross/target/bin:$PATH"

CMD ["cargo", "--version"]