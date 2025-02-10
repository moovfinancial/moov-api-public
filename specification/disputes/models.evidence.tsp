import "@typespec/http";
import "../common/models.header.tsp";

using TypeSpec.Http;

namespace MoovAPI;

model DisputeEvidenceMetadata {
  @format("uuid")
  evidenceID: string;

  @format("uuid")
  disputeID: string;

  mimeType: string;
  filename: string;
  size: int64;
  evidenceType: EvidenceType;

  @doc("The text submited as evidence.")
  text: string;

  createdOn: utcDateTime;
  updatedOn: utcDateTime;
}

model CreateEvidenceFile {
  @doc("""
    The file to upload as evidence. Valid types are [jpeg, tiff, pdf].
    
    The `Content-Type` header for this form part must be one of the following:
      - `image/jpeg`
      - `image/tiff`
      - `application/pdf`
    """)
  @format("binary")
  file: string;

  evidenceType: EvidenceType;
}

@doc("Details of a successfully uploaded evidence file.")
model EvidenceUploadResponse {
  @doc("The ID of the evidence.")
  @format("uuid")
  evidenceID: string;

  @doc("The ID of the dispute the evidence is associated with.")
  @format("uuid")
  disputeID: string;

  @doc("The name of the evidence file.")
  filename: string;

  @doc("The MIME type of the evidence file.")
  mimeType: string;

  @doc("The size of the evidence file.")
  size: int64;

  evidenceType: EvidenceType;

  @doc("The date and time the evidence was uploaded.")
  createdOn: utcDateTime;
}

model FileUploadValidationError {
  evidenceType?: string;
  file?: {
    filename?: string;
    mimeType?: string;
  };
}

model CreateEvidenceText {
  @doc("The text to associate with the dispute as evidence.")
  @maxLength(750)
  text: string;

  evidenceType: EvidenceType;
}

model UpdateEvidence is OptionalProperties<CreateEvidenceText>;

model EvidenceText {
  @format("uuid")
  evidenceID: string;

  @format("uuid")
  disputeID: string;

  evidenceType: EvidenceType;
  text: string;
  createdOn: utcDateTime;
}

enum EvidenceType {
  receipt: "receipt",
  proofOfDelivery: "proof-of-delivery",
  cancelationPolicy: "cancelation-policy",
  termsOfService: "terms-of-service",
  customerCommunication: "customer-communication",
  genericEvidence: "generic-evidence",
  coverLetter: "cover-letter",
  other: "other",
}

// This is defined here instead of Common because 201 is NOT one of our standard response codes.
// The disputes API is the only one I know of that uses it.

model EvidenceDataResponse {
  ...CommonResponseHeaders;
  @statusCode statusCode: HttpStatusOK;
  @header contentType: "application/pdf" | "image/jpeg" | "image/tiff";

  @body
  body: bytes;
}
