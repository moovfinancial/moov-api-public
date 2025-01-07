import "@typespec/http";

using TypeSpec.Http;

namespace MoovAPI;

model PDFResponse {
  @statusCode statusCode: 200;
  @header contentType: "application/pdf";
  @body body: bytes;
}
