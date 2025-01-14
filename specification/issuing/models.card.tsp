import "../accounts/models.profile.tsp";
import "../cards/models.card.tsp";

namespace MoovAPI;

model IssuedCard {
  @format("uuid")
  issuedCardID: string;

  brand: CardBrand;
  lastFourCardNumber: string;
  expiration: CardExpiration;
  authorizedUser: AuthorizedUser;

  @doc("Optional descriptor for the card.")
  memo?: string;

  @doc("Unique identifier for the wallet funding the card.")
  fundingWalletID: string;

  state: IssuedCardState;
  formFactor: IssuedCardFormFactor;
  controls?: IssuingControls;
  createdOn: utcDateTime;
}

@doc("The full details of an issued card, including PAN and CVV.")
model FullIssuedCard {
  ...IssuedCard;

  @doc("The issued card's Primary Account Number (PAN)")
  @minLength(16)
  @maxLength(19)
  pan: string;

  @doc("The issued card's 3- or 4-digit Card Verification Value (CVV).")
  @minLength(3)
  @maxLength(4)
  cvv: string;
}

model RequestCard {
  @format("uuid")
  fundingWalletID: string;

  authorizedUser: CreateAuthorizedUser;
  formFactor: IssuedCardFormFactor;

  @doc("An optional descriptive name for the card.")
  memo?: string;

  expiration?: CardExpiration;
  controls?: IssuingControls;
}

model RequestCardError {
  fundingWalletID?: string;
  formFactor?: string;
  authorizedUser?: CreateAuthorizedUserError;
  memo?: string;
  expiration?: CardExpirationError;
  controls?: IssuingControlsError;
}

model UpdateIssuedCard {
  state?: IssuedCardState;
  memo?: string;
  authorizedUser?: CreateAuthorizedUser;
}

model UpdateIssuedCardError {
  state?: string;
  memo?: string;
  authorizedUser?: CreateAuthorizedUserError;
}

@doc("Fields for identifying an authorized individual.")
model AuthorizedUser {
  firstName: string;
  lastName: string;
}

@doc("Fields for identifying an authorized individual.")
model CreateAuthorizedUser {
  firstName: string;
  lastName: string;
  birthDate?: BirthDate;
}

model CreateAuthorizedUserError {
  firstName?: string;
  lastName?: string;
  birthDate?: BirthDateError;
}

model IssuingControls {
  @doc("Indicates if the card is single-use. If true, the card closes after the first authorization.")
  singleUse?: boolean;

  @doc("Sets the spending limit per time interval. Only one limit per interval is supported.")
  velocityLimits?: IssuingVelocityLimit[];
}

@example(#{
  velocityLimits: #{
    `0`: #{
      amount: "must be no less than 1",
      interval: "must be a valid value",
    },
  },
})
model IssuingControlsError {
  velocityLimits?: Record<IssuingVelocityLimitError>;
}

model IssuingVelocityLimit {
  @doc("The maximum amount in cents that can be spent in a given interval.")
  @example(10000)
  amount: int64;

  interval: IssuingIntervalLimit;
}

model IssuingVelocityLimitError {
  amount?: string;
  interval?: string;
}

@doc("Specifies the time frame for the velocity limit. Currently supports only per-transaction limits.")
enum IssuingIntervalLimit {
  perTransaction: "per-transaction",
}

@doc("Specifies the type of spend card to be issued. Presently supports virtual only, providing a digital number without a physical card.")
enum IssuedCardFormFactor {
  virtual,
}

@doc("""
  The `state` represents the operational status of an issued card. A card can only approve incoming authorizations if it is in an active state.
  
  - `active`: The card is operational and approves authorizations. Generally becomes active shortly after card creation.
  - `inactive`: The card cannot approve authorizations. This is currently a temporary state assigned post-creation during the activation process.
  - `closed`: The card is permanently deactivated and cannot approve authorizations. A card can be closed by request or when it expires.
  - `pending-verification`: Awaiting additional authorized user verification before the card can be activated.
  """)
enum IssuedCardState {
  active: "active",
  inactive: "inactive",
  pendingVerification: "pending-verification",
  closed: "closed",
}
