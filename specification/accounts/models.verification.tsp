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
  Unverified: "unverified",
  Pending: "pending",
  Resubmit: "resubmit",
  Review: "review",
  Verified: "verified",
  Failed: "failed",
}

#deprecated "This field has been deprecated and will be removed in a future release."
@doc("Possible states an account verification can be in.")
enum VerificationStatus {
  Unverified: "unverified",
  Pending: "pending",
  Verified: "verified",
  Errored: "errored",
}

#deprecated "This field is deprecated and will be removed in a future release."
@doc("Additional detail for a verification status.")
enum VerificationStatusDetail {
  FailedAutoVerify: "failedAutoVerify",
  DocDobMismatch: "docDobMismatch",
  DocNameMismatch: "docNameMismatch",
  DocAddressMismatch: "docAddressMismatch",
  DocNumberMismatch: "docNumberMismatch",
  DocIncomplete: "docIncomplete",
  DocFailedRisk: "docFailedRisk",
  PotentialAccountSanctionsMatch: "potentialAccountSanctionsMatch",
  PotentialRepresentativeSanctionsMatch: "potentialRepresentativeSanctionsMatch",
  FailedOther: "failedOther",
}
