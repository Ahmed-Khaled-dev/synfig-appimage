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

### 1. Build Synfig on Linux

Follow the below steps

> [!IMPORTANT]
> For the below, you'll need <a href="https://git-scm.com/" target="_blank">Git</a> installed and all the packages on your system upgraded to the latest versions

Clone Synfig's Repository
```
$ git clone https://github.com/synfig/synfig.git
```

Download Synfig's Dependencies, while you are inside the Synfig repo that you just cloned, run:
```
$ ./1-setup-linux-native.sh
```

After the above has finished, build Synfig for Production by running:
```
$ ./2-build-production.sh
```

> [!TIP]
> This will take a bit of time

After it is finished you should have the following folder inside the Synfig repository ``_production/build``

If yes, then Hooray you have built Synfig! 🎉

### 2. Clone this Repo
```
$ git clone https://github.com/Ahmed-Khaled-dev/synfig-appimage.git
```

### 3. Copy the _production/build directory inside synfig-appimage/

Note, only copy the ``build`` directory, don't copy the directory ``_production``

### 4. Run the Script

Move inside ``synfig-appimage`` and run the below
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
