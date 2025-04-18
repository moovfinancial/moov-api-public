import "@typespec/http";
import "@typespec/openapi3";
import "@typespec/versioning";
import "../common/examples.id.tsp";
import "./models.terminalapplications.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace MoovAPI;

@doc("ID of the merchant account.")
@format("uuid")
@example("76d4c8a0-1f2b-4e3b-8f5c-7a9e1b2c3d4e")
scalar MerchantAccountID extends string;

@doc("Describes a request to link an account with a terminal application.")
model LinkAccountTerminalApplication {
  terminalApplicationID: TerminalApplicationID;
}

@doc("Describes a list of account terminal applications.")
@example(#[exampleTerminalApplication])
model AccountTerminalApplicationList is Array<TerminalApplication>;

// Errors
model AccountTerminalApplicationError {
  terminalApplicationID?: string;
}
