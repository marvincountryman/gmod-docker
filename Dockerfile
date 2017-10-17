FROM debian:wheezy
LABEL maintainer="marvincountryman@gmail.com"

# Setup Environment
RUN \
    dpkg --add-architecture i386 && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
        lib32gcc1 \
        lib32ncurses5 \
        lib32z1 \
        wget \
    && \

    # Setup gmod user 
    useradd -rmd /home/gmod gmod && \

    # Setup install folders/permissions
    mkdir -p /steamcmd && \
    mkdir -p /gmod && \
    mkdir -p /tmp/gmod-fix && \
    chown -hR gmod:gmod /steamcmd && \
    chown -hR gmod:gmod /gmod && \
    chown -hR gmod:gmod /tmp/gmod-fix && \

    # Install fix libraries
    cd /tmp/gmod-fix && \
    wget http://launchpadlibrarian.net/195509222/libc6_2.15-0ubuntu10.10_i386.deb && \
    dpkg -x libc6_2.15-0ubuntu10.10_i386.deb .

# Switch to non-root user
USER gmod
    
# Install SteamCMD
RUN \
    # Install steamcmd/gmod
    cd /steamcmd && \
    wget http://media.steampowered.com/installer/steamcmd_linux.tar.gz && \
    tar -xvzf steamcmd_linux.tar.gz

# Install Garry's Mod 
RUN \   
    cd /gmod && \
    /steamcmd/steamcmd.sh \
        +login anonymous \
        +force_install_dir /gmod \
        +app_update 4020 \
        validate \
        +quit

# Install library fixes
RUN \
    cp /tmp/gmod-fix/lib/i386-linux-gnu/* /gmod/bin/ && \
    cp /steamcmd/linux32/libstdc++.so.6 /gmod/bin

EXPOSE 27015/udp
VOLUME [ \
    "/gmod", \
    "/gmod/garrysmod/lua", \
    "/gmod/garrysmod/addons" \
]

ENV CMAP="gm_construct"
ENV CPORT="27015"
ENV CHOSTNAME="Garry's Mod"
ENV CGAMEMODE="sandbox"
ENV CMAXPLAYERS="16"

COPY script/run.sh /home/gmod/run.sh

CMD ["/bin/sh", "/home/gmod/run.sh"]