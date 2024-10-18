namespace MoovAPI.Capabilities;

@doc("Represents individual and business data necessary to facilitate the enabling of a capability for an account.")
model Requirement {
  currentlyDue: RequirementID[];
  errors?: RequirementError[];
}

model RequirementError {
  requirement: RequirementID;
  errorCode?: RequirementErrorCode;
}

@doc("The unique ID of what the requirement is asking to be filled out.")
enum RequirementID {
  AccountToSAcceptance: "account.tos-acceptance",
  IndividualMobile: "individual.mobile",
  IndividualEmail: "individual.email",
  IndividualEmailOrMobile: "individual.email-or-mobile",
  IndividualFirstname: "individual.firstname",
  IndividualLastname: "individual.lastname",
  IndividualAddress: "individual.address",
  IndividualSSNLast4: "individual.ssn-last4",
  IndividualSSN: "individual.ssn",
  IndividualBirthdate: "individual.birthdate",
  BusinessLegalname: "business.legalname",
  BusinessDescriptionOrWebsite: "business.description-or-website",
  BusinessEntityType: "business.entity-type",
  BusinessBusinessType: "business.business-type",
  BusinessDBA: "business.dba",
  BusinessEIN: "business.ein",
  BusinessAddress: "business.address",
  BusinessPhone: "business.phone",
  BusinessAdmins: "business.admins",
  BusinessControllers: "business.controllers",
  BusinessOwners: "business.owners",
  BusinessClassification: "business.classification",
  BusinessIndustryCodeMCC: "business.industry-code-mcc",
  BusinessIndicateOwnersProvided: "business.indicate-owners-provided",
  BusinessAverageTransactionSize: "business.average-transaction-size",
  BusinessMaxTransactionSize: "business.max-transaction-size",
  BusinessAverageMonthlyTransactionVolume: "business.average-monthly-transaction-volume",
  BusinessVolumeByCustomerType: "business.volume-by-customer-type",
  BusinessCardVolumeDistribution: "business.card-volume-distribution",
  BusinessFulfillment: "business.fulfillment",
  BusinessDescription: "business.description",
  BusinessUnderwritingDocumentsTierOne: "business.underwriting-documents-tier-one",
  BankAccountsName: "bank-accounts.name",
  BankAccountsRoutingNumber: "bank-accounts.routing-number",
  BankAccountsAccountNumber: "bank-accounts.account-number",
  DocumentBusinessVerification: "document.business.verification",
  DocumentIndividualTIN: "document.individual.tin",
  DocumentIndividualVerification: "document.individual.verification",
  DocumentRepresentativeIDTIN: "document.representative.{rep-uuid}.tin",
  DocumentRepresentativeIDVerification: "document.representative.{rep-uuid}.verification",
  RepresentativeIDMobile: "representative.{rep-uuid}.mobile",
  RepresentativeIDEmail: "representative.{rep-uuid}.email",
  RepresentativeIDEmailOrMobile: "representative.{rep-uuid}.email-or-mobile",
  RepresentativeIDFirstname: "representative.{rep-uuid}.firstname",
  RepresentativeIDLastname: "representative.{rep-uuid}.lastname",
  RepresentativeIDAddress: "representative.{rep-uuid}.address",
  RepresentativeIDSSNLast4: "representative.{rep-uuid}.ssn-last4",
  RepresentativeIDSSN: "representative.{rep-uuid}.ssn",
  RepresentativeIDBirthdate: "representative.{rep-uuid}.birthdate",
  RepresentativeIDJobTitle: "representative.{rep-uuid}.job-title",
  RepresentativeIDIsController: "representative.{rep-uuid}.is-controller",
  RepresentativeIDIsOwner: "representative.{rep-uuid}.is-owner",
  RepresentativeIDOwnership: "representative.{rep-uuid}.ownership",
  DocumentID: "document.{doc-uuid}",
}

enum RequirementErrorCode {
  InvalidValue: "invalid-value",
  FailedAutomaticVerification: "failed-automatic-verification",
  FailedOther: "failed-other",
  InvalidAddress: "invalid-address",
  AddressRestricted: "address-restricted",
  TaxIDMismatch: "tax-id-mismatch",
  DocumentIDMismatch: "document-id-mismatch",
  DocumentDateOfBirthMismatch: "document-date-of-birth-mismatch",
  DocumentNameMismatch: "document-name-mismatch",
  DocumentAddressMismatch: "document-address.mismatch",
  DocumentNumberMismatch: "document-number-mismatch",
  DocumentIncomplete: "document-incomplete",
  DocumentFailedRisk: "document-failed-risk",
  DocumentIllegible: "document-illegible",
  DocumentUnsupported: "document-unsupported",
  DocumentNotUploaded: "document-not-uploaded",
  DocumentCorrupt: "document-corrupt",
  DocumentExpired: "document-expired",
}
