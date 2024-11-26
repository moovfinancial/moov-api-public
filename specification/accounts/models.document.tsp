namespace MoovAPI;

model Document {
  @format("uuid")
  @example("e07e83e8-9429-4e99-ac99-c941f719eb39")
  documentID: string;

  type: DocumentType;

  @doc("The document's MIME type.")
  @example("application/pdf")
  contentType: string;

  @doc("Optional array of errors encountered during automated parsing.")
  parseErrors?: string[];

  @example(utcDateTime.fromISO("2024-05-06T12:20:38.184Z"))
  uploadedAt: utcDateTime;
}

@doc("Types of documents that can be uploaded.")
@example(DocumentType.BankStatement)
enum DocumentType {
  DriversLicense,
  Passport,
  UtilityBill,
  BankStatement,
}
