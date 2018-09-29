# netcore-compose-test
A .NET Core Docker+Docker-compose test

### Running the projects

To boot up containers meant for local development and debugging, run `./compose.sh dev up -d`. This will start up
a PostgreSQL database, the IAM container and the GiraffeWeb container. From there, you can issue commands to the
containers as if they were local development environments, e.g., `./compose.sh dev exec iam dotnet build` to run
`dotnet build` inside the IAM container.

To build and run published DLLs meant for release, run `./compose.sh prod build && ./compose.sh prod up -d`. You should
now be able to reach the IdentityServer at `localhost:5050` and a "Hello World" example of the GiraffeWeb server by going
to `localhost:5000/api/v1/patient`.

### Debugging in Visual Studio Code

TODO

### Projects
There are 2 .NET Core projects in this repository:
- src/IAM -- A C# QuickStart example of IdentityServer4
- src/GiraffeWeb -- A F# Giraffe web application

The IdentityServer listens on port `5050`, while _GiraffeWeb_ listens on port `5000`.

### Docker-compose
There are 3 docker-compose files:
- docker-compose.yml defines common settings for both development and production environment
- docker-compose.override.yml defines debug-specific settings meant for local development
- docker-compose.prod.yml defines settings meant to run the containers

### Dockerfile(s)
The Dockerfile for each project defines a multi-step build meant to facilitate both local development and deployment into production.
The `dev` step copies sourcefiles over and pulls dependencies, while the `final` step instead copies over the DLL and its dependencies
so that can be run using the `dotnet` command.
