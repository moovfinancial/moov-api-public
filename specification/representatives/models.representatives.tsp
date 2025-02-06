import "../common/models.address.tsp";
import "../common/models.email.tsp";
import "../common/models.phone.tsp";
import "../accounts/models.profile.tsp";

namespace MoovAPI;

@doc("Describes a business representative.")
model Representative {
  @doc("Unique identifier for this representative.")
  @format("uuid")
  representativeID: string;

  name: IndividualName;
  phone?: PhoneNumber;
  email?: Email;
  address?: Address;

  @doc("Indicates whether this representative's birth date has been provided.")
  birthDateProvided?: boolean;

  @doc("Indicates whether a government ID (SSN, ITIN, etc.) has been provided for this representative.")
  governmentIDProvided?: boolean;

  responsibilities?: RepresentativeResponsibilities;
  createdOn: utcDateTime;
  updatedOn: utcDateTime;
  disabledOn?: utcDateTime;
}

@doc("Describes the job responsibilities of a business representative.")
model RepresentativeResponsibilities {
  @doc("Indicates whether this individual has significant management responsibilities within the business.")
  isController?: boolean;

  @doc("""
    If `true`, this field indicates that the individual has a business ownership stake of at least 25% in the
    business. If the representative does not own at least 25% of the business, this field should be `false`.
    """)
  isOwner?: boolean;

  @doc("The percentage of ownership this individual has in the business (required if `isOwner` is `true`).")
  @example(38)
  ownershipPercentage?: integer;

  @example("CEO")
  @maxLength(64)
  jobTitle?: string;
}

alias RepresentativePropsNotInCreate =
  | "representativeID"
  | "createdOn"
  | "updatedOn"
  | "disabledOn"
  | "governmentIDProvided"
  | "birthDateProvided";

// Omit the properties of Representative are not present in the create operation to get the create model. Omit responsibilities as it is optional for create.
@doc("Describes a business representative to create.")
model CreateRepresentative
  extends OmitProperties<
    Representative,
    RepresentativePropsNotInCreate | "responsibilities"
  > {
  birthDate?: BirthDate;
  governmentID?: GovernmentID;
  responsibilities?: RepresentativeResponsibilities;
}

model UpdateRepresentative {
  name?: IndividualName;
  phone?: PhoneNumber | null;
  email?: Email | null;
  address?: Address | null;
  birthDate?: BirthDate | null;
  governmentID?: GovernmentID | null;
  responsibilities?: RepresentativeResponsibilities | null;
}

model BirthDateValidationError {
  day?: string;
  month?: string;
  year?: string;
}

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
