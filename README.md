<h1 align="center">
  <br>
    <img src="https://upload.wikimedia.org/wikipedia/commons/1/10/Synfig_logo.svg" alt="Synfig" width="150">
    <img src="https://avatars.githubusercontent.com/u/16617932?s=280&v=4" alt="Git" width="180" style="position:relative; bottom:17px;">
  <br>
  Synfig AppImage Generator
  <br>
</h1>

<h4 align="center">A bash script that uses the <a href="https://www.synfig.org/" target="_blank">Synfig</a>  build to automatically generate a Synfig <a href="https://appimage.org/" target="_blank">AppImage</a></h4>

# How To Use

> [!IMPORTANT]
> For the below, you'll need to be on a 64-bit Linux, have <a href="https://git-scm.com/" target="_blank">Git</a> installed, and all the packages on your system upgraded to the latest versions

### 1. Clone this Repo
```
$ git clone https://github.com/Ahmed-Khaled-dev/synfig-appimage.git
```

### 2. Build Synfig on Linux

Move inside ``synfig-appimage`` and run the below
```
$ chmod +x build-synfig.sh
$ ./build-synfig.sh
```

> [!TIP]
> This will take a bit of time

After it is finished you should have a directory called ``build`` inside ``synfig-appimage``

If yes, then Hooray you have built Synfig! 🎉

### 3. Generate Synfig's AppImage

While inside ``synfig-appimage`` run the below
```
$ chmod +x generate-synfig-appimage.sh
$ ./generate-synfig-appimage.sh
```

After it finishes you should find a file called **Synfig_Studio-x86_64.AppImage** inside the ``synfig-appimage`` directory

if yes, then Hooray you have generated a Synfig AppImage! 🎉

Now you can test it by doing

```
$ chmod +x Synfig_Studio-x86_64.AppImage
$ ./Synfig_Studio-x86_64.AppImage
```
