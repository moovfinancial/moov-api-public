namespace MoovAPI;

@doc("Describes a business representative.")
model Representative {
  @doc("Unique identifier for this representative.")
  @format("uuid")
  representativeID: string;

  name: IndividualName;
  phone?: PhoneNumber;
  email: Email;
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
  ownershipPercentage: integer;

  @example("CEO")
  @maxLength(64)
  jobTitle: string;
}
