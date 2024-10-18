# moov-api
Specifications for Moov's public API endpoints.

## Setup

1. Install the [EditorConfig](https://marketplace.visualstudio.com/items?itemName=EditorConfig.EditorConfig) extension
2. Install NodeJs > 20
3. Run `npm i`

## Versioning

Versions are defined in `./specification/models.version.tsp`. New versions should be added to the enum in chronological order
to ensure the resulting OpenAPI files are correct. Each API version will get a new output directory in `./openapi`, while the
top level `openapi.yaml` file represents the "pre-versioned" API.

Once a version has been defined in the `Versions` enum, decorators like `@added`, `@removed`, and `@madeOptional` can be used
with the appropriate version on models and operations.

```typespec
import "@typespec/versioning";
import "../models.version.tsp"

using TypeSpec.Versioning;

namespace MoovAPI.Thing;

model Thing {
  thingID: string;

  // This field will not show up in ./openapi/openapi.yaml, but will appear in ./openapi/v20241007/openapi.yaml and
  // anything newer, including "latest".
  //
  // NOTE: VSCode may underline this decorator as though it contained an error, but it is valid
  // and will compile correctly. The IDE isn't great at resolving version enums across namespaces.
  @added(MoovAPI.Versions.v20240710)
  newField: string;

  // This will be flagged with `deprecated: true`
  #deprecated "Deprecation message..."
  gonnaBeRemovedSomeday: string;

  // This field will appear in OpenAPI files up to the version preceeding v20241007.
  @removed(MoovAPI.Versions.v20241007)
  oldField: string;
}
```

Refer to TypeSpec's documentation for more information:
* [Versioning Guide](https://typespec.io/docs/libraries/versioning/guide)
* [Decorators](https://typespec.io/docs/libraries/versioning/reference/decorators)

## Development

APIs are defined using [TypeSpec](https://typespec.io/docs), which is then compiled to OpenAPI. Each domain (Accounts,
Capabilities, Cards, etc.) should have its own subdirectory. The subdirectory should have main, models, and routes files.
Each subdirectory must be imported in the top-level `specification/main.tsp` file.

At a glance, the process to add new APIs to this project looks like:

1. Create a subdirectory for the relavent domain under `specification/`, if one doesn't already exist (e.g. `specification/cards`)
1. Define models in `models.{name}.tsp`
1. Define routes in `routes.{name}.tsp`, and import the models file
   * Operations should be defined as an interface, to be used in the top level `main.tsp`
1. Create the subdirectory's `main.tsp` if needed, and import the routes file
1. Make sure the subdirectory is imported in `specification/main.tsp`
   * If this step is missed, the compiler won't find anything in the new subdirectory

The following sections describe each component in more detail.

## Namespaces

This project is structured to aggregate all of the individual APIs into a single OpenAPI file per version. To
accomplish this, namespaces must be nested under the top level `MoovAPI` namespace. Nesting can be done using
block (`{}`), or blockless (file level) notation:

### Block example

```typespec
namespace TopLevel {
  namespace Nested {
    // models, routes, etc.
  }
}
```

OR

```typespec
namespace TopLevel.Nested {
  // models, routes, etc.
}
```

### Blockless example

The following is equivalent to the block example above:

```typespec
namespace TopLevel.Nested;

// models, routes, etc.
```

Refer to TypeSpec's documentation for more information:
* [Namespaces](https://typespec.io/docs/language-basics/namespaces)

### Main

The top-level `specification/main.tsp` imports all the subdirectories and serves as the entrypoint for the
TypeSpec compiler. It is used to aggregate the routes from all other namespaces to ensure the compiled output
is a single OpenAPI file per API version.

Each subdirectory that contains routes must have its own `main.tsp` that defines the namespace and attaches
the `MoovAPI.Versions` enum:

```typespec
import "@typespec/versioning";
import "../models.version.tsp";

// import routes
import "./routes.{apiname}.tsp";

using TypeSpec.Versioning;

// Define the namespace
@versioned(MoovAPI.Versions)
namespace MoovAPI.Accounts;
```

### Models

API models should be defined in a `models.{name}.tsp` file. Related models should be grouped together in a
single file, named appropriately for its contents. The file level namespace should be the same as the
subdirectory's `main.tsp` file. Be sure to use the appropriate versioning decorators to ensure the generated
OpenAPI specifications accurately reflect the backend implementations.

#### Shared models

Because of the way TypeSpec's versioning works, you cannot import a model from a versioned namespace into
another versioned namespace. This means shared types must either go in `./common`, or in the appropriate
domain's subdirectory under a different namespace. For shared models in a domain-specific subdirectory
(consider the `CapabilityID` enum in `./capabilities`), define a separate namespace like `CommonCapabilities`
with no versioning.

### Routes

Routes should be defined in a `routes.{name}.tsp` file with the same namespace as the models, and import
the necessary model files.

#### Authentication

The Moov OAuth2 flow is defined in `./auth/models.auth.tsp`, and should be applied to each route with the
`@useAuth` decorator. Inside the decorator, each available auth method must be unioned (`|`) together to
indicate an OR relationship instead of AND. The OAuth2 flow is defined as a template, allowing scope(s)
to be passed as the template parameter.

For example:

```typespec
import "@typespec/http";
import "./models.account.tsp";

using TypeSpec.Http;

@tag("Accounts")
@route("/accounts")
namespace MoovAPI.Accounts {
  @doc("Endpoint description here")
  @get
  // Can use either OAuth2 OR API key
  @useAuth(Auth.OAuth2<["/accounts.read"]> | BasicAuth)
  op listAccounts(): Common.List<Accounts.Account>;
}
```

All routes are then aggregated into the top level `main.tsp` by importing the subdirectory's `main.tsp`:

```typespec
import "@typespec/http";
import "@typespec/versioning";

// import each subdirectory's main
import "./auth";
import "./accounts";
import "./capabilities";
```
