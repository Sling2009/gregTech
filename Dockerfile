ARG JAVA_VERSION=21
ARG GREGTECH_VERSION=2.7.4
FROM eclipse-temurin:${JAVA_VERSION}-jre-alpine

LABEL org.opencontainers.image.title="GregTech - New Horizons"
LABEL org.opencontainers.image.description="Ein Docker-Image für einen Minecraft Greg Tech - New Horizons Server"
LABEL org.opencontainers.image.version="1.0"
LABEL org.opencontainers.image.url=""
LABEL org.opencontainers.image.source="https://github.com/Sling2009/gregTech.git"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.authors="Axel Fischer <axel.fischer@fam-fis.de>"
LABEL minecraft.gregtech.version="${GREGTECH_VERSION}"
LABEL minecraft.java.version="${JAVA_VERSION}"
