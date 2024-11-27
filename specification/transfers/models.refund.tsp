namespace MoovAPI;

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
