namespace MoovAPI;

@doc("ACH specific details about the transaction.")
model AchTransactionDetails {
  status: AchTransactionStatus;

  @example("124782618117")
  @maxLength(15)
  traceNumber: string;

  `return`?: AchException;
  correction?: AchException;
  companyEntryDescription?: AchCompanyEntryDescription;
  originatingCompanyName?: AchOriginatingCompanyName;
  secCode?: SecCode;
  initiatedOn?: utcDateTime;
  originatedOn?: utcDateTime;
  correctedOn?: utcDateTime;
  returnedOn?: utcDateTime;
  completedOn?: utcDateTime;
  debitHoldPeriod?: DebitHoldPeriod;
}

model AchException {
  code?: string;
  reason?: string;
  description?: string;
}

model CreateTransferSourceACH {
  companyEntryDescription?: AchCompanyEntryDescription;
  originatingCompanyName?: AchOriginatingCompanyName;
  debitHoldPeriod?: DebitHoldPeriod;
  secCode?: SecCode;
}

model CreateTransferDestinationACH {
  companyEntryDescription?: AchCompanyEntryDescription;
  originatingCompanyName?: AchOriginatingCompanyName;
}

@doc("An optional override of your default ACH hold period in banking days. The hold period must be longer than or equal to your default setting.")
@example(DebitHoldPeriod.TwoDay)
enum DebitHoldPeriod {
  NoHold: "no-hold",
  OneDay: "1-day",
  TwoDay: "2-days",
}

@doc("Code used to identify the ACH authorization method.")
enum SecCode {
  Web: "WEB",
  PPD: "PPD",
  CCD: "CCD",
  TEL: "TEL",
}

@doc("Status of a transaction within the ACH lifecycle.")
enum AchTransactionStatus {
  Initiated: "initiated",
  Originated: "originated",
  Corrected: "corrected",
  Returned: "returned",
  Completed: "completed",
}

@doc("An optional override of the default NACHA company entry description for a transfer.")
@example("Gym dues")
@minLength(4)
@maxLength(10)
scalar AchCompanyEntryDescription extends string;

@doc("An optional override of the default NACHA company name for a transfer.")
@example("Whole Body Fit")
@minLength(4)
@maxLength(16)
scalar AchOriginatingCompanyName extends string;
