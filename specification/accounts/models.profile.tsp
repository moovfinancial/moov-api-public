import "./models.representative.tsp";
import "./models.governmentid.tsp";

namespace MoovAPI.Accounts;

model CreateProfile {
  individual?: CreateIndividualProfile;
  business?: CreateBusinessProfile;
}

@doc("Describes a Moov account profile. A profile will have a business or an individual, depending on the account's type.")
model Profile {
  individual?: IndividualProfile;
  business?: BusinessProfile;
}

model CreateIndividualProfile {
  name: IndividualName;
  phone?: PhoneNumber;
  email?: Email;
  address?: Address;
  birthDate?: {
    @example(9)
    day: integer;

    @example(11)
    month: integer;

    @example(1989)
    year: integer;
  };
  governmentID?: GovernmentID;
}

@doc("Describes an individual.")
model IndividualProfile {
  name: IndividualName;
  phone?: PhoneNumber;
  email?: Email;
  address?: Address;

  @doc("Indicates whether this individual's birth date has been provided.")
  birthDateProvided?: boolean;

  @doc("Indicates whether a government ID (SSN, ITIN, etc.) has been provided for this individual.")
  governmentIDProvided?: boolean;
}

model IndividualName {
  @doc("The individual's first given name.")
  @example("Jordan")
  @maxLength(64)
  firstName: string;

  @doc("The individual's second given name, if any.")
  @example("Reese")
  @maxLength(64)
  middleName?: string;

  @doc("The individual's family name.")
  @example("Lee")
  @maxLength(64)
  lastName: string;

  @doc("Suffix of a given name.")
  @example("Jr")
  @maxLength(20)
  suffix?: string;
}

model CreateBusinessProfile {
  @doc("The legal name under which the entity is registered.")
  @example("Classbooker, LLC")
  @maxLength(64)
  legalBusinessName: string;

  @doc("A registered trade name under which the business operates, if different from its legal name.")
  @maxLength(64)
  doingBusinessAs?: string;

  businessType?: BusinessType;
  address?: Address;
  phone?: PhoneNumber;
  email?: Email;

  @maxLength(100)
  website?: url;

  @example("Local fitness gym paying out instructors")
  @minLength(10)
  @maxLength(100)
  description: string;

  taxID?: TaxID;
  industryCodes?: IndustryCodes;
  primaryRegulator?: PrimaryRegulator;
}

@doc("Describes a business.")
model BusinessProfile {
  @doc("The legal name under which the entity is registered.")
  @example("Classbooker, LLC")
  @maxLength(64)
  legalBusinessName: string;

  @doc("A registered trade name under which the business operates, if different from its legal name.")
  @maxLength(64)
  doingBusinessAs?: string;

  businessType?: BusinessType;
  address?: Address;
  phone?: PhoneNumber;
  email?: Email;

  @maxLength(100)
  website?: url;

  @example("Local fitness gym paying out instructors")
  @minLength(10)
  @maxLength(100)
  description: string;

  @doc("Indicates whether a tax ID has been provided for this business.")
  taxIDProvided?: boolean;

  representatives?: Representative[];
  ownersProvided: boolean;
  industryCodes?: IndustryCodes;
  primaryRegulator?: PrimaryRegulator;
}

@doc("The type of entity represented by this business.")
@example(BusinessType.LLC)
enum BusinessType {
  SoleProprietorship: "soleProprietorship",
  UnincorporatedAssociation: "unincorporatedAssociation",
  Trust: "trust",
  PublicCorporation: "publicCorporation",
  PrivateCorporation: "privateCorporation",
  LLC: "llc",
  Partnership: "partnership",
  UnincorporatedNonProfit: "unincorporatedNonProfit",
  IncorporatedNonProfit: "incorporatedNonProfit",
  GovernmentEntity: "governmentEntity",
}

model IndustryCodes {
  @example("713940")
  @minLength(2)
  @maxLength(6)
  naics: string;

  @example("7991")
  @minLength(4)
  @maxLength(4)
  sic: string;

  @example("7997")
  @minLength(4)
  @maxLength(4)
  mcc: string;
}

@doc("If the business is a financial institution, this field describes its primary regulator.")
enum PrimaryRegulator {
  OCC: "OCC",
  FDIC: "FDIC",
  NCUA: "NCUA",
  FRB: "FRB",
}
