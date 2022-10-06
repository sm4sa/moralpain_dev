# Development Environment

The development environment for moraldistress is made up of a docker
container, which hosts all of the required dependencies, and 
an IDE which interfaces with the container. The IDE runs on 
your local machine, not the docker. This setup is realized
with [VSCode and its remote containers extension][1].


```{graphviz} assets/devenv.dot
---
caption: VScode remote container environment.
---

```

If our environment was a simple Python or Java app, this architecture would fit
perfectly. However, our project supports mobile and web interfaces. This means
it is not enough to be able to run our project in the VSCode IDE, rather,
we must experience it on an emulated mobile device or a Chrome-based browser.  

Now, running an emulator inside of a docker is extremely difficult (perhaps not possible?)
due to the nested virtualization. Running a browser inside of an emulator can be slow.
And in both cases you would need to expose the interface to outside of the container
for a developer to interact with. To avoid these troubles, we do not run emulators
or browsers inside of the container. Instead, we run them locally, and connect
the processes running inside the container to the interface running on the local machine.  

This leaves us with two interfaces running locally. The VSCode client, that allows
us to edit the source code and build the project inside the container. And the emulated 
device or browser, to view and interact with the running project.  

With this in mind, let us update the diagram.


```{graphviz} assets/devenv_w_project_ui.dot
---
caption: VScode remote container environment connected to possible project interfaces.
---

```

Note that we can just as well draw arrows from the project interfaces to the
debugger - in this setup we totally maintain that capability. They are omitted
here to keep the diagram simple.

[1]: https://code.visualstudio.com/docs/remote/containers
