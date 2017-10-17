### gmod-docker

gmod-docker is a simple Garry's Mod server in a docker container. This container applies several fixes to libraries provided by [suchipi](https://github.com/suchipi).

### Volumes
* `/gmod` - Root garry's mod folder
* `/gmod/garrysmod/lua` - Lua folder
* `/gmod/garrysmod/addons` - Addons folder

### Environment Variables
* CMAP=`"gm_construct"`
* CPORT=`"27015"`
* CHOSTNAME=`"Garry's Mod"`
* CGAMEMODE=`"sandbox"`
* CMAXPLAYERS=`"16"`

### Usage

Run interactive console
```bash
docker run -it --rm -v 27015:27015/udp countmarvin/gmod-docker:latest 
```

Run in background
```bash
docker run -d \
    -p 27015:27015/udp \
    -v ~/server1/addons:/gmod/garrysmod/addons \
    -e CMAP="gm_flatgrass" \
    -e CHOSTNAME="server1" \
    countmarvin/gmod-docker
```

### Reporting Bugs / Feature Request
Feel free to open [an issue](https://github.com/marvincountryman/gmod-docker/issues/new)

### Credit
* [suchipi](https://github.com/suchipi)