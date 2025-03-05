import "@typespec/http";
import "@typespec/openapi3";
import "@typespec/versioning";
import "../common/models.header.tsp";
import "../common/models.parameter.tsp";
import "../common/models.response.tsp";
import "../common/models.metadata.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

@doc("The type of receipt being requested.")
enum ReceiptKind {
  saleCustomer: "sale.customer.v1",
}

@doc("A receipt request for a specific transfer, schedule, or schedule occurrence.")
model ReceiptRequest {
  @doc("The type of receipt being requested.")
  kind: ReceiptKind;

  @doc("""
    The email address to send the receipt to.
    Either email or emailAccountID must be provided, but not both.
    """)
  email?: Email;

  @doc("""
    The accountID to send the receipt to.
    Either email or emailAccountID must be provided, but not both.
    """)
  @format("uuid")
  emailAccountID?: string;

  @doc("""
    The ID of the transfer associated with this receipt.
    Exactly one of forTransferID, forScheduleID, or forOccurrenceID must be provided.
    """)
  @format("uuid")
  forTransferID?: string;

  @doc("""
    The ID of the schedule associated with this receipt.
    Exactly one of forTransferID, forScheduleID, or forOccurrenceID must be provided.
    """)
  @format("uuid")
  forScheduleID?: string;

  @doc("""
    The ID of the schedule occurrence associated with this receipt.
    Exactly one of forTransferID, forScheduleID, or forOccurrenceID must be provided.
    """)
  @format("uuid")
  forOccurrenceID?: string;
}

model SentReceipt {
  @doc("Unique identifier for the receipt.")
  @format("uuid")
  receiptID: string;

  @doc("The idempotency key used when creating the receipt.")
  @format("uuid")
  idempotencyKey: string;

  @doc("When the receipt was sent.")
  @example(utcDateTime.fromISO("2009-11-10T23:00:00Z"))
  sentOn: utcDateTime;
}

model ReceiptResponse {
  @doc("Unique identifier for the receipt request.")
  @format("uuid")
  receiptID: string;

  @doc("AccountID for which the receipt request was created.")
  @format("uuid")
  createdBy: string;

  @doc("The date and time the receipt was disabled.")
  @example(utcDateTime.fromISO("2009-11-10T23:00:00Z"))
  disabledOn?: utcDateTime;

  @doc("The type of receipt.")
  kind: ReceiptKind;

  @doc("""
    The email address the receipt is sent to.
    Either email or emailAccountID will be in the response, but not both.
    """)
  email?: Email;

  @doc("""
    The accountID the receipt is sent to.
    Either email or emailAccountID will be in the response, but not both.
    """)
  @format("uuid")
  emailAccountID?: string;

  @doc("""
    The ID of the transfer associated with this receipt.
    Exactly one of forTransferID, forScheduleID, or forOccurrenceID must be provided.
    """)
  @format("uuid")
  forTransferID?: string;

  @doc("""
    The ID of the schedule associated with this receipt.
    Exactly one of forTransferID, forScheduleID, or forOccurrenceID must be provided.
    """)
  @format("uuid")
  forScheduleID?: string;

  @doc("""
    The ID of the schedule occurrence associated with this receipt.
    Exactly one of forTransferID, forScheduleID, or forOccurrenceID must be provided.
    """)
  @format("uuid")
  forOccurrenceID?: string;

  @doc("The list of receipts that have been sent.")
  sentFor: SentReceipt[];
}

@error
model ReceiptValidationError {
  kind?: string;
  email?: string;
  emailAccountID?: string;
  forTransferID?: string;
  forScheduleID?: string;
  forOccurrenceID?: string;
}
