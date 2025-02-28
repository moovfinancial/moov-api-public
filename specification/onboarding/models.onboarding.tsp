import "../accounts/models.account.tsp";
import "../accounts/models.mode.tsp";
import "../auth/models.scope.tsp";
import "../capabilities/models.capability.tsp";
import "../common/models.error.tsp";

namespace MoovAPI;

@doc("""
  A unique code that identifies an onboarding invite.
  """)
@example("N1IA5eWYNh")
scalar OnboardingInviteCode extends string;

@doc("Request to create an onboarding invite.")
model OnboardingInviteRequest {
  @doc("Optional URL to redirect the user to after they complete the onboarding process.")
  @format("uri")
  returnURL?: string;

  @doc("Optional URL to your organization's terms of service.")
  @format("uri")
  termsOfServiceURL?: string;

  @doc("""
      List of [scopes](https://docs.moov.io/api/authentication/scopes/) you request to use on this
      account. These values are used to determine what can be done with the account onboarded.
    """)
  @minItems(1)
  @example(#[ApplicationScope.accountsRead])
  scopes: ApplicationScope[];

  @doc("""
      List of [capabilities](https://docs.moov.io/guides/accounts/capabilities/) you intend to request for this
      account. These values are used to determine what information to collect from the user during onboarding.
    """)
  @minItems(1)
  @example(#[CapabilityID.transfers])
  capabilities: CapabilityID[];

  @doc("List of fee plan codes to assign the account created by the invitee.")
  @minItems(1)
  @example(#["merchant-direct"])
  feePlanCodes: string[];

  prefill?: CreateAccount;
}

model OnboardingInviteError {
  returnURL?: string;
  termsOfServiceURL?: string;
  scopes?: ArrayValidationError;
  capabilities?: ArrayValidationError;
  feePlanCodes?: ArrayValidationError;
}

model OnboardingInvite {
  code: OnboardingInviteCode;

  @doc("A unique URL, including the invite code, that the recipient can follow to redeem the invitation.")
  @format("uri")
  link: string;

  @doc("The scopes requested by the inviter.")
  returnURL?: string;

  @doc("The terms of service URL set by the inviter.")
  termsOfServiceURL?: string;

  @doc("""
    List of [scopes](https://docs.moov.io/api/authentication/scopes/) you request to use on this
    account. These values are used to determine what can be done with the account onboarded.
    """)
  @minItems(1)
  @example(#[ApplicationScope.accountsRead])
  scopes: ApplicationScope[];

  @doc("""
      List of [capabilities](https://docs.moov.io/guides/accounts/capabilities/) you intend to request for this
      account. These values are used to determine what information to collect from the user during onboarding.
    """)
  @minItems(1)
  @example(#[CapabilityID.transfers])
  capabilities: CapabilityID[];

  @doc("List of fee plan codes to assign the account created by the invitee.")
  @minItems(1)
  @example(#["merchant-direct"])
  feePlanCodes: string[];

  @doc("The account ID of the account that redeemed the invite.")
  @format("uuid")
  redeemedAccountID?: string;

  prefill?: CreateAccount;
  partner?: OnboardingPartnerAccount;
  createdOn: utcDateTime;
  revokedOn?: utcDateTime;
  redeemedOn?: utcDateTime;
}

@doc("The account that created the onboarding invite.")
model OnboardingPartnerAccount {
  @doc("The account ID of the partner that created the invite.")
  @format("uuid")
  accountID: string;

  accountMode: Mode;

  @doc("The name of the Moov account used to create the onboarding invite.")
  @example("Bob's Widgets")
  displayName: string;
}
