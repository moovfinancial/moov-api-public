namespace MoovAPI;

@doc("Describes a file linked to a Moov account.")
model FileDetails {
  @format("uuid")
  fileID: string;

  @example("logo.png")
  @maxLength(64)
  fileName: string;

  @format("uuid")
  accountID: string;

  filePurpose: FilePurpose;
  fileStatus: FileStatus;

  @format("json")
  @example("{\"error_code\": \"document-name-mismatch\", \"requirement_id\": \"document.individual.verification\", \"representative_id\": \"c63ab175-251d-497e-a267-7346d087e180\", \"comment\": \"testing comment\"")
  metadata: string;

  @example("not correct file")
  decisionReason: string;

  fileSizeBytes: integer;
  createdOn: utcDateTime;
  updatedOn: utcDateTime;
}

@doc("Request to upload a file for an account.")
model FileUploadRequest {
  @doc("The file to be added. Valid types are `csv`, `png`, `jpeg`, `pdf`.")
  @format("binary")
  file: string;

  filePurpose: FilePurpose;

  @doc("""
    Additional metadata to be stored with the file, formatted as a JSON string.
    
    Valid keys are `representative_id`, `comment`, `requirement_id`, `error_code`.
    """)
  @example("{\"requirement_id\": \"document.individual.verification\"}")
  @format("json")
  metadata?: string;
}

model FileValidationError {
  error?: string;
  file?: string;
  filePurpose?: string;
  metadata?: string;
}

@doc("The file's purpose.")
@example(FilePurpose.representativeVerification)
enum FilePurpose {
  businessVerification: "business_verification",
  representativeVerification: "representative_verification",
  individualVerification: "individual_verification",
  merchantUnderwriting: "merchant_underwriting",
  accountRequirement: "account_requirement",
  #deprecated "Use the appropriate individual_verification, representative_verification, or business_verification purpose instead."
  identityVerification: "identity_verification",
}

@doc("The file's status.")
@example(FileStatus.pending)
enum FileStatus {
  pending,
  approved,
  rejected,
}
