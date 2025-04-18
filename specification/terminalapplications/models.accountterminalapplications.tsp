import "@typespec/http";
import "@typespec/openapi3";
import "@typespec/versioning";
import "../common/examples.id.tsp";
import "./models.terminalapplications.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace MoovAPI;

const exampleAccountTerminalApplication = #{
  accountID: "12345678-1234-1234-1234-123456789012",
  terminalApplicationID: "9506dbf6-4208-44c3-ad8a-e4431660e1f2",
};

@doc("Describes an link between account and terminal application.")
@example(exampleAccountTerminalApplication)
model AccountTerminalApplication {
  @format("uuid")
  accountID: string;

  @format("uuid")
  terminalApplicationID: string;
}

const exampleLinkAccountTerminalApplication = #{
  terminalApplicationID: "9506dbf6-4208-44c3-ad8a-e4431660e1f2",
};

@doc("Describes a request to link an account with a terminal application.")
@example(exampleLinkAccountTerminalApplication)
model LinkAccountTerminalApplication {
  @format("uuid")
  terminalApplicationID: string;
}

@doc("Describes a list of account terminal applications.")
@example(#[exampleAccountTerminalApplication])
model AccountTerminalApplicationList is Array<AccountTerminalApplication>;

// Errors
model AccountTerminalApplicationError {
  terminalApplicationID?: string;
}
