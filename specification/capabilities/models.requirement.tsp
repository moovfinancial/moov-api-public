namespace MoovAPI;

@doc("Represents individual and business data necessary to facilitate the enabling of a capability for an account.")
model CapabilityRequirement {
  currentlyDue?: RequirementID[];
  errors?: RequirementError[];
}

model RequirementError {
  requirement: RequirementID;
  errorCode?: RequirementErrorCode;
}

@doc("The unique ID of what the requirement is asking to be filled out.")
enum RequirementID {
  accountToSAcceptance: "account.tos-acceptance",
  individualMobile: "individual.mobile",
  individualEmail: "individual.email",
  individualEmailOrMobile: "individual.email-or-mobile",
  individualFirstname: "individual.firstname",
  individualLastname: "individual.lastname",
  individualAddress: "individual.address",
  individualSSNLast4: "individual.ssn-last4",
  individualSSN: "individual.ssn",
  individualBirthdate: "individual.birthdate",
  businessLegalname: "business.legalname",
  businessDescriptionOrWebsite: "business.description-or-website",
  businessEntityType: "business.entity-type",
  businessBusinessType: "business.business-type",
  businessDBA: "business.dba",
  businessEIN: "business.ein",
  businessAddress: "business.address",
  businessPhone: "business.phone",
  businessAdmins: "business.admins",
  businessControllers: "business.controllers",
  businessOwners: "business.owners",
  businessClassification: "business.classification",
  businessIndustryCodeMCC: "business.industry-code-mcc",
  businessIndicateOwnersProvided: "business.indicate-owners-provided",
  businessAverageTransactionSize: "business.average-transaction-size",
  businessMaxTransactionSize: "business.max-transaction-size",
  businessAverageMonthlyTransactionVolume: "business.average-monthly-transaction-volume",
  businessVolumeByCustomerType: "business.volume-by-customer-type",
  businessCardVolumeDistribution: "business.card-volume-distribution",
  businessFulfillment: "business.fulfillment",
  businessDescription: "business.description",
  businessUnderwritingDocumentsTierOne: "business.underwriting-documents-tier-one",
  bankAccountsName: "bank-accounts.name",
  bankAccountsRoutingNumber: "bank-accounts.routing-number",
  bankAccountsAccountNumber: "bank-accounts.account-number",
  documentBusinessVerification: "document.business.verification",
  documentIndividualTIN: "document.individual.tin",
  documentIndividualVerification: "document.individual.verification",
  documentRepresentativeIDTIN: "document.representative.{rep-uuid}.tin",
  documentRepresentativeIDVerification: "document.representative.{rep-uuid}.verification",
  representativeIDMobile: "representative.{rep-uuid}.mobile",
  representativeIDEmail: "representative.{rep-uuid}.email",
  representativeIDEmailOrMobile: "representative.{rep-uuid}.email-or-mobile",
  representativeIDFirstname: "representative.{rep-uuid}.firstname",
  representativeIDLastname: "representative.{rep-uuid}.lastname",
  representativeIDAddress: "representative.{rep-uuid}.address",
  representativeIDSSNLast4: "representative.{rep-uuid}.ssn-last4",
  representativeIDSSN: "representative.{rep-uuid}.ssn",
  representativeIDBirthdate: "representative.{rep-uuid}.birthdate",
  representativeIDJobTitle: "representative.{rep-uuid}.job-title",
  representativeIDIsController: "representative.{rep-uuid}.is-controller",
  representativeIDIsOwner: "representative.{rep-uuid}.is-owner",
  representativeIDOwnership: "representative.{rep-uuid}.ownership",
  documentID: "document.{doc-uuid}",
}

enum RequirementErrorCode {
  invalidValue: "invalid-value",
  failedAutomaticVerification: "failed-automatic-verification",
  failedOther: "failed-other",
  invalidAddress: "invalid-address",
  addressRestricted: "address-restricted",
  taxIDMismatch: "tax-id-mismatch",
  documentIDMismatch: "document-id-mismatch",
  documentDateOfBirthMismatch: "document-date-of-birth-mismatch",
  documentNameMismatch: "document-name-mismatch",
  documentAddressMismatch: "document-address.mismatch",
  documentNumberMismatch: "document-number-mismatch",
  documentIncomplete: "document-incomplete",
  documentFailedRisk: "document-failed-risk",
  documentIllegible: "document-illegible",
  documentUnsupported: "document-unsupported",
  documentNotUploaded: "document-not-uploaded",
  documentCorrupt: "document-corrupt",
  documentExpired: "document-expired",
}
