import "@typespec/http";
import "../common/models.header.tsp";

using TypeSpec.Http;

namespace MoovAPI;

@doc("Successfully able to hit the ping endpoint.")
model SuccessfulPingResponse {
  ...CommonResponseHeaders;
  @statusCode statusCode: HttpStatusOK;
}
