import "@typespec/http";
import "@typespec/openapi3";
import "../common/models.header.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

model Cancellation {
  cancellationID: string;
  status: CancellationStatus;
  createdOn: utcDateTime;
}

enum CancellationStatus {
  pending,
  completed,
  failed,
}

@doc("Successfully initiated a cancellation but an error occurred while waiting for a synchronous response.")
model CreatedCancellationAsyncResponse {
  ...CommonResponseHeaders;
  @statusCode statusCode: HttpStatusAccepted;
  @body body: Cancellation;
}
