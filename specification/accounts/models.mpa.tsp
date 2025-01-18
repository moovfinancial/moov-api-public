import "@typespec/http";
import "../common/models.response.tsp";

using TypeSpec.Http;

namespace MoovAPI;

model PDFResponse {
  @statusCode statusCode: HttpStatusOK;
  @header contentType: "application/pdf";
  @body body: bytes;
}
