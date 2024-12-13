namespace MoovAPI;

@doc("The countries in which an account operates.")
model AccountCountries {
  countries: OperatingCountry[];
}

@maxLength(64)
@example("United States")
scalar OperatingCountry extends string;

model AssignCountriesError {
  error: CountriesErrors;
}

model CountriesErrors {
  countries: Record<string>;
}
