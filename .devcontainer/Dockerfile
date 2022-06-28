# Copyright © 2001 by the Rectors and Visitors of the University of Virginia. 

# Extend vm built by pdrvm_configure
FROM docker.io/kevinsullivan/moralpain

ARG FLUTTER_VERSION=2.5.0

# Create image without any user interaction
ENV DEBIAN_FRONTEND=noninteractive
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Your VM extensions go here (below)
WORKDIR /opt
ADD https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz /opt
RUN tar xJvf /opt/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz
ENV PATH="/opt/flutter/bin:${PATH}"
RUN flutter doctor

ENTRYPOINT ["flutter"]
CMD ["doctor"]

# Support for Android Studio

# RUN apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386 

# We need git-lfs

RUN curl -sLO https://github.com/github/git-lfs/releases/download/v2.0.1/git-lfs-linux-amd64-2.0.1.tar.gz \
    && tar zxvf git-lfs-linux-amd64-2.0.1.tar.gz \
    && mv git-lfs-2.0.1/git-lfs /usr/bin/ \
    && rm -rf git-lfs-2.0.1 \
    && rm -rf git-lfs-linux-amd64-2.0.1.tar.gz