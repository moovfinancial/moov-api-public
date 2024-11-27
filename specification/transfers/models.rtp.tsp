namespace MoovAPI;

@doc("RTP specific details about the transaction.")
model RTPTransactionDetails {
  status: RTPTransactionStatus;

  @doc("Response code returned by network on failure.")
  networkResponseCode?: string;

  failureCode?: RTPFailureCode;
  initiatedOn?: utcDateTime;
  completedOn?: utcDateTime;
  failedOn?: utcDateTime;
  acceptedWithoutPostingOn?: utcDateTime;
}

@doc("Status of a transaction within the RTP lifecycle.")
enum RTPTransactionStatus {
  initiated: "initiated",
  completed: "completed",
  failed: "failed",
  acceptedWithoutPosting: "accepted-without-posting",
}

@doc("Status codes for RTP failures.")
enum RTPFailureCode {
  processingError: "processing-error",
  invalidAccount: "invalid-account",
  accountClosed: "account-closed",
  accountBlocked: "account-blocked",
  invalidField: "invalid-field",
  transactionNotSupported: "transaction-not-supported",
  limitExceeded: "limit-exceeded",
  invalidAmount: "invalid-amount",
  customerDeceased: "customer-deceased",
  other: "other",
}
