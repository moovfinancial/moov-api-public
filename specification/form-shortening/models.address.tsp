using TypeSpec.Http;

namespace MoovAPI;

model EnrichedAddressFilters {
  @doc("Partial or complete address to search.")
  @example("Ocean Ave")
  @query
  search: string;

  @doc("Maximum number of results to return.")
  @example(10)
  @query
  maxResults?: integer;

  @doc("Limits results to a list of given cities.")
  @example("chicago;honolulu;portland")
  @query
  includeCities?: string;

  @doc("Limits results to a list of given states.")
  @example("illinois;hawaii;oregon")
  @query
  includeStates?: string;

  @doc("Limits results to a list of given zipcodes.")
  @example("60412;96818;97209")
  @query
  includeZipcodes?: string;

  @doc("Exclude list of states from results. No `include` pararmeters may be used with this parameter.")
  @example("AZ;WA;SC")
  @query
  excludeStates?: string;

  @doc("Display results with the listed cities at the top.")
  @example("denver;aurora;omaha")
  @query
  preferCities?: string;

  @doc("Display results with the listed states at the top.")
  @example("CO;MN;WI")
  @query
  preferStates?: string;

  @doc("Display results with the listed zipcodes at the top.")
  @example("60412;96818;97209")
  @query
  preferZipcodes?: string;

  @doc("Specifies the percentage of address suggestions that should be preferred and will appear at the top of the results.")
  @example(45)
  @query
  preferRatio?: integer;

  @doc("""
      If omitted or set to `city`, it uses the sender’s IP address to determine location, then automatically adds the city and state 
      to the preferCities value. This parameter takes precedence over other `include` or `exclude` parameters meaning that if it is 
      not set to `none`, you may see addresses from areas you do not wish to see.
    """)
  @example("none")
  @query
  preferGeolocation?: string;

  @doc("Useful for narrowing results with `addressLine2` suggestions such as `Apt` (denotes an apartment building with multiple residences).")
  @example("Apt")
  @query
  selected?: string;

  @doc("Include results from alternate data sources. Allowed values are `all` (non-postal addresses), or `postal` (postal addresses only).")
  @example("all")
  @query
  source?: string;
}

model EnrichedAddressResponse {
  addressLine1?: string;
  addressLine2?: string;
  city?: string;

  @doc("The number of units at an address. For example the number of apartments or businesses in a building.")
  entries?: integer;

  postalCode?: string;
  stateOrProvince?: string;
}
