# Development Environment for a Moral Distress Learning System

SORRY, UNDER CONSTRUCTION. THERE ARE INCONSISTENCIES WITHIN. --SULLIVAN

You have come across a repository related to our work at the University of Virginia to build and employ a platform for managing and learning about moral distress and responses to it. The only reason to spend much time here at the moment is that you're a member of our team already, or a close colleague, or you're looking to join. In that case, these instructions should suffice to get you up and running with a development and test environment. It comes in two parts: first you will configure your computer with software needed to run an Android emulator; and second, you will fork this repo then clone your fork to your local machine, whereupon you will commence to operate on it through a containerized operating system running within VSCode. For part one, we give instructions for setting up Mac/Linux and Windows machines, respectively. The instructions are the same for part two for both Mac/Linux and Windows operating systems.

## I. Install the Android emulator

### Mac/Linux

Install the [Homebrew][2] package manager if it's not already installed. 

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install Docker Desktop if its not already installed.

```bash
brew install docker
```

Install VSCode if it's not already installed. 

```bash
brew install --cask visual-studio-code
```

Run VS code and install its "remote containers" extension.


### Windows

#### Package Manager

Install the [chocolatey][3] package manager if it's not already installed.


#### Docker 

```bash
choco install docker-desktop
```

#### Visual Studio Code 

```PowerShell
choco install vscode
```

Run VS code and install its "remote containers" extension. 

#### Java

If you don't already have Java installed on your machine, [install it][15].

#### Android sdkmanager

This task installs sdkmanager among other components needed for the Android 
emulator to run. Once you have it, you will use it to install additional
Android packages needed by the emulator. 

- Create or initialize the directory, C:\Android. 
- CD to this directory. 
- Download "Command Line Tools" [zip file][14]. 
- Unzip it in place
- CD into just unzipped cmdline_tools directory.
- Create a subdirectory called tools ("mkdir tools")
- Move all the contents of this cmdline_tools directory to tools ("mv * tools")
- Create/update Windows environment variable, ANDROID_SDK_ROOT="C:\Android"
- Add the following paths to the Windows User or System search path
-- "C:\Android\cmdline_tools\tools\bin"
-- TODO: There are more, Kevin; add them
- Exit and restart your terminal/shell to update its search path

#### Android packages

- sdkmanager "platform-tools" "platforms;android-31" "emulator".

#### Emulator

avdmanager create avd --name avd_31 --package "system-images;android-31;google_apis;x86_64"

#### Disable warning

```PowerShell
echo # > c:\qemu.conf
```

#### Chrome Browser

- Install the Chrome browser if necessary
- Make it your default browser (sorry but it's required)
- Run it and install the Chrome "Dart Debug" extension


## II. Fork and Clone our Repo


## III. Run server software and emulator on host machine

### Mac/Linux

```bash
./launch_emulator
```

### Windows

```PowerShell
adb start-server
emulator -avd avd_31
adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done;'
```

## Opening your clone of your fork of the Project in VS Code

Fork this repository to contribute to development of UVa's Moral Distress Reporting, Analysis, and Response system, a joint project between the Department of Computer Science and the School or Nursing. Follow the steps below and in a few minutes you should have a GitHub-repo-backed, VSCode-provided IDE opened to edit a fork of this repository cloned into a Docker container.  



Next, open up the `moralpain_dev` repository in VS Code. There will be several
prompts to click through. You should, "Trust the Authors", "Reopen in
Container", and "Install Recommended Extensions".  

VS Code will initialize your project. When done, in the bottom of the window
you should see an Android device listed.  

At this point, your environment is all set up. From here you can navigate to
the `main.dart` file and select the run button the appears above the `main`
method. This will build the application and launch it in the emulator.

## OLDER STUFF

### How It Works

We deliver a development environment via VSCode and its *Remote-Containers* capabilities. In a nutshell, when you ask VSCode to clone our repository, it will actually fork it and then clone your fork into the container that it launches to provide the programming platform you will then use to develop your solutions. It is very important to commit changes you make to your container-local repository, but then also to push them to your GitHub repo to back them up and because that should be the main repository for your project. You can log into it by simply opening a Terminal in VSCode. The clone of your repo is in the /workspaces folder within the container file system (or storage *volume*, as it's called).

### Risk Alert and Avoidance

It is important to understand that commits made to git are stored in the Docker container serving up the develop environment.  if you delete the container or its storage volume (which you could do through Docker Desktop), this will erase the work stored in the container. To make your container-local changes persistent, stage/add and then commit your local changes to the local repo, then push your container-repo-local changes to your repository on GitHub.

### Help Make It Even Better

Let us know what you think. Better yet, make it better and send us a PR. You'll be completely set up to do that by the results of this procedure.

## Legal and contact

Copyright: © 2021, 2022 By Rectors and Visitors of the University of Virginia.
Authors: Nicholas Phair, Vanessa Amos, Beth Epstein, Kevin Sullivan. 
Contact Author: Kevin Sullivan. UVa CS Dept. sullivan@virginia.edu.
Acknowledgments: Thank you to multiple students for reading, testing, fixing.


[1]: https://wiki.debian.org/Apt
[2]: https://brew.sh/
[3]: https://chocolatey.org/
[4]: https://flutter.dev/docs/get-started/install
[5]: https://dart.dev/
[6]: https://developer.android.com/studio
[7]: https://developer.android.com/studio/run/emulator#install
[8]: https://code.visualstudio.com/
[10]: https://www.gnu.org/software/bash/
[11]: https://docs.microsoft.com/en-us/powershell/
[12]: https://github.com/kevinsullivan/moralpain_config
[13]: https://code.visualstudio.com/docs/remote/containers
[14] https://developer.android.com/studio/#downloads
[15] https://www.java.com/en/download/manual.jsp

## JUNK

git and git-lfs

First, install git and git-lfs. Git will be used for cloning the code base locally and for managing the project.

__macOS__
```bash
brew install git git-lfs
```

__Windows__
```PowerShell
choco install git git-lfs.install
```

---

Next, let us use git to clone the repository.

__macOS__
```bash
git clone https://github.com/kevinsullivan/moralpain_dev.git
```

__Windows__
```PowerShell
git clone https://github.com/kevinsullivan/moralpain_dev.git
```

Once cloned, navigate to the `bin` directory and run the `install_emulator` script.
When prompted accept the licenses and default hardware profile.

__macOS__
```bash
cd moralpain_dev/bin
./install_emulator
```

__Windows__
```PowerShell
cd moralpain_dev\bin
.\install_emulator.ps1
```


The install script will update the `PATH` environment variable. For the changes
to take effect, you will need reload your shell configurations. One easy way to
do this is simply to restart the shell. We can claim success if we can locate
the Android tooling.

__macOS__
```bash
which sdkmanager || echo "tooling not found"
```

__Windows__
```PowerShell
Get-Command sdkmanager 
```




