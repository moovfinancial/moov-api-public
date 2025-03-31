import "@typespec/http";
import "@typespec/openapi3";
import "@typespec/versioning";
import "../common/examples.id.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace MoovAPI;

const exampleTerminalConfiguration = #{ configuration: "Zm9vYmFyCg==" };

@doc("Describes a terminal configuration.")
@example(exampleTerminalConfiguration)
model TerminalConfiguration {
  configuration: string;
}
