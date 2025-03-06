import "@typespec/http";
import "@typespec/openapi3";
import "@typespec/versioning";
import "../common/examples.id.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace MoovAPI;

@doc("ID of the terminal application.")
@format("uuid")
@example(ExampleID)
scalar TerminalApplicationID extends string;

@doc("Status of the terminal application.")
@example(TerminalApplicationStatus.enabled)
enum TerminalApplicationStatus {
  undefined,
  pending,
  enabled,
  disabled,
}

@doc("Platform of the terminal application.")
@example(TerminalApplicationPlatform.ios)
enum TerminalApplicationPlatform {
  undefined,
  ios,
  android,
}

const exampleTerminalApplication = #{
  terminalApplicationID: ExampleID,
  status: TerminalApplicationStatus.enabled,
  platform: TerminalApplicationPlatform.ios,
  appBundleID: "com.example.app",
  packageName: "com.example.app",
  sha256Digest: "1234567890",
  versionCode: "1.0.0",
};

@doc("Describes a terminal application.")
@example(exampleTerminalApplication)
model TerminalApplication {
  terminalApplicationID: TerminalApplicationID;
  status: TerminalApplicationStatus;
  platform: TerminalApplicationPlatform;

  @doc("The app bundle identifier of the terminal application. Will be returned if platform is `ios`.")
  appBundleID?: string;

  @doc("The app package name of the terminal application. Will be returned if platform is `android`.")
  packageName?: string;

  @doc("The app version of the terminal application Will be returned if platform is `android`.")
  sha256Digest?: string;

  @doc("The app version of the terminal application Will be returned if platform is `android`.")
  versionCode?: string;
}

const exampleCreateTerminalApplication = #{
  platform: TerminalApplicationPlatform.ios,
  appBundleID: "com.example.app",
  packageName: "com.example.app",
  sha256Digest: "1234567890",
  versionCode: "1.0.0",
};

@doc("Describes a create terminal application request.")
@example(exampleCreateTerminalApplication)
model CreateTerminalApplication {
  platform: TerminalApplicationPlatform;

  @doc("The app bundle identifier of the terminal application. Required if platform is `ios`.")
  appBundleID?: string;

  @doc("The app package name of the terminal application. Required if platform is `android`.")
  packageName?: string;

  @doc("The app version of the terminal application. Required if paltform is `android`.")
  sha256Digest?: string;

  @doc("The app version of the terminal application. Required if platform is `android`.")
  versionCode?: string;
}

// Errors
model TerminalApplicationError {
  platform?: string;
  appBundleID?: string;
  packageName?: string;
  sha256Digest?: string;
  versionCode?: string;
}
