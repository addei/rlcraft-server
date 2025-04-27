# rlcraft-server
Repository for rlcraft podman deployment on top of the Fedora Core OS

## NOTE
Server runs old binaries (project has not been updated for a while), thus has it's own security risks!!!
(for instance logj4 vulnerability!)

This repo is for archiving only.

## Prerequisites and steps
1. Download RLCraft_Server_Pack_1.12.2_-_Release_v2.9.3.zip and forge-1.12.2-14.23.5.2860-installer.jar zip files.
2. Copy .zip to project root folder.
3. Set eula.txt ```eula=true``` if you agree with Minecraft eula
4. Change server.properties
5. Build the Containerfile
6. Create ignition file using butane
7. Inject ignition file to coreOS iso image.