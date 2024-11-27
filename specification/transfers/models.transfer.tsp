import "@typespec/http";
import "@typespec/openapi3";
import "@typespec/versioning";
import "./models.ach.tsp";
import "./models.amount.tsp";
import "./models.card.tsp";
import "./models.dispute.tsp";
import "./models.refund.tsp";
import "./models.rtp.tsp";
import "../bankaccounts/models.bankaccount.tsp";
import "../common/models.parameter.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

@doc("Details of a Transfer.")
model Transfer {
  @format("uuid")
  transferID: string;

  createdOn: utcDateTime;
  source?: TransferSource;
  destination?: TransferDestination;
  completedOn?: utcDateTime;
  status: TransferStatus;
  failureReason?: TransferFailureReason;
  amount: Amount;

  @doc("An optional description of the transfer for your own internal use.")
  @example("Pay Instructor for May 15 Class")
  @maxLength(128)
  description?: string;

  metadata?: Record<string>;
  facilitatorFee?: TransferFacilitatorFee;

  @doc("Fees charged to your platform account for transfers.")
  moovFee?: int64;

  @doc("Same as `moovFee`, but a decimal-formatted numerical string that represents up to 9 decimal place precision.")
  moovFeeDecimal?: int64;

  moovFeeDetails?: MoovFeeDetails;
  groupID?: string;
  refundedAmount?: Amount;
  refunds?: CardTransferRefund[];
  disputedAmount?: Amount;
  disputes?: CardTransferDispute[];
  sweepID?: string;
  scheduleID?: string;
  occurrenceID?: string;
}

model AsyncTransfer {
  @format("uuid")
  transferID: string;

  createdOn: utcDateTime;
}

model TransferSource {
  paymentMethodID: string;
  paymentMethodType: string;
  account: TransferAccount;
  bankAccount?: BankAccount;
  wallet?: unknown; // paymentmethods.WalletResponse
  card?: unknown; // cards.Card
  applePay?: unknown; // paymentmethods.ApplePayResponse
  cardDetails?: CardTransactionDetails;
  achDetails?: AchTransactionDetails;
}

model TransferAccount {
  accountID: string;
  email: string;
  displayName: string;
}

model TransferDestination {
  paymentMethodID: string;
  paymentMethodType: string;
  account: TransferAccount;
  bankAccount?: BankAccount;
  wallet?: unknown; // paymentmethods.WalletResponse
  card?: unknown; // cards.Card
  achDetails?: AchTransactionDetails;
  applePay?: unknown; // paymentmethods.ApplePayResponse
  cardDetails?: CardTransactionDetails;
  rtpDetails?: RtpTransactionDetails;
}

model CreateTransfer {
  source: CreateTransferSource;
  destination: CreateTransferDestination;
  amount: Amount;
  facilitatorFee?: TransferFacilitatorFee;

  @doc("An optional description of the transfer for your own internal use.")
  @example("Pay Instructor for May 15 Class")
  @maxLength(256)
  description?: string;

  @doc("Free-form key-value pair list.")
  metadata?: Record<string>;
}

@doc("A transfer was successfully created but an error occurred while generating the synchronous response. The asynchronous response object will be returned.")
model AsyncCreateTransferResponse {
  @statusCode statusCode: "201";
  @body body: AsyncTransfer;
}

@doc("A transfer was successfully created but a timeout occurred while waiting for a synchronous response. Rail-specific details may be missing from the response object.")
model CreateTransferTimeoutResponse {
  @statusCode statusCode: "202";
  @body body: Transfer;
}

@doc("Attempted to create a transfer using a duplicate X-Idempotency-Key header.")
@error
model DuplicateTransferResponse {
  @statusCode statusCode: "409";
  @body body: Transfer;
}

// TODO: fix backend validation logic so the validation error matches the shape
// of the CreateTransfer model, then come back and update this spec.
model TransferValidationError {
  Transfer?: string;
  amount?: string;
  source?: string;
  sourcePaymentMethodID?: string;
  destinationPaymentMethodID?: string;
  description?: string;
  `FacilitatorFee.TotalDecimal`?: string;
  `FacilitatorFee.MarkupDecimal`?: string;
  metadata?: string;

  @doc("Used for generic errors when invalid request data isn't attributed to a single request field.")
  error?: string;
}

@doc("Where funds for a transfer originate. For the source, you must include either a `paymentMethodID` or a `transferID`.")
model CreateTransferSource {
  @doc("""
    A `transferID` is used to create a [transfer group](https://docs.moov.io/guides/money-movement/transfer-groups/), 
    associating the new transfer with a parent transfer.
    """)
  @format("uuid")
  transferID?: string;

  @format("uuid")
  paymentMethodID?: string;

  cardDetails?: CreateTransferSourceCard;
  achDetails?: CreateTransferSourceACH;
}

@doc("The final stage of a transfer and the ultimate recipient of the funds.")
model CreateTransferDestination {
  paymentMethodID: string;
  cardDetails?: CreateTransferDestinationCard;
  achDetails?: CreateTransferDestinationACH;
}

model PatchTransfer {
  metadata?: Record<string>;
}

@doc("Total or markup fee.")
model TransferFacilitatorFee {
  @doc("Total facilitator fee in cents. Only either `total` or `totalDecimal` can be set.")
  total?: int64;

  @doc("""
    Same as `total`, but a decimal-formatted numerical string that represents up to 9 decimal place precision. 
    
    Only either `total` or `totalDecimal` can be set. Set this field if you expect the fee to be in fractions of a cent.
    """)
  @example("12.987654321")
  @pattern("^\\d+\\.\\d{1,9}$")
  totalDecimal?: string;

  @doc("Markup facilitator fee in cents. Only either `markup` or `markupDecimal` can be set.")
  markup?: int64;

  @doc("""
    Same as `markup`, but a decimal-formatted numerical string that represents up to 9 decimal place precision. 
    Only either `markup` or `markupDecimal` can be set. Set this field if you expect the fee to be in fractions of a cent.
    """)
  @example("0.987654321")
  @pattern("^\\d+\\.\\d{1,9}$")
  markupDecimal?: string;
}

@doc("Processing and pass-through costs that add up to the moovFee.")
model MoovFeeDetails {
  @doc("Card scheme fees accrued during authorization and settlement. String type represents dollars with up to 9 decimal place precision.")
  cardScheme?: string;

  @doc("Network interchange fee for Visa, Mastercard, or Discover. String type represents dollars with up to 9 decimal place precision.")
  interchange?: string;

  @doc("Network discount fee for American Express. String type represents dollars with up to 9 decimal place precision.")
  discount?: string;

  @doc("Moov processing fee. String type represents dollars with up to 9 decimal place precision.")
  moovProcessing: string;
}

model TransferListFilters {
  @doc("Optional, comma-separated account IDs by which the response is filtered based on whether the account ID is the source or destination.")
  @example(#[
    "9506dbf6-4208-44c3-ad8a-e4431660e1f2",
    "3f9969cf-a1f3-4d83-8ddc-229a506651cf",
    "9fdb70f8-79f5-4016-853e-34c40c3b09b0"
  ])
  @query
  accountIDs?: string[];

  @doc("Optional parameter for filtering transfers by status.")
  @query
  status?: TransferStatus;

  @doc("Optional date-time which inclusively filters all transfers created after this date-time.")
  @example(utcDateTime.fromISO("2009-11-10T23:00:00Z"))
  @query
  startDateTime?: utcDateTime;

  @doc("Optional date-time which exclusively filters all transfers created before this date-time.")
  @example(utcDateTime.fromISO("2009-11-13T01:00:00Z"))
  @query
  endDateTime?: utcDateTime;

  @doc("Optional ID to filter for transfers in the same group.")
  @format("uuid")
  @example("683660e3-218c-4f5a-b193-930bd6d2f98e")
  @query
  groupID?: string;

  @doc("Optional parameter to only return refunded transfers.")
  @query
  refunded?: boolean;

  @doc("Optional parameter to only return disputed transfers.")
  @query
  disputed?: boolean;

  @query skip?: Skip;
  @query count?: Count;
}

@doc("Status of a transfer.")
enum TransferStatus {
  Created: "created",
  Pending: "pending",
  Completed: "completed",
  Failed: "failed",
  Reversed: "reversed",
  Queued: "queued",
  Canceled: "canceled",
}

@doc("Reason for a transfer's failure.")
enum TransferFailureReason {
  SourcePaymentError: "source-payment-error",
  DestinationPaymentError: "destination-payment-error",
  WalletInsufficientFunds: "wallet-insufficient-funds",
  RejectedHighRisk: "rejected-high-risk",
  ProcessingError: "processing-error",
}

enum TransferWaitFor {
  RailResponse: "rail-response",
}
