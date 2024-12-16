namespace MoovAPI;

model PhoneNumber {
  @example("8185551212")
  @maxLength(10)
  number?: string;

  @example("1")
  @maxLength(1)
  countryCode?: string;
}

model PhoneNumberError {
  number?: string;
  countryCode?: string;
}
