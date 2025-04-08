import "@typespec/http";
import "@typespec/openapi3";
import "@typespec/versioning";
import "@typespec/versioning";

import "./examples.transfer.tsp";
import "./models.ach.tsp";
import "./models.cancellation.tsp";
import "./models.card.tsp";
import "./models.dispute.tsp";
import "./models.refund.tsp";
import "./models.rtp.tsp";
import "../models.version.tsp";

import "../bankaccounts/models.bankaccount.tsp";
import "../common/models.header.tsp";
import "../common/models.parameter.tsp";
import "../common/models.response.tsp";
import "../common/models.metadata.tsp";
import "../money/models.amount.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace MoovAPI;

model CreatedTransfer {
  @format("uuid")
  transferID: string;

  createdOn: utcDateTime;
  source?: TransferSource;
  destination?: TransferDestination;
  completedOn?: utcDateTime;
  status?: TransferStatus;
  failureReason?: TransferFailureReason;
  amount?: Amount;

  @doc("An optional description of the transfer that is used on receipts and for your own internal use.")
  @example("Pay Instructor for May 15 Class")
  @maxLength(128)
  description?: string;

  metadata?: Metadata;
  facilitatorFee?: FacilitatorFee;

  @doc("Fees charged to your platform account for transfers.")
  moovFee?: int64;

  @doc("Same as `moovFee`, but a decimal-formatted numerical string that represents up to 9 decimal place precision.")
  moovFeeDecimal?: string;

  moovFeeDetails?: MoovFeeDetails;
  groupID?: string;
  cancellations?: Cancellation[];
  refundedAmount?: Amount;
  refunds?: CardAcquiringRefund[];
  disputedAmount?: Amount;
  disputes?: CardAcquiringDispute[];
  sweepID?: string;
  scheduleID?: string;
  occurrenceID?: string;

  @doc("Optional sales tax amount. `transfer.amount.value` should be inclusive of any sales tax and represents the total amount charged.")
  salesTaxAmount?: Amount;
}

@summary("Sync")
@doc("Details of a Transfer.")
@example(ExamplePendingCardToWalletTransfer)
model Transfer {
  @format("uuid")
  transferID: string;

  createdOn: utcDateTime;
  source: TransferSource;
  destination: TransferDestination;
  completedOn?: utcDateTime;
  status: TransferStatus;
  failureReason?: TransferFailureReason;
  amount: Amount;

  @doc("An optional description of the transfer that is used on receipts and for your own internal use.")
  @example("Pay Instructor for May 15 Class")
  @maxLength(128)
  description?: string;

  metadata?: Metadata;
  facilitatorFee?: FacilitatorFee;

  @doc("Fees charged to your platform account for transfers.")
  moovFee?: int64;

  @doc("Same as `moovFee`, but a decimal-formatted numerical string that represents up to 9 decimal place precision.")
  moovFeeDecimal?: string;

  moovFeeDetails?: MoovFeeDetails;

  @doc("Fees charged to accounts involved in the transfer.")
  moovFees?: MoovFee[];

  groupID?: string;
  cancellations?: Cancellation[];
  refundedAmount?: Amount;
  refunds?: CardAcquiringRefund[];
  disputedAmount?: Amount;
  disputes?: CardAcquiringDispute[];
  sweepID?: string;
  scheduleID?: string;
  occurrenceID?: string;

  @doc("Optional sales tax amount. `transfer.amount.value` should be inclusive of any sales tax and represents the total amount charged.")
  salesTaxAmount?: Amount;
}

@summary("Async")
model AsyncTransfer {
  @format("uuid")
  transferID: string;

  createdOn: utcDateTime;
}

model TransferSource {
  @format("uuid")
  @doc("UUID present only if the transfer is part of a transfer group.")
  transferID?: string;

  paymentMethodID: string;
  paymentMethodType: PaymentMethodType;
  account: TransferAccount;
  bankAccount?: PaymentMethodsBankAccount;
  wallet?: PaymentMethodsWallet;
  card?: PaymentMethodsCard;
  applePay?: ApplePayResponse;

  @added(MoovAPI.Versions.v2025q2)
  terminalCard?: TerminalCard;

  cardDetails?: CardTransactionDetails;
  achDetails?: ACHTransactionDetails;
}

model TransferAccount {
  accountID: string;
  email: string;
  displayName: string;
}

model TransferDestination {
  paymentMethodID: string;
  paymentMethodType: PaymentMethodType;
  account: TransferAccount;
  bankAccount?: PaymentMethodsBankAccount;
  wallet?: PaymentMethodsWallet;
  card?: PaymentMethodsCard;
  achDetails?: ACHTransactionDetails;
  applePay?: ApplePayResponse;
  cardDetails?: CardTransactionDetails;
  rtpDetails?: RTPTransactionDetails;
}

@example(ExampleCreateCardToWalletTransfer)
model CreateTransfer {
  source: CreateTransferSource;
  destination: CreateTransferDestination;
  amount: Amount;
  facilitatorFee?: FacilitatorFee;

  @doc("An optional description of the transfer that is used on receipts and for your own internal use.")
  @example("Pay Instructor for May 15 Class")
  @maxLength(256)
  description?: string;

  metadata?: Metadata;

  @doc("Optional sales tax amount. `transfer.amount.value` should be inclusive of any sales tax and represents the total amount charged.")
  salesTaxAmount?: Amount;
}

@doc("A transfer was successfully created but an error occurred while generating the synchronous response. The asynchronous response object will be returned.")
model CreatedTransferSyncErrorResponse {
  ...CommonResponseHeaders;
  @statusCode statusCode: HttpStatusCreated;
  @body body: AsyncTransfer;
}

@doc("A transfer was successfully created but a timeout occurred while waiting for a synchronous response. Rail-specific details may be missing from the response object.")
model CreateTransferTimeoutResponse {
  ...CommonResponseHeaders;
  @statusCode statusCode: HttpStatusAccepted;
  @body body: Transfer;
}

@doc("Attempted to create a transfer using a duplicate X-Idempotency-Key header.")
@error
model DuplicateTransferResponse {
  ...CommonResponseHeaders;
  @statusCode statusCode: HttpStatusConflict;
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

  paymentToken?: string;
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
  metadata?: Metadata | null;
}

@doc("Total or markup fee.")
model FacilitatorFee {
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

@doc("Moov fee charged to an account involved in a transfer.")
model MoovFee {
  @doc("ID of the account that fees were charged to.")
  accountID: string;

  @doc("Indicates whether the account charged is the source, destination, or partner account.")
  transferParty: TransferParty;

  @doc("The total amount of fees charged to the account.")
  totalAmount: AmountDecimal;

  @doc("List of fee IDs that sum to the totalAmount.")
  feeIDs: string[];
}

@doc("Indicates whether an account was the source or destination of a transfer.")
enum TransferParty {
  source,
  destination,
  partner,
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

  @doc("Optional ID to filter for transfer occurrences belonging to the same schedule.")
  @format("uuid")
  @example("b7aa2ee2-8783-4fc9-9fa6-a4720b30b20d")
  @query
  scheduleID?: string;

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
  created,
  pending,
  completed,
  failed,
  reversed,
  queued,
  canceled,
}

@doc("Reason for a transfer's failure.")
enum TransferFailureReason {
  sourcePaymentError: "source-payment-error",
  destinationPaymentError: "destination-payment-error",
  walletInsufficientFunds: "wallet-insufficient-funds",
  rejectedHighRisk: "rejected-high-risk",
  processingError: "processing-error",
}

enum TransferWaitFor {
  railResponse: "rail-response",
}
