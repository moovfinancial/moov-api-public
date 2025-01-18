import "@typespec/http";
import "@typespec/openapi3";
import "../money/models.amount.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

@doc("""
  Specifies a partial amount to refund. 
  
  This request body is optional, an empty body will issue a refund for the full amount of the original transfer.
  """)
model CreateRefund {
  @doc("Amount to refund in cents. If null, the original transfer's full amount will be refunded.")
  @example(1000)
  amount?: int64;
}

@doc("A refund was successfully created but an error occurred while waiting for a synchronous response.")
model CreateRefundTimeoutResponse {
  @statusCode statusCode: HttpStatusAccepted;
  @body body: CardAcquiringRefund;
}

@oneOf
union CreateRefundResponse {
  CardAcquiringRefund,
  AsyncCreatedRefund,
}

@doc("Asynchronous refund response")
model AsyncCreatedRefund {
  @format("uuid")
  refundID: string;

  createdOn: utcDateTime;
  amount: Amount;
}

@doc("Details of a card refund.")
model CardAcquiringRefund {
  @doc("Identifier for the refund.")
  @format("uuid")
  refundID: string;

  createdOn: utcDateTime;
  updatedOn: utcDateTime;
  status: RefundStatus;
  amount: Amount;
  cardDetails?: RefundCardDetails;
}

@doc("Attempted to create a refund using a duplicate X-Idempotency-Key header.")
@error
model DuplicateRefundResponse {
  @statusCode statusCode: HttpStatusConflict;
  @body body: CardAcquiringRefund;
}

model RefundValidationError {
  amount?: string;

  @doc("Used for generic errors when invalid request data isn't attributed to a single request field.")
  error?: string;
}

model RefundCardDetails {
  status: RefundCardStatus;
  failureCode?: CardTransactionFailureCode;
  initiatedOn?: utcDateTime;
  confirmedOn?: utcDateTime;
  settledOn?: utcDateTime;
  failedOn?: utcDateTime;
  completedOn?: utcDateTime;
}

enum RefundStatus {
  created,
  pending,
  completed,
  failed,
}

enum RefundCardStatus {
  initiated,
  confirmed,
  settled,
  failed,
  completed,
}
