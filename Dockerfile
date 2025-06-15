# --- Base image with specific Java version ---
ARG JAVA_VERSION=21
FROM eclipse-temurin:${JAVA_VERSION}-jre-alpine

# --- Build arguments and environment variables ---
ARG EULA=true
ARG PORT=25565
ARG GREGTECH_VERSION=2.7.4
ARG USER="minecraft"

ENV GREGTECH_VERSION=$GREGTECH_VERSION \
      USER=${USER} \
      HOME_DIR=/home/${USER} \
      EULA=${EULA}

# --- Labels for metadata ---
LABEL image.title="GregTech - New Horizons" \
      image.description="Ein Docker-Image für einen Minecraft Greg Tech - New Horizons Server" \
      image.version="1.0" \
      image.source="https://github.com/Sling2009/gregTech.git" \
      image.licenses="MIT" \
      image.authors="Axel Fischer <axel.fischer@fam-fis.de>" \
      minecraft.gregtech.version=${GREGTECH_VERSION} \
      minecraft.java.version=${JAVA_VERSION}

# --- Install required packages ---
RUN apk update && apk add --no-cache unzip curl bash shadow

# --- Create non-root user ---
RUN groupadd -g 100 ${USER} && \
      useradd -m -u 99 -g 100 -d ${HOME_DIR} -s /bin/bash ${USER}

# Set working directory and copy launch script ---
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh && \
      chown ${USER}:${USER} /entrypoint.sh && \
      ln -s /entrypoint.sh /usr/local/bin/entrypoint

# --- Set permissions and switch to non-root user ---
USER ${USER}

VOLUME ${HOME_DIR}
WORKDIR ${HOME_DIR}

# --- Expose server port ---
EXPOSE ${PORT}

# --- Entry point ---
ENTRYPOINT ["entrypoint"]

