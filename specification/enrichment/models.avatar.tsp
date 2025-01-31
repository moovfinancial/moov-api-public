import "@typespec/http";
import "../common/models.header.tsp";

using TypeSpec.Http;

namespace MoovAPI;

model EnrichedAvatar {
  ...CommonResponseHeaders;
  @statusCode statusCode: HttpStatusOK;
  @header contentType: "image/png" | "image/jpeg";

  @doc("A png or jpg image associated with an account.")
  @body
  body: bytes;
}
