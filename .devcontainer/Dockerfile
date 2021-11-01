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

# Now stuff for Android, IOS, and Flutter

RUN mkdir -p /root/workspaces/moralpain_dev/moralpain/Android/sdk
ENV ANDROID_SDK_ROOT /root/workspaces/moralpain_dev/moralpain/Android/sdk
RUN mkdir -p /root/workspaces/moralpain_dev/.android && touch /root/workspaces/moralpain_dev/.android/repositories.cfg

RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip sdk-tools.zip && rm sdk-tools.zip
RUN mv tools /root/workspaces/moralpain_dev/moralpain/Android/sdk/tools

RUN cd /root/workspaces/moralpain_dev/moralpain/Android/sdk/tools/bin && yes | ./sdkmanager --licenses
RUN cd /root/workspaces/moralpain_dev/moralpain/Android/sdk/tools/bin && ./sdkmanager "build-tools;29.0.2" "patcher;v4" "platform-tools" "platforms;android-29" "sources;android-29"
ENV PATH "$PATH:/root/workspaces/moralpain_dev/moralpain/Android/sdk/platform-tools"

# Download Flutter SDK
# RUN git clone https://github.com/flutter/flutter.git
# ENV PATH "$PATH:/root/workspaces/moralpain_dev/moralpain/flutter/bin"

# Run basic check to download Dark SDK
RUN flutter doctor