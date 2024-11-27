import "./models.document.tsp";

namespace MoovAPI;

@doc("Describes identity verification status and relevant identity verification documents.")
model Verification {
  verificationStatus?: AccountVerificationStatus;
  status: VerificationStatus;
  details?: VerificationStatusDetail;
  documents?: Document[];
}

#deprecated "This field has been deprecated and will be removed in a future release."
@doc("Possible states an account verification can be in.")
enum AccountVerificationStatus {
  unverified,
  pending,
  resubmit,
  review,
  verified,
  failed,
}

#deprecated "This field has been deprecated and will be removed in a future release."
@doc("Possible states an account verification can be in.")
enum VerificationStatus {
  unverified,
  pending,
  verified,
  errored,
}

#deprecated "This field is deprecated and will be removed in a future release."
@doc("Additional detail for a verification status.")
enum VerificationStatusDetail {
  failedAutoVerify,
  docDobMismatch,
  docNameMismatch,
  docAddressMismatch,
  docNumberMismatch,
  docIncomplete,
  docFailedRisk,
  potentialAccountSanctionsMatch,
  potentialRepresentativeSanctionsMatch,
  failedOther,
}
