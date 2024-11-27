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
  firstRecurring: "first-recurring",

  @doc("Regular, merchant-initiated scheduled transactions.")
  recurring: "recurring",

  @doc("Non-regular, merchant-initiated transactions like account top-ups.")
  unscheduled: "unscheduled",
}

@doc("Status of a transaction within the card payment lifecycle.")
enum CardTransactionStatus {
  initiated,
  confirmed,
  canceled,
  settled,
  failed,
  completed,
}

enum CardTransactionFailureCode {
  callIssuer: "call-issuer",
  doNotHonor: "do-not-honor",
  processingError: "processing-error",
  invalidTransaction: "invalid-transaction",
  invalidAmount: "invalid-amount",
  noSuchIssuer: "no-such-issuer",
  reenterTransaction: "reenter-transaction",
  cvvMismatch: "cvv-mismatch",
  lostOrStolen: "lost-or-stolen",
  insufficientFunds: "insufficient-funds",
  invalidCardNumber: "invalid-card-number",
  invalidMerchant: "invalid-merchant",
  expiredCard: "expired-card",
  incorrectPIN: "incorrect-pin",
  transactionNotAllowed: "transaction-not-allowed",
  suspectedFraud: "suspected-fraud",
  amountLimitExceeded: "amount-limit-exceeded",
  velocityLimitExceeded: "velocity-limit-exceeded",
  revocationOfAuthorization: "revocation-of-authorization",
  cardNotActivated: "card-not-activated",
  issuerNotAvailable: "issuer-not-available",
  couldNotRoute: "could-not-route",
  cardholderAccountClosed: "cardholder-account-closed",
  unknownIssue: "unknown-issue",
  duplicateTransaction: "duplicate-transaction",
}

@doc("An optional override of the default card statement descriptor for a transfer. Accounts must be enabled by Moov to set this field.")
@example("WhlBdy *Yoga 11-12")
@minLength(4)
@maxLength(22)
scalar CardDynamicDescriptor extends string;
