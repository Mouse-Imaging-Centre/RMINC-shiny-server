Docker container for Shiny-Server with RMINC
=======================

This is an informal fork of lc0/docker-shiny-server plus some extra dressing to get
minc-toolkit-v2 and RMINC installed.

## Usage:

To run a container with Shiny Server
```sh
docker run -d -p 4000:3838 <image>
```
In order to run your application you can use [Docker Volumes](https://docs.docker.com/engine/userguide/containers/dockervolumes/)
```sh
docker run -d -p 4000:3838 -v ~/pop:/srv/shiny-server/pop <image>
```
In this case, our application is located in ~/pop. Running application should be available by URL:

```sh
echo http://<your-host-ip>:4000/pop
````
Now you can just edit you R files, without a need to rebuild an image every time. Be aware, folder sharing works for OSX docker-machine automatically only if your project is located in a home directory.

