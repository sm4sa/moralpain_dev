 # Configuring Typedb

## Overview

You can create a working example of a TypeDB database to play with by changing into the typedb directory and running the following shell command.

## How to

```sh
typedb console --command="transaction phone_calls schema write" --command="source ./phone_calls.tql" --command="commit"
```
