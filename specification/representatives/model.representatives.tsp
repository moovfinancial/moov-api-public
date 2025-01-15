import "../accounts/models.representative.tsp";
import "../common/models.address.tsp";
import "../common/models.phone.tsp";
import "../accounts/models.profile.tsp";

namespace MoovAPI;

alias RepresentativePropsNotInCreate =
  | "representativeID"
  | "createdOn"
  | "updatedOn"
  | "governmentIDProvided"
  | "birthDateProvided";

// Omit the properties of Representative are not present in the create operation to get the create model
model CreateRepresentative
  extends OmitProperties<Representative, RepresentativePropsNotInCreate> {}

// Take the CreateRepresentative model and make all the properties optional, then add representativeID as required
alias UpdateRepresentative = OptionalProperties<CreateRepresentative> &
  PickProperties<Representative, "representativeID">;

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
