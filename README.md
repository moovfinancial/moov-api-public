# moov-api
Specifications for Moov's public API endpoints.

## Setup

1. Install the [EditorConfig](https://marketplace.visualstudio.com/items?itemName=EditorConfig.EditorConfig) extension
2. Install Node `22.10.0`
  - The recommended way is to install `mise` ([link](https://github.com/jdx/mise?tab=readme-ov-file#quickstart)) or `nvm` ([link](https://github.com/nvm-sh/nvm?tab=readme-ov-file#installing-and-updating)) and just rely on the `.nvmrc` file to manage your Node version.
  - Once either `nvm` or `mise` are installed, run `nvm install` or `mise i` in the root of this project to install the Node version specified in the `.nvmrc` file.
  - This node project also has scripts that run automatically after you pull from main that will check your `node` version, try to update it with the version at `.nvmrc` automatically through `nvm` and `mise`, so ideally you wouldn't need to worry at all about maintaining your `node` up to date once youset it up through `nvm` or `mise`
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

namespace MoovAPI;

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

### Namespacing

All files in this project should use `namespace MoovAPI`.

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

namespace MoovAPI {
  @doc("Endpoint description here")
  @tag("Accounts")
  @route("/accounts")
  @get
  // Can use either OAuth2 OR API key
  @useAuth(BasicAuth | OAuth2<["/accounts.read"]>)
  op listAccounts(): ListResponses<Accounts.Account>;
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

## Project conventions

This project aims to follow TypeSpec's official [style guide](https://typespec.io/docs/handbook/style-guide/).

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

### Decorators and allOf

Using decorators, such as a doc comment, on a property whose type is a custom model will result in OpenAPI 
specs with unnecessary `allOf` keywords. While `allOf` is _usually_ safe, it cluters the spec and can cause 
issues in some code generators (e.g. empty structs). When adding to this project, prefer definitions that 
avoid the `allOf` keyword unless strictly necessary.

When defining models with custom types, all TypeSpec.Http decorators should be on the custom type itself - 
not the property using that type.

The following model definition will result in an unncessary `allOf`:

```typespec
model Thing {
  @doc("Extra description that didn't actually need to be here")
  property: NestedThing;
}

@doc("This is a nested thing")
model NestedThing {
  anotherProperty?: string;
}
```

```yaml
Thing:
  type: object
  required:
    - property
  properties:
    property:
      allOf:
        - $ref: '#/components/schemas/NestedThing'
      description: Extra description that didn't actually need to be here
```

Instead, allow TypeSpec/OpenAPI to use the existing description and other decorators:

```typespec
model Thing {
  // this will use the decorators from NestedThing in generated code and documentation
  property: NestedThing;
}

@doc("This is a nested thing")
model NestedThing {
  anotherProperty?: string;
}
```
