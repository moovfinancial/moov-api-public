namespace MoovAPI;

@doc("Card-specific details about the transaction.")
model CardTransactionDetails {
  status: CardTransactionStatus;
  failureCode?: CardTransactionFailureCode;
  dynamicDescriptor?: CardDynamicDescriptor;
  transactionSource?: TransactionSource;
  initiatedOn?: utcDateTime;
  confirmedOn?: utcDateTime;
  settledOn?: utcDateTime;
  failedOn?: utcDateTime;
  canceledOn?: utcDateTime;
  completedOn?: utcDateTime;

  #deprecated "This field has been deprecated in favor of `feeProgram`."
  @doc("The program assigned by the card network that determines the interchange rate for the transfer.")
  @example("Visa Signature and Visa Infinite (Spend not-qualified) Product 1")
  interchangeQualification?: string;

  @doc("The program assigned by the card network that determines the interchange rate for the transfer.")
  @example("Visa Signature and Visa Infinite (Spend not-qualified) Product 1")
  feeProgram?: string;
}

model CreateTransferSourceCard {
  dynamicDescriptor?: CardDynamicDescriptor;
  transactionSource?: TransactionSource;
}

model CreateTransferDestinationCard {
  dynamicDescriptor?: CardDynamicDescriptor;
}

@doc("""
  Specifies the nature and initiator of a transaction. 
  
  Crucial for recurring and merchant-initiated transactions as per card scheme rules. 
  Omit for customer-initiated e-commerce transactions.
  """)
enum TransactionSource {
  @doc("Initial transaction in a recurring series or saving a card for future merchant-initiated charges.")
  FirstRecurring: "first-recurring",

  @doc("Regular, merchant-initiated scheduled transactions.")
  Recurring: "recurring",

  @doc("Non-regular, merchant-initiated transactions like account top-ups.")
  Unscheduled: "unscheduled",
}

@doc("Status of a transaction within the card payment lifecycle.")
enum CardTransactionStatus {
  Initiated: "initiated",
  Confirmed: "confirmed",
  Canceled: "canceled",
  Settled: "settled",
  Failed: "failed",
  Completed: "completed",
}

enum CardTransactionFailureCode {
  CallIssuer: "call-issuer",
  DoNotHonor: "do-not-honor",
  ProcessingError: "processing-error",
  InvalidTransaction: "invalid-transaction",
  InvalidAmount: "invalid-amount",
  NoSuchIssuer: "no-such-issuer",
  ReenterTransaction: "reenter-transaction",
  CvvMismatch: "cvv-mismatch",
  LostOrStolen: "lost-or-stolen",
  InsufficientFunds: "insufficient-funds",
  InvalidCardNumber: "invalid-card-number",
  InvalidMerchant: "invalid-merchant",
  ExpiredCard: "expired-card",
  IncorrectPin: "incorrect-pin",
  TransactionNotAllowed: "transaction-not-allowed",
  SuspectedFraud: "suspected-fraud",
  AmountLimitExceeded: "amount-limit-exceeded",
  VelocityLimitExceeded: "velocity-limit-exceeded",
  RevocationOfAuthorization: "revocation-of-authorization",
  CardNotActivated: "card-not-activated",
  IssuerNotAvailable: "issuer-not-available",
  CouldNotRoute: "could-not-route",
  CardholderAccountClosed: "cardholder-account-closed",
  UnknownIssue: "unknown-issue",
  DuplicateTransaction: "duplicate-transaction",
}

@doc("An optional override of the default card statement descriptor for a transfer. Accounts must be enabled by Moov to set this field.")
@example("WhlBdy *Yoga 11-12")
@minLength(4)
@maxLength(22)
scalar CardDynamicDescriptor extends string;
