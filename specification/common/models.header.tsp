import "@typespec/http";
import "../models.version.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

@useDependency(MoovAPI.Versions.latest)
namespace Common;

model Headers {
  @doc("Specify an API version.")
  @example(MoovAPI.Versions.preVersioned)
  @header
  xMoovVersion?: MoovAPI.Versions;
}
