FROM docker.io/redhat/ubi9:latest AS builder

RUN ["apk", "add", "--no-cache", "--repository=https://dl-cdn.alpinelinux.org/alpine/edge/community", "hugo"]

WORKDIR /tmp

COPY RLCraft_Server_Pack_1.12.2_-_Release_v2.9.3.zip/ .

RUN ["unzip", "RLCraft_Server_Pack_1.12.2_-_Release_v2.9.3.zip"]

RUN ["rm", "RLCraft_Server_Pack_1.12.2_-_Release_v2.9.3.zip"]

COPY forge-1.12.2-14.23.5.2860-installer.jar .

FROM eclipse-temurin:8-ubi9-minimal

# Set the environment variables for JVM options
ENV JAVA_XMX="4096M"
ENV JAVA_XMS="4096M"

RUN ["mkdir", "/opt/rlcraft"]

WORKDIR "/opt/rlcraft"

RUN useradd -ms /bin/bash mc-admin

RUN ["chown", "-R", "mc-admin:mc-admin", "/opt/rlcraft"]

USER mc-admin

COPY --chown=mc-admin:mc-admin --from=builder /tmp/forge-1.12.2-14.23.5.2860-installer.jar .

RUN ["java", "-Xmx1024M", "-Xms1024M", "-jar", "forge-1.12.2-14.23.5.2860-installer.jar", "--installServer"]

COPY --chown=mc-admin:mc-admin --from=builder /tmp/ .

COPY --chown=mc-admin:mc-admin ./eula.txt .

COPY --chown=mc-admin:mc-admin ./server.properties .

CMD java -Xmx${JAVA_XMX} -Xms${JAVA_XMS} -jar forge-1.12.2-14.23.5.2860.jar --nogui
