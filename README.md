# Docker image for HDHomeRun on NAS

This is a Dockerfile for running the [HDHomeRun RECORD](https://www.silicondust.com/dvr-service/) software on certain network attached storage (NAS) devices.  This approach assumes that you already have a NAS present to store your videos, and you want to run HDHomeRun on it in a way that will survive reboots.
For example, it's possible to run the HDHomeRun RECORD engine on Synology NAS devices; however, the software won't survive a reboot of the NAS.  Using docker, we can make the HDHomeRun RECORD engine persist operation across reboots.

# Requirements 

* Command line access to the NAS device
* An HDHomeRun device with DVR service activated

# Steps

* You'll need to install both docker and git on your NAS system in order to compile the most recent image for your NAS.  If you are using Synology, install the following official Synology packages on your Synology device:
	* [Docker](https://www.synology.com/en-us/dsm/feature/docker)
	* [Git Server](https://www.synology.com/en-us/knowledgebase/DSM/help/Git/git)
* If you have not done so, create a shared directory or mount on the NAS device, name it, and give it appropriate permissions for your network.  Your video recordings are going to go here.  I'll refer to this shared directory *$your_share*.
	* On my Synology NAS, I used the Shared Folders control panel item to create a share called "HDHomeRun" which shares the directory /volume1/HDHomeRun . 
* Run the following commands.
```Shell
git clone https://www.github.com/johnwbyrd/docker-synology-hdhomerun
docker build -t johnwbyrd/docker-synology-hdhomerun .
```
* On the next line, you'll need to replace *$your_share* with the share that you chose before.  In my case, I use "/volume1/HDHomeRun".
```Shell
docker run -d --net=host --restart always -v $your_share:/hdhomerun/video:rw johnwbyrd/docker-synology-hdhomerun
```
	
# Notes

Some people may be concerned about using --net=host on a docker container.  In this case, I am not providing any binaries, so you can read through all the files in this directory and verify exactly what this container is doing.  In particular, this is the simplest way for the container to magically get the right IP address and port of the host so that the engine can handshake easily with the HDHomeRun device.
If HDHomeRun updates their record engine, you will need to run the docker build step again to make sure the newest record engine is always present in the container.

# Todo

- Detect when HDHomeRun updates their record engine and gracefully update without having to remake the image from scratch
- Volume support for non-share-dependent persistence
- Optional Samba support for non-NAS devices

# Getting help and contributing

- A clear and concisely written [bug report](https://testlio.com/blog/the-ideal-bug-report/) is most likely to generate a response from me.

If you can improve this Docker image and documentation, please do so.  I gladly accept sensible pull requests; just fork it and send me a pull request if you make an improvement.

# Credits

- Most of the concepts here were originally fleshed out by arjones67.  I simplified the formula and made it a little more maintainable.






