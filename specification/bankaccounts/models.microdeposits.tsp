namespace MoovAPI;

@doc("Request to complete the micro-deposit verification workflow.")
model CompleteMicroDeposits {
  @doc("Two positive integers, in cents, equal to the values of the micro-deposits sent to the bank account.")
  @example(#[18, 21])
  amounts: integer[];
}

model MicroDepositValidationError {
  amounts?: string;
}

model CompletedMicroDeposits {
  status: MicroDepositStatus;
}

enum MicroDepositStatus {
  verified: "verified",
}
