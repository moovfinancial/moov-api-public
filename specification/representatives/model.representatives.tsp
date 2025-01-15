import "../accounts/models.representative.tsp";
import "../common/models.address.tsp";
import "../common/models.phone.tsp";
import "../accounts/models.profile.tsp";

namespace MoovAPI;

model CreateRepresentative
  extends OmitProperties<
    Representative,

      | "createdOn"
      | "updatedOn"
      | "representativeID"
      | "governmentIDProvided"
      | "birthDateProvided"
  > {}

model BirthDateObjectValidationError {
  day?: string;
  month?: string;
  year?: string;
}

alias BirthDateValidationError = BirthDateObjectValidationError | string;

model GovernmentIDError {
  ssn?: {
    full?: string;
    lastFour?: string;
  };
  itin?: {
    full?: string;
    lastFour?: string;
  };
}

model RepresentativeResponsibilitiesError {
  isController?: string;
  isOwner?: string;
  ownershipPercentage?: string;
  jobTitle?: string;
}

model RepresentativeValidationError {
  error: {
    name?: IndividualNameError;
    phone?: PhoneNumberError;
    email?: string;
    address?: AddressError;
    birthDate?: BirthDateValidationError;
    governmentID?: GovernmentIDError;
    responsibilities?: RepresentativeResponsibilitiesError;
  };
}
