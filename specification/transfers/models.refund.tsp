namespace MoovAPI;

@doc("Details of a card refund.")
model CardTransferRefund {
  @doc("Identifier for the refund.")
  @format("uuid")
  refundID: string;

  createdOn: utcDateTime;
  updatedOn: utcDateTime;
  status: RefundStatus;
  amount: Amount;
  cardDetails?: RefundCardDetails;
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
  Created: "created",
  Pending: "pending",
  Completed: "completed",
  Failed: "failed",
}

enum RefundCardStatus {
  Initiated: "initiated",
  Confirmed: "confirmed",
  Settled: "settled",
  Failed: "failed",
  Completed: "completed",
}
