# Onboarding
Configure your computer for development in this project

UVa Moral Distress Reporting, Analysis, and Response project. Department of Computer Science and the School or Nursing. Follow the steps below to build and change our software. Contact Kevin Sullivan UVa Dept. Computer Science, sullivan@virginia.edu, for more information. 

## Configure your local host machine (PC/laptop)

### Package manager

If not yet installed, install standard manager:

Mac: [Homebrew][2]
Windows: [chocolatey][3]

### Git and git-lfs

Mac:

```bash
brew install git git-lfs
```

Windows:

```PowerShell
choco install git git-lfs.install
```

### Docker Desktop

Mac:

```bash
brew install docker
```

Windows:

```bash
choco install docker-desktop
```

### VSCode / Remote Containers

Mac:

```bash
brew install --cask visual-studio-code
```

Windows:

```PowerShell
choco install vscode
```

Run VSCode and install its Remote Containers extension.

### Java

Install it if it's not already installed.

[Java][15]

### Chrome or Edge

Your default browser has to support the Dart Debug extension and as of this writing only the Chrome and Edge browsers satisfy this requirement. Firefox does not. 

1. install the Chrome or Edge browser if necessary
2. Make it your default browser (at least temporarily)
3. Run it and install the Chrome "Dart Debug" extension

### Our software

Fork our repository into your GitHub account. Then clone that repository to your local machine.

```sh
git clone https://github.com/<your-github-id>/moralpain_dev.git
```

Open your cloned `moralpain_dev` folder in VS Code. There will be several prompts to
click through. You should, "Trust the Authors", "Reopen in Container", and "Install
Recommended Extensions". VS Code will initialize your project. When done, in the
bottom of the window you should see an Android device listed.  

### Android tools

MAC:


```bash
brew install wget
```

```bash
cd to <your_clone_directory>/bin 
./install_emulator
```

When prompted accept the licenses and default hardware profile.
The install script will update the `PATH` environment variable. For the changes
to take effect, you will need to exit and restart your shell. On Windows, it's still a manual chore. Use Powershell.


WINDOWS:

#### Android tools


- Create or initialize the directory, C:\Android
- CD to this directory
- Download Android's "Command Line Tools" [zip file][14]
- Unzip the new zip file in place (in C:\Android)
- CD into just unzipped cmdline_tools directory
- Create a subdirectory called tools ("mkdir tools")
- Move all the contents of the cmdline_tools directory (but for tools) into tools ("mv * tools")
- Create/update the Windows environment variable, ANDROID_SDK_ROOT="C:\Android"
  - Right-click on the windows logo at the bottom-left of your screen -> system -> advanced system settings -> System Variables 
- Add the following paths to the Windows User or System search path
  - "C:\Android\cmdline-tools\tools\bin"
  - "C:\Android\emulator"
  - "C:\Android\platform-tools"

- Avoid spurious warning by running this command: echo # > c:\qemu.conf
- Exit and restart your terminal/shell

#### Android SDK

- Run: sdkmanager "platform-tools" "platforms;android-31" "emulator"

#### Install APIs

Make sure you have all the modules installed. Run sdkmanager --list and look at the top of the output for the currently installed packages. You should have: 
- build-tools;31.0.0
- emulator
- patcher;v4
- platform-tools
- platforms;android-31 
- system-images;android-31;google_apis;x86_64

Any module that is missing should be downloaded with the following commands:

- Run: 
  - sdkmanager --install "build-tools;31.0.0"
  - sdkmanager --install "patcher;v4"
  - sdkmanager --install "emulator"
  - sdkmanager --install "platform-tools"
  - sdkmanager --install "platforms;android-31"
  - sdkmanager --install "system-images;android-31;google_apis;x86_64"

#### Create emulator

- Run: avdmanager create avd --name avd_31 --package "system-images;android-31;google_apis;x86_64"

#### Avoid spurious warning

- Run: echo # > c:\qemu.conf

### Confirm success

Your computer should now be able to locate the Android tooling.

Mac:

```bash
which sdkmanager || echo "tooling not found"
```

Windows:

```PowerShell
Get-Command sdkmanager 
```

Seek help if the sdkmanager program isn't found in your path.

### Run emulator

On your local host machine run the Android emulator. After some seconds you should see an emulated Android phone appear.

Mac/Linux:

```bash
./launch_emulator
```

Windows:

```PowerShell
adb start-server
emulator -avd avd_31
adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 1; done;'
```


## Legal and contact

Copyright: © 2021, 2022 By Rectors and Visitors of the University of Virginia.
Authors: Nicholas Phair, Vanessa Amos, Lucia Wocial, Beth Epstein, Kevin Sullivan.
Contact Author (Software): Kevin Sullivan. UVa CS Dept. sullivan@virginia.edu.
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
[14]: https://developer.android.com/studio/#downloads
[15]: https://www.java.com/en/download/manual.jsp
