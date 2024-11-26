namespace MoovAPI;

@doc("User provided settings to manage an account.")
model Settings {
  cardPayment?: CardPaymentSettings;
  achPayment?: ACHPaymentSettings;
}

@doc("User provided settings to manage card payments. This data is only allowed on a business account.")
model CardPaymentSettings {
  @doc("The description that shows up on credit card transactions. This will default to the accounts display name on account creation.")
  @pattern("[a-zA-Z0-9.!*-+_\\- ]+")
  @example("Whole Body Fitness")
  @minLength(4)
  @maxLength(22)
  statementDescriptor?: string;
}

model ACHPaymentSettings {
  @doc("The description that shows up on ACH transactions. This will default to the account's display name on account creation.")
  @example("WholeBodyFitness")
  @pattern("[a-zA-Z0-9.!*-+_\\- ]+")
  @minLength(1)
  @maxLength(16)
  companyName: string;
}
