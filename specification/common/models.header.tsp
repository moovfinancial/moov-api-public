import "@typespec/http";
import "../models.version.tsp";

using TypeSpec.Http;

namespace MoovAPI;

model CommonHeaders {
  @doc("Specify an API version.")
  @example(Versions.preVersioned)
  @header
  xMoovVersion?: Versions;
}
