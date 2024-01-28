[![Docker Build Status](https://img.shields.io/docker/cloud/build/cyborghosting/steamcmd.svg)](https://hub.docker.com/r/cyborghosting/steamcmd/) [![Docker Stars](https://img.shields.io/docker/stars/cyborghosting/steamcmd.svg)](https://hub.docker.com/r/cyborghosting/steamcmd/) [![Docker Pulls](https://img.shields.io/docker/pulls/cyborghosting/steamcmd.svg)](https://hub.docker.com/r/cyborghosting/steamcmd/) [![](https://img.shields.io/docker/image-size/cyborghosting/steamcmd)](https://img.shields.io/docker/image-size/cyborghosting/steamcmd)
# Supported tags and respective `Dockerfile` links
  -	[`latest`  (*bullseye/Dockerfile*)](https://github.com/cyborg-hosting/steamcmd/blob/master/bullseye/Dockerfile)

# What is SteamCMD?
The Steam Console Client or SteamCMD is a command-line version of the Steam client. Its primary use is to install and update various dedicated servers available on Steam using a command-line interface. It works with games that use the SteamPipe content system. All games have been migrated from the deprecated HLDSUpdateTool to SteamCMD. This image can be used as a base image for Steam-based dedicated servers (Source: [developer.valvesoftware.com](https://developer.valvesoftware.com/wiki/SteamCMD)).

# How to use this image
Whilst it's recommended to use this image as a base image of other game servers, you can also run it in an interactive shell using the following command:
```console
$ docker run -it --name=steamcmd cyborghosting/steamcmd bash
$ ./steamcmd.sh +force_install_dir /home/user/tf-dedicated +login anonymous +app_update 232250 +quit
```
This can prove useful if you are just looking to test a certain game server installation.

## Configuration
This image includes the `vi` text editor for convenience. 

The `steamcmd.sh` can be found in the following directory: `/steamcmd`

## Examples
Images utilizing this base image:

| Image  | Pulls | Build Status |
| ------------- | ------------- | ------------- |
| [cyborghosting/srcds](https://hub.docker.com/r/cyborghosting/srcds/) | [![Docker Pulls](https://img.shields.io/docker/pulls/cyborghosting/srcds.svg)](https://hub.docker.com/r/cyborghosting/srcds/) | [![Docker Build Status](https://img.shields.io/docker/cloud/build/cyborghosting/srcds)](https://hub.docker.com/r/cyborghosting/srcds/) |

# Contributors
[![Contributors Display](https://badges.pufler.dev/contributors/cyborg-hosting/steamcmd?size=50&padding=5&bots=false)](https://github.com/cyborg-hosting/steamcmd/graphs/contributors)
