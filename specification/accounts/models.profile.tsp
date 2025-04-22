import "../representatives/models.representatives.tsp";
import "./models.governmentid.tsp";

namespace MoovAPI;

model CreateProfile {
  individual?: CreateIndividualProfile;
  business?: CreateBusinessProfile;
}

model CreateProfileError {
  individual?: CreateIndividualError;
  business?: CreateBusinessError;
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
  birthDate?: BirthDate;
  governmentID?: GovernmentID;
}

model BirthDate {
  @example(9)
  day: integer;

  @example(11)
  month: integer;

  @example(1989)
  year: integer;
}

model CreateIndividualError {
  name?: IndividualNameError;
  phone?: PhoneNumberError;
  email?: string;
  address?: AddressError;
  birthDate?: BirthDateError;
  governmentID?: {
    ssn?: {
      full?: string;
      lastFour?: string;
    };
    itin?: {
      full?: string;
      lastFour?: string;
    };
  };
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

model BirthDateError {
  day?: string;
  month?: string;
  year?: string;
}

const NameStringPattern = "[À-ÖØ-öø-ÿ\"'(),-.0-9A-Za-z~ &!]*";

model IndividualName {
  @doc("The individual's first given name.")
  @example("Jordan")
  @pattern(NameStringPattern)
  @maxLength(64)
  firstName: string;

  @doc("The individual's second given name, if any.")
  @example("Reese")
  @pattern(NameStringPattern)
  @maxLength(64)
  middleName?: string;

  @doc("The individual's family name.")
  @example("Lee")
  @pattern(NameStringPattern)
  @maxLength(64)
  lastName: string;

  @doc("Suffix of a given name.")
  @example("Jr")
  @pattern(NameStringPattern)
  @maxLength(20)
  suffix?: string;
}

model IndividualNameError {
  firstName?: string;
  middleName?: string;
  lastName?: string;
  suffix?: string;
}

model CreateBusinessProfile {
  @doc("The legal name under which the entity is registered.")
  @example("Classbooker, LLC")
  @pattern(ValidStringPattern)
  @maxLength(64)
  legalBusinessName: string;

  @doc("A registered trade name under which the business operates, if different from its legal name.")
  @maxLength(64)
  @pattern(ValidStringPattern)
  doingBusinessAs?: string;

  businessType?: BusinessType;
  address?: Address;
  phone?: PhoneNumber;
  email?: Email;

  @maxLength(100)
  website?: url;

  @example("Local fitness gym paying out instructors")
  @pattern(ValidStringPattern)
  @minLength(10)
  @maxLength(100)
  description?: string;

  taxID?: TaxID;
  industryCodes?: IndustryCodes;
  primaryRegulator?: PrimaryRegulator;
}

model CreateBusinessError {
  legalBusinessName?: string;
  doingBusinessAs?: string;
  businessType?: string;
  address?: AddressError;
  phone?: PhoneNumberError;
  email?: string;
  website?: string;
  description?: string;
  taxID?: {
    ein?: {
      number?: string;
    };
  };
  industryCodes?: {
    naics?: string;
    sic?: string;
    mcc?: string;
  };
  primaryRegulator?: string;
}

@doc("Describes a business.")
model BusinessProfile {
  @doc("The legal name under which the entity is registered.")
  @example("Classbooker, LLC")
  @pattern(ValidStringPattern)
  @maxLength(64)
  legalBusinessName: string;

  @doc("A registered trade name under which the business operates, if different from its legal name.")
  @maxLength(64)
  @pattern(ValidStringPattern)
  doingBusinessAs?: string;

  businessType?: BusinessType;
  address?: Address;
  phone?: PhoneNumber;
  email?: Email;

  @maxLength(100)
  website?: url;

  @example("Local fitness gym paying out instructors")
  @pattern(ValidStringPattern)
  @minLength(10)
  @maxLength(100)
  description?: string;

  @doc("Indicates whether a tax ID has been provided for this business.")
  taxIDProvided?: boolean;

  representatives?: Representative[];
  ownersProvided: boolean;
  industryCodes?: IndustryCodes;
  primaryRegulator?: PrimaryRegulator;
}

@doc("""
  Describes the fields available when patching a profile.
  Each object can be patched independent of patching the other fields.
  """)
model PatchProfile {
  individual?: PatchIndividual;
  business?: PatchBusiness;
}

@doc("Describes the fields available when patching an individual.")
model PatchIndividual {
  name?: IndividualName;
  phone?: PhoneNumber;
  email?: Email;
  address?: Address;
  birthDate?: BirthDate;
  governmentID?: GovernmentID;
}

model PatchBusiness {
  @maxLength(64)
  @pattern(ValidStringPattern)
  legalBusinessName?: string;

  @maxLength(64)
  @pattern(ValidStringPattern)
  doingBusinessAs?: string;

  businessType?: BusinessType;
  address?: Address;
  phone?: PhoneNumber;
  email?: Email;

  @maxLength(100)
  website?: string;

  @minLength(10)
  @maxLength(100)
  @pattern(ValidStringPattern)
  description?: string;

  taxID?: TaxID;
  ownersProvided?: boolean;
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
  naics?: string;

  @example("7991")
  @minLength(4)
  @maxLength(4)
  sic?: string;

  @example("7997")
  @minLength(4)
  @maxLength(4)
  mcc?: string;
}

@doc("If the business is a financial institution, this field describes its primary regulator.")
enum PrimaryRegulator {
  OCC: "OCC",
  FDIC: "FDIC",
  NCUA: "NCUA",
  FRB: "FRB",
}
