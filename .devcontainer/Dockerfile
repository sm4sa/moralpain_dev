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
