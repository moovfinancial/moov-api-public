import "@typespec/http";
import "@typespec/openapi3";
import "./models.refund.tsp";
import "../common/models.header.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

model CreateReversal {
  @doc("Amount to reverse in cents. Partial amounts will automatically trigger a refund instead of a cancellation.")
  @example(1000)
  amount: int64;
}

model ReversalValidationError {
  amount?: string;
}

@doc("Contains either a cancellation or refund, depending on the method used to reverse the transfer.")
@oneOf
union Reversal {
  ReversedWithCancellation,
  ReversedWithRefund,
}

model ReversedWithCancellation {
  cancellation: Cancellation;
}

model ReversedWithRefund {
  refund: CardAcquiringRefund;
}

model Cancellation {
  status: CancellationStatus;
  createdOn: utcDateTime;
}

@doc("Successfully initiated a reversal.")
model CreatedReversalResponse {
  ...CommonResponseHeaders;
  @statusCode statusCode: HttpStatusOK;
  @body body: Reversal;
}

@doc("Successfully initiated a reversal but an error occurred while waiting for a synchronous response.")
model CreatedReversalAsyncResponse {
  ...CommonResponseHeaders;
  @statusCode statusCode: HttpStatusAccepted;
  @body body: Reversal;
}

enum CancellationStatus {
  pending,
  completed,
}
