import "@typespec/http";

using TypeSpec.Http;

namespace MoovAPI;

@doc("Successfully able to hit the ping endpoint.")
model SuccessfulPingResponse {
  @statusCode statusCode: HttpStatusOK;
}
