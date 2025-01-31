import "@typespec/http";
import "../common/models.header.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;

namespace MoovAPI;

model PDFResponse {
  ...CommonResponseHeaders;
  @statusCode statusCode: HttpStatusOK;
  @header contentType: "application/pdf";
  @body body: bytes;
}
