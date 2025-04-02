import "@typespec/http";
import "@typespec/openapi3";
import "../common/models.header.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

model DisputeEvidenceResponse {
  @format("uuid")
  evidenceID: string;

  @format("uuid")
  disputeID: string;

  evidenceType: EvidenceType;

  @doc("For text evidence, the text submitted as evidence.")
  text?: string;

  @doc("For file evidence, the MIME type of the file.")
  mimeType?: string;

  @doc("For file evidence, the name of the file.")
  filename?: string;

  @doc("For file evidence, the size of the file.")
  size?: int64;

  createdOn: utcDateTime;
  updatedOn: utcDateTime;
}

model CreateEvidenceFile {
  @doc("""
    The file to upload as evidence. Valid types are [jpeg, tiff, pdf] with a limit of 4MB per file.
    
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

model EvidenceTextResponse {
  @format("uuid")
  evidenceID: string;

  @format("uuid")
  disputeID: string;

  evidenceType: EvidenceType;
  text: string;
  createdOn: utcDateTime;
}

model UpdateEvidence {
  evidenceType?: EvidenceType;

  @doc("If updating text evidence, the new text to associate with the dispute.")
  text?: string;
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
