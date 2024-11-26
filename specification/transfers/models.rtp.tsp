namespace MoovAPI;

@doc("RTP specific details about the transaction.")
model RtpTransactionDetails {
  status: RtpTransactionStatus;

  @doc("Response code returned by network on failure.")
  networkResponseCode?: string;

  failureCode?: RtpFailureCode;
  initiatedOn?: utcDateTime;
  completedOn?: utcDateTime;
  failedOn?: utcDateTime;
  acceptedWithoutPostingOn?: utcDateTime;
}

@doc("Status of a transaction within the RTP lifecycle.")
enum RtpTransactionStatus {
  Initiated: "initiated",
  Completed: "completed",
  Failed: "failed",
  AcceptedWithoutPosting: "accepted-without-posting",
}

@doc("Status codes for RTP failures.")
enum RtpFailureCode {
  ProcessingError: "processing-error",
  InvalidAccount: "invalid-account",
  AccountClosed: "account-closed",
  AccountBlocked: "account-blocked",
  InvalidField: "invalid-field",
  TransactionNotSupported: "transaction-not-supported",
  LimitExceeded: "limit-exceeded",
  InvalidAmount: "invalid-amount",
  CustomerDeceased: "customer-deceased",
  Other: "other",
}
