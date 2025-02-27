namespace MoovAPI;

model Address {
  @example("123 Main Street")
  @maxLength(60)
  addressLine1: string;

  @example("Apt 302")
  @maxLength(32)
  addressLine2?: string;

  @example("Boulder")
  @maxLength(32)
  city: string;

  @example("CO")
  @maxLength(2)
  stateOrProvince: string;

  @example("80301")
  @maxLength(5)
  postalCode: string;

  @example("US")
  @maxLength(2)
  country: string;
}

model AddressError {
  addressLine1?: string;
  addressLine2?: string;
  city?: string;
  stateOrProvince?: string;
  postalCode?: string;
  country?: string;
}
