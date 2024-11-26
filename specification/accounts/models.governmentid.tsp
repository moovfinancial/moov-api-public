namespace MoovAPI;

model GovernmentID {
  ssn?: {
    @pattern("^\\d{3}[-]?\\d{2}[-]?\\d{4}$")
    full?: string;

    lastFour?: string;
  };
  itin?: {
    @pattern("^\\d{3}[-]?\\d{2}[-]?\\d{4}$")
    full?: string;

    lastFour?: string;
  };
}

@doc("An EIN (employer identification number) for the business. For sole proprietors, an SSN can be used as the EIN.")
model TaxID {
  ein: {
    @example("12-3456789")
    number: string;
  };
}
