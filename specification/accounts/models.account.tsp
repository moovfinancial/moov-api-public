import "@typespec/http";
import "@typespec/openapi3";
import "@typespec/versioning";
import "./examples.account.tsp";
import "./models.mode.tsp";
import "./models.profile.tsp";
import "./models.verification.tsp";
import "./models.settings.tsp";
import "../capabilities/models.capability.tsp";
import "../common/models.address.tsp";
import "../common/models.email.tsp";
import "../common/models.metadata.tsp";
import "../common/models.phone.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace MoovAPI;

@example(
  ExampleCreateIndividualAccount,
  #{ title: "Minimal individual account" }
)
@example(ExampleCreateBusinessAccount, #{ title: "Minimal business account" })
model CreateAccount {
  accountType: AccountType;
  profile: CreateProfile;
  metadata?: Metadata;

  @oneOf
  termsOfService?: TermsOfServiceToken | ManualTermsOfService;

  @doc("Optional alias from a foreign/external system which can be used to reference this resource.")
  @maxLength(64)
  foreignID?: string;

  customerSupport?: CustomerSupport;
  settings?: Settings;
  capabilities?: CapabilityID[];
}

model CreateAccountError {
  accountType?: string;
  profile?: CreateProfileError;
  metadata?: string;
  termsOfService?: TermsOfServiceError;
  foreignID?: string;
  customerSupport?: CustomerSupportError;
  settings?: CreateAccountSettings;
  capabilities?: Record<string>;
}

model CreateAccountSettings {
  cardPayment?: {
    statementDescriptor?: string;
  };
  achPayment?: {
    companyName?: string;
  };
}

@example(ExampleIndividualAccount, #{ title: "Minimal individual account" })
@example(ExampleBusinessAccount, #{ title: "Minimal business account" })
model Account {
  @doc("Unique identifier for this account.")
  @format("uuid")
  @example("c520f1b9-0ba7-42f5-b977-248cdbe41c69")
  accountID: string;

  mode: Mode;
  accountType: AccountType;

  @example("Whole Body Fitness")
  @maxLength(64)
  displayName: string;

  profile: Profile;
  metadata?: Metadata;
  termsOfService?: TermsOfService;
  capabilities?: AccountCapability[];
  verification: Verification;

  @doc("Optional alias from a foreign/external system which can be used to reference this resource.")
  @maxLength(64)
  foreignID?: string;

  customerSupport?: CustomerSupport;
  settings?: Settings;

  @example(utcDateTime.fromISO("2024-05-06T12:20:38.184Z"))
  createdOn: utcDateTime;

  @example(utcDateTime.fromISO("2024-05-06T12:20:38.184Z"))
  updatedOn: utcDateTime;

  @example(utcDateTime.fromISO("2024-05-06T12:20:38.184Z"))
  disconnectedOn?: utcDateTime;
}

@doc("Describes the fields available when patching a Moov account.")
model PatchAccount {
  profile?: PatchProfile;
  metadata?: Metadata | null;

  @oneOf
  termsOfService?: TermsOfServiceToken | ManualTermsOfService;

  foreignID?: string;
  customerSupport?: CustomerSupport | null;
  settings?: CreateAccountSettings;
}

model PatchAccountError {
  profile?: CreateProfileError;
  metadata?: string;
  termsOfService?: TermsOfServiceError;
  foreignID?: string;
  customerSupport?: CustomerSupportError;
  settings?: CreateAccountSettings;
}

@doc("The type of entity represented by this account.")
@example(AccountType.business)
enum AccountType {
  individual,
  business,
}

model TermsOfServiceError {
  token?: string;
  manual?: {
    acceptedDate?: string;
    acceptedDomain?: string;
    acceptedIP?: string;
    acceptedUserAgent?: string;
  };
}

@doc("An encrypted value used to record acceptance of Moov's Terms of Service.")
model TermsOfServiceToken {
  @example("kgT1uxoMAk7QKuyJcmQE8nqW_HjpyuXBabiXPi6T83fUQoxsyWYPcYzuHQTqrt7YRp4gCwyDQvb6U5REM9Pgl2EloCe35t-eiMAbUWGo3Kerxme6aqNcKrP_6-v0MTXViOEJ96IBxPFTvMV7EROI2dq3u4e-x4BbGSCedAX-ViAQND6hcreCDXwrO6sHuzh5Xi2IzSqZHxaovnWEboaxuZKRJkA3dsFID6fzitMpm2qrOh4")
  token: string;
}

@doc("Describes the acceptance of the Terms of Service. All data is required, and must be from the user.")
model ManualTermsOfService {
  @doc("The date and time the terms of service were accepted.")
  acceptedDate: utcDateTime;

  @doc("The IP address from which the terms of service were accepted.")
  @format("ipv4")
  @example("172.217.2.46")
  acceptedIP: string;

  @doc("The user-agent of the user making the request.")
  @example("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.71 Safari/537.36")
  @maxLength(255)
  acceptedUserAgent: string;

  acceptedDomain: url;
}

model ManualToSError {
  acceptedDate?: string;
  acceptedDomain?: string;
  acceptedIP?: string;
  acceptedUserAgent?: string;
}

@doc("Describes the acceptance of the Terms of Service.")
model TermsOfService {
  @doc("The date and time the terms of service were accepted.")
  acceptedDate: utcDateTime;

  @doc("The IP address from which the terms of service were accepted.")
  @format("ipv4")
  @example("172.217.2.46")
  acceptedIP: string;
}

@doc("Describes an action or set of actions that an account is permitted to perform.")
model AccountCapability {
  capability: string;
  status: string;
}

@doc("""
  User-provided information that can be displayed on credit card transactions for customers to use when
  contacting a customer support team. This data is only allowed on a business account.
  """)
model CustomerSupport {
  phone?: PhoneNumber;
  email?: Email;
  address?: Address;
  website?: url;
}

model CustomerSupportError {
  phone?: PhoneNumberError;
  email?: string;
  address?: AddressError;
  website?: string;
}

model AccountsQuery {
  @doc("""
    Filter connected accounts by name.
    
    If provided, this query will attempt to find matches against the following Account and Profile fields:
    <ul>
      <li>Account `displayName`</li>
      <li>Individual Profile `firstName`, `middleName`, and `lastName`</li>
      <li>Business Profile `legalBusinessName`</li>
    </ul>
    """)
  @example("Frank")
  @query
  name?: string;

  @doc("""
      Filter connected accounts by email address.
    
      Provide the full email address to filter by email.
    """)
  @example("someone@moov.io")
  @query
  email?: string;

  @doc("""
      Filter connected accounts by AccountType.
    
      If the `type` parameter is used in combination with `name`, only the corresponding type's name fields will
      be searched. For example, if `type=business` and `name=moov`, the search will attempt to find matches against
      the display name and Business Profile name fields (`legalBusinessName`, and `doingBusinessAs`).
    """)
  @example(AccountType.business)
  @query
  type?: AccountType;

  @doc("""
      Serves as an optional alias from a foreign/external system which can be used to reference this resource.
    """)
  @example("4528aba-b9a1-11eb-8529-0242ac13003")
  @query
  foreignID?: string;

  @doc("""
    Filter disconnected accounts.
    
    If true, the response will include disconnected accounts.
    """)
  @example(true)
  @query
  includeDisconnected?: boolean;

  @doc("""
      Filter connected accounts by the capability.
    """)
  @example(CapabilityID.transfers)
  @query
  capability?: CapabilityID;

  @doc("""
      Filter connected accounts by the capability.
    """)
  @example(CapabilityStatus.enabled)
  @query
  capabilityStatus?: CapabilityStatus;
}

enum AccountWaitFor {
  connection,
}
