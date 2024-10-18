import "@typespec/http";
import "@typespec/openapi3";
import "@typespec/versioning";
import "./models.profile.tsp";
import "./models.verification.tsp";
import "./models.settings.tsp";
import "../capabilities/models.common.capability.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace MoovAPI.Accounts;

model CreateAccount {
  mode: Mode;
  accountType: AccountType;
  profile: CreateProfile;

  @doc("Free-form key-value pair list. Useful for storing information that is not captured elsewhere.")
  metadata?: Record<string>;

  @oneOf
  termsOfService?: TermsOfServiceToken | ManualTermsOfService;

  @doc("Optional alias from a foreign/external system which can be used to reference this resource.")
  @maxLength(64)
  foreignID?: string;

  customerSupport?: CustomerSupport;
  settings?: Settings;
  capabilities?: CommonCapabilities.CapabilityID[];
}

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

  @doc("Free-form key-value pair list. Useful for storing information that is not captured elsewhere.")
  metadata?: Record<string>;

  termsOfService?: TermsOfService;
  capabilities?: Capability[];
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

@doc("The operating mode for an account.")
@example(Mode.Production)
enum Mode {
  @doc("Sandbox mode is used to develop and test API integrations without actually moving money.")
  Sandbox: "sandbox",

  @doc("Production mode is used for real money movement in a production environment.")
  Production: "production",
}

@doc("The type of entity represented by this account.")
@example(AccountType.Business)
enum AccountType {
  Individual: "individual",
  Business: "business",
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
model Capability {
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
  address?: string;
  website?: url;
}

model PhoneNumber {
  @example("8185551212")
  @maxLength(10)
  number?: string;

  @example("1")
  @maxLength(1)
  countryCode?: string;
}

model Address {
  @example("123 Main Street")
  @maxLength(60)
  addressLine1: string;

  @example("Apt 302")
  @maxLength(32)
  addressLine2?: string;

  @example("Boulder")
  @maxLength(24)
  city: string;

  @example("CO")
  @maxLength(2)
  stateOrProvince: string;

  @example("80301")
  @maxLength(5)
  postalCode: string;

  @example("US")
  @maxLength(2)
  country: string;
}

@example("jordan.lee@classbooker.dev")
@format("email")
@maxLength(255)
scalar Email extends string;

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
  @example(AccountType.Business)
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
  @example(CommonCapabilities.CapabilityID.Transfers)
  @query
  capability?: CommonCapabilities.CapabilityID;

  @doc("""
      Filter connected accounts by the capability.
    """)
  @example(CommonCapabilities.CapabilityStatus.Enabled)
  @query
  capabilityStatus?: CommonCapabilities.CapabilityStatus;
}
