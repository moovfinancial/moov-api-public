import "./models.bankaccount.tsp";

namespace MoovAPI;

model BankAccountVerification {
  verificationMethod: BankAccountVerificationMethod;
  status: BankAccountVerificationStatus;
  exceptionDetails?: BankAccountException;
}

model BankAccountVerificationCreated {
  verificationMethod: BankAccountVerificationMethod;
  status: BankAccountVerificationStatus;
}

model CompleteBankAccountVerification {
  @doc("Code provided by user from their bank account transactions")
  @example("MV1234")
  code: string;
}

enum BankAccountVerificationMethod {
  instant: "instant",
  ach: "ach",
}

enum BankAccountVerificationStatus {
  new: "new",
  sentCredit: "sent-credit",
  maxAttemptsExceeded: "max-attempts-exceeded",
  failed: "failed",
  expired: "expired",
  successful: "successful",
}
