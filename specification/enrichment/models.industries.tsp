namespace MoovAPI;

model EnrichedIndustries {
  industries: EnrichedIndustry[];
}

@doc("An industry's MCC/SIC/NAICS codes, along with descriptive title.")
model EnrichedIndustry {
  @example("AC, Refrigeration Repair")
  title: string;

  @doc("North American Industry Classification System")
  @example("811412")
  @maxLength(6)
  naics: string;

  @doc("Standard Industrial Classification")
  @example("7623")
  @maxLength(4)
  sic: string;

  @doc("Merchant Category Code")
  @example("7623")
  @maxLength(4)
  mcc: string;
}
