namespace MoovAPI;

@doc("ACH specific details about the transaction.")
model ACHTransactionDetails {
  status: ACHTransactionStatus;

  @example("124782618117")
  @maxLength(15)
  traceNumber: string;

  `return`?: ACHException;
  correction?: ACHException;
  companyEntryDescription?: ACHCompanyEntryDescription;
  originatingCompanyName?: ACHOriginatingCompanyName;
  secCode?: SECCode;
  initiatedOn?: utcDateTime;
  originatedOn?: utcDateTime;
  correctedOn?: utcDateTime;
  returnedOn?: utcDateTime;
  failedOn?: utcDateTime;
  completedOn?: utcDateTime;
  debitHoldPeriod?: DebitHoldPeriod;
}

model ACHException {
  code?: string;
  reason?: string;
  description?: string;
}

model CreateTransferSourceACH {
  companyEntryDescription?: ACHCompanyEntryDescription;
  originatingCompanyName?: ACHOriginatingCompanyName;
  debitHoldPeriod?: DebitHoldPeriod;
  secCode?: SECCode;
}

model CreateTransferDestinationACH {
  companyEntryDescription?: ACHCompanyEntryDescription;
  originatingCompanyName?: ACHOriginatingCompanyName;
}

@doc("An optional override of your default ACH hold period in banking days. The hold period must be longer than or equal to your default setting.")
@example(DebitHoldPeriod.twoDays)
enum DebitHoldPeriod {
  noHold: "no-hold",
  oneDay: "1-day",
  twoDays: "2-days",
}

@doc("Code used to identify the ACH authorization method.")
enum SECCode {
  WEB,
  PPD,
  CCD,
  TEL,
}

@doc("Status of a transaction within the ACH lifecycle.")
enum ACHTransactionStatus {
  initiated,
  originated,
  corrected,
  returned,
  completed,
}

@doc("An optional override of the default NACHA company entry description for a transfer.")
@example("Gym dues")
@minLength(4)
@maxLength(10)
scalar ACHCompanyEntryDescription extends string;

@doc("An optional override of the default NACHA company name for a transfer.")
@example("Whole Body Fit")
@minLength(4)
@maxLength(16)
scalar ACHOriginatingCompanyName extends string;
