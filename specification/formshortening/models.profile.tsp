import "../common/models.address.tsp";
import "../common/models.email.tsp";
import "../common/models.phone.tsp";

namespace MoovAPI;

model EnrichedBusinessProfile {
  address?: Address;
  email?: Email;
  industryCodes?: EnrichedIndustryCodes;
  legalBusinessName?: string;
  phone?: PhoneNumber;
  website?: string;
}

model EnrichedIndustryCodes {
  @example("713940")
  @minLength(2)
  @maxLength(6)
  naics: string;

  @example("7991")
  @minLength(4)
  @maxLength(4)
  sic: string;
}
