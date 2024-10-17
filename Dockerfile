FROM debian:bullseye




# Install git, supervisor, VNC, & X11 packages
RUN set -ex; \
    
    
    apt-get update; \
    apt-get install -y \
      bash \
      fluxbox \
      git \
      net-tools \
      novnc \
      supervisor \
      x11vnc \
      xterm \
      xvfb
    wget https://github.com/kasmtech/KasmVNC/releases/download/v1.3.2/kasmvncserver_bullseye_1.3.2_arm64.deb
    apt-get install ./kasmvncserver_*.deb
    sudo adduser $USER ssl-cert


# Setup demo environment variables
ENV HOME=/root \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=1024 \
    DISPLAY_HEIGHT=768 \
    RUN_XTERM=yes \
    RUN_FLUXBOX=yes
COPY . /app
CMD ["/app/entrypoint.sh"]
EXPOSE 8080
