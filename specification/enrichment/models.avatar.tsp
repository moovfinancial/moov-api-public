import "@typespec/http";
using TypeSpec.Http;

namespace MoovAPI;

model EnrichedAvatar {
  @statusCode statusCode: 200;
  @header contentType: "image/png" | "image/jpeg";

  @doc("A png or jpg image associated with an account.")
  @body
  body: bytes;
}
