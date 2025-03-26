# moov-api
Specifications for Moov's public API endpoints.

If you're new to Moov API, please familiarize yourself with the [Project conventions](#project-conventions) before contributing.
For more information on the TypeSpec language, see the [TypeSpec documentation](https://typespec.io/docs).

## Setup

TypeSpec development is best done in Visual Studio Code, as it's currently the only editor with a plugin that supports the language.

To set up your development environment:

1. Install the [EditorConfig](https://marketplace.visualstudio.com/items?itemName=EditorConfig.EditorConfig) extension
2. Install the [TSP extension for VSCode](https://marketplace.visualstudio.com/items?itemName=typespec.typespec-vscode)
3. Install Node `22.10.0`
  - The recommended way is to install `mise` ([link](https://github.com/jdx/mise?tab=readme-ov-file#quickstart)) or `nvm` ([link](https://github.com/nvm-sh/nvm?tab=readme-ov-file#installing-and-updating)) and just rely on the `.nvmrc` file to manage your Node version.
  - Once either `nvm` or `mise` are installed, run `nvm install` or `mise i` in the root of this project to install the Node version specified in the `.nvmrc` file.
  - This node project also has scripts that run automatically after you pull from main that will check your `node` version, try to update it with the version at `.nvmrc` automatically through `nvm` and `mise`, so ideally you wouldn't need to worry at all about maintaining your `node` up to date once youset it up through `nvm` or `mise`
4. Run `npm i`

### Alternative setup

If you prefer not to install Node on your machine, you can still format and compile your TypeSpec changes with `make docker`, instead of `make`.

## Development

APIs are defined using [TypeSpec](https://typespec.io/docs), which is then compiled to OpenAPI. Each domain (Accounts,
Capabilities, Cards, etc.) should have its own subdirectory. The subdirectory should have main, models, and routes files.
Each subdirectory must be imported in the top-level `specification/main.tsp` file.

The workflow for modifying existing TypeSpec files is fairly straightforward:

1. Make changes to the relevant `*.tsp` file(s)
2. Run `make` (or `make docker`) to format the project and compile the changes

If you're adding a new domain, follow these steps:

1. Create a subdirectory for the relavent domain under `specification/`, if one doesn't already exist (e.g. `specification/cards`)
2. Define models in `models.{name}.tsp`
3. Define routes in `routes.{name}.tsp`, and import the models file
4. Create the subdirectory's `main.tsp`, if needed, and import the routes file
5. Make sure the subdirectory is imported in the top-level `specification/main.tsp` file
   * If this step is missed, the compiler won't include the new domain in the generated OpenAPI file

The following sections describe each component in more detail.

### Namespacing

All files in this project should use a file-level `MoovAPI` namespace (e.g. `namespace MoovAPI;`).

### Main

The top-level `specification/main.tsp` imports all the subdirectories and serves as the entrypoint for the
TypeSpec compiler. It is used to aggregate the routes from all other domains to ensure the compiled output
is a single OpenAPI file per API version.

Each domain's `main.tsp` simply needs to import any `routes.{name}.tsp` files:

```typespec
import "./routes.bankaccount.tsp";
import "./routes.microdeposit.tsp";
import "./routes.verification.tsp";
```

### Models

API models should be defined in a `models.{name}.tsp` file. Related models should be grouped together in a
single file, named appropriately for its contents. Be sure to use the appropriate versioning decorators to 
ensure the generated OpenAPI specifications accurately reflect the backend implementations.

### Routes

Routes should be defined in a `routes.{name}.tsp` file and import the necessary model files.

All routes are then aggregated into the top level `main.tsp` by importing the subdirectory's `main.tsp`:

```typespec
import "@typespec/http";
import "@typespec/versioning";

// import each subdirectory's main
import "./auth";
import "./accounts";
import "./capabilities";
```

#### Authentication

This project uses a global `BasicAuth` scheme defined at the namespace level in `main.tsp`. All Moov endpoints
also support OAuth2, but OpenAPI and code generators don't support parameterized OAuth2 scopes. Instead of 
defining our OAauth2 flow as an OpenAPI `securityScheme`, we document the required scope in each operation's 
description. This allows us to maintain complete documentation while avoiding problems with code generation.

## Versioning

Versions are defined in `./specification/models.version.tsp`. New versions should be added to the enum in chronological order
to ensure the resulting OpenAPI files are correct. Each API version will get a new output directory in `./openapi`.

Once a version has been defined in the `Versions` enum, decorators like `@added`, `@removed`, and `@madeOptional` can be used
with the appropriate version on models and operations.

```typespec
import "@typespec/versioning";
import "../models.version.tsp"

using TypeSpec.Versioning;

@versioned(MoovAPI.Versions) // Not strictly required, but helps with IDE intellisense
namespace MoovAPI;

model Thing {
  thingID: string;

  // This field will not show up in ./openapi/openapi.yaml, but will appear in ./openapi/v20241007/openapi.yaml and
  // anything newer, including "latest".
  //
  // NOTE: VSCode may underline this decorator as though it contained an error, but it is valid
  // and will compile correctly. The IDE isn't great at resolving version enums across namespaces.
  @added(MoovAPI.Versions.v2025q1)
  newField: string;

  // This will be flagged with `deprecated: true`
  #deprecated "Deprecation message..."
  gonnaBeRemovedSomeday: string;

  // This field will appear in OpenAPI files up to the version preceeding v20241007.
  @removed(MoovAPI.Versions.v2025q2)
  oldField: string;
}
```

Refer to TypeSpec's documentation for more information:
* [Versioning Guide](https://typespec.io/docs/libraries/versioning/guide)
* [Decorators](https://typespec.io/docs/libraries/versioning/reference/decorators)

## Project conventions

This project follows TypeSpec's official [style guide](https://typespec.io/docs/handbook/style-guide/).

Additional conventions for this project are detailed below.

### Naming

* Acronyms and initialisms in names should have a consistent case
  * For example prefer `url` or `URL`, over `Url`

### Enums

* Enum members only need explicit value assignments when the name and value differ
  * `enumMember: "enum-member"` needs an explicit value because `kabob-case` values are not valid TypeSpec identifiers

### Optional

An optional field is any model property, parameter, header, etc. that can be omitted from a request or response. 
Optional fields must be marked with `?`. Field requirement/optionality MUST be correctly defined for both requests
and responses. For responses, any property not marked optional is considered guaranteed to be present.

### Nullable

A nullable field is any model property that can be present in a request or response payload with a value of `null`.
In certain contexts, it is valid to mark a field as both optional _and_ nullable. PATCH requests, where it's permissible
to send an explicit `null` to unset a field, are one valid use-case. 

To define a property as nullable, its type should be unioned with `null`:

```typespec
model Thing {
  property: AnotherThing | null;
}
```
