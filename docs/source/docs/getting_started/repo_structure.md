# Repository
The source code for this project can be found on [github][1].

## Directory Structure
Below you see the top-level layout of the project.
```
.
├── COPYRIGHT
├── README.md
├── api
├── bin
├── docs
├── infrastructure
├── moraldistress
└── resources
```

Let us describe each directory.

### api
The api directory contains api clients that can be used to communicate
with the backend services. It is auto-generated code produced from an [openAPI
specification][2]. Currently we have generated clients for the Dart and Java programming languages.

### bin
The bin directory contains various helper scripts for this project. Currently,
there are the `install_emulator` and `launch_emulator` scripts. These have only
been tested on _Unix-like_ systems.

### doc
The doc directory holds the project documentation. It is written in Markdown and
can be found in the `source/docs` directory. HTML is generated from this
Markdown and published as a static site to S3. The generation step is handled
by [Sphinx][4] and is run on commits via a [github action][3].

You can reach the documentation site [here][5].


### infrastructure
Infrastructure is largely made up of our AWS [IaC][6] files. Particularly
we have captured [CloudFormation templates][7] in the `templates` directory.

You could deploy these templates using the CloudFormation cli, however, this
interface is cumbersome and requires managing many shell scripts to reliably
capture the deployment parameters. To overcome this, we use a tool called
[sceptre][8]. Sceptre allows you to manage template configuration separate from
the templates themselves. From this, we gain easy template reuse and are able
to  capture deployment parameters neatly in declarative yaml files. These files
are located in the `config` directory.

Additionally, we use a tool called [SAM][9] to write more efficient cloudformation templates. SAM templates abstract away many of the cloudformation details required for writing serverless functions and apis. At the time of creating, Sceptre did not integrate with SAM. However, it has since added that capability. We have assumed it as tech debt to migrate over to Sceptre for SAM.

Finally, since SAM manages serverless functions, the code for these functions is also captured in the `sam` directory. Namely, in the `MoralPainFunctions`.

### moraldistress
The moraldistress directory is mobile application directory. It is simply a
[Flutter project][10].

### resources
The resources folder contains json definitions for application configurations.
These files are hosted in S3.

__note:__ these files should eventually be managed by cloudformation and moved
to the infrastructure directory.


[1]: https://github.com/kevinsullivan/moralpain_dev
[2]: https://github.com/kevinsullivan/moralpain_dev/blob/main/infrastructure/sam/api.yaml
[3]: https://github.com/kevinsullivan/moralpain_dev/blob/main/.github/workflows/docs.yaml
[4]: https://www.sphinx-doc.org/en/master/
[5]: https://moralpain-site.s3.us-east-1.amazonaws.com/docs/index.html
[6]: https://en.wikipedia.org/wiki/Infrastructure_as_code
[7]: https://aws.amazon.com/cloudformation/
[8]: https://github.com/Sceptre/sceptre
[9]: https://aws.amazon.com/serverless/sam/
[10]: https://flutter.dev/
