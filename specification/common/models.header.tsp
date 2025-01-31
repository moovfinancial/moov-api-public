import "@typespec/http";
import "../models.version.tsp";

using TypeSpec.Http;

namespace MoovAPI;

model CommonRequestHeaders {
  @doc("Specify an API version.")
  @example(Versions.preVersioned)
  @header
  xMoovVersion?: Versions;
}

@doc("A unique identifier used to trace requests.")
@format("uuid")
scalar XRequestID extends string;

model CommonResponseHeaders {
  @header
  xRequestID: XRequestID;
}
