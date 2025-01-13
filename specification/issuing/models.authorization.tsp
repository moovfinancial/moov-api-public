import "@typespec/http";
import "../common/models.parameter.tsp";
import "../money/models.amount.tsp";

using TypeSpec.Http;

namespace MoovAPI;

model IssuedCardAuthorization {
  @format("uuid")
  authorizationID: string;

  @format("uuid")
  issuedCardID: string;

  @format("uuid")
  fundingWalletID: string;

  network: CardIssuingNetwork;
  authorizedAmount: SignedDecimalString;
  status: IssuingAuthorizationStatus;
  merchantData: IssuingMerchantData;
  createdOn: utcDateTime;

  @doc("List of card transaction IDs associated with this authorization.")
  cardTransactions?: string[];
}

model IssuingMerchantData {
  @doc("External identifier used to identify the merchant with the card brand.")
  networkID?: string;

  @doc("Name of the merchant.")
  @example("Whole Body Fitness")
  name?: string;

  @doc("The merchant's location.")
  @example("San Francisco")
  city?: string;

  @doc("Two-letter country code.")
  @example("US")
  country?: string;

  @doc("The merchant's five-digit postal code.")
  @example("94107")
  postalCode?: string;

  @doc("The merchant's two-letter state abbreviation.")
  @example("CA")
  state?: string;

  @doc("The Merchant Category Code.")
  @example("7298")
  mcc?: string;
}

model ListIssuingAuthorizationsQuery {
  ...Pagination;

  @doc("Optional ID of the issued card to filter results.")
  @format("uuid")
  @query
  issuedCardID?: string;

  @doc("Optional date-time which inclusively filters all authorizations created after this date-time.")
  @query
  startDateTime?: utcDateTime;

  @doc("Optional date-time which exclusively filters all authorizations created before this date-time.")
  @query
  endDateTime?: utcDateTime;

  @doc("Optional, comma-separated statuses of the authorization to filter results.")
  @example(#[
    IssuingAuthorizationStatus.declined,
    IssuingAuthorizationStatus.expired
  ])
  @query
  statuses?: IssuingAuthorizationStatus[];
}

model IssuedCardAuthorizationEvent {
  @doc("The identifier for this event. Use the `eventType` field to determine what resource is identified by this ID (`authorization`, `reversal`, etc.).")
  @format("uuid")
  eventID: string;

  eventType: IssuedCardEventType;
  amount: SignedDecimalString;
  result: IssuedCardAuthorizationEventResult;
  createdOn: utcDateTime;
}

@doc("The name of the network a card transaction is routed through.")
enum CardIssuingNetwork {
  discover,
  shazam,
  visa,
}

@doc("Status of a card issuing authorization.")
enum IssuingAuthorizationStatus {
  pending,
  declined,
  canceled,
  cleared,
  expired,
}

@doc("The type of event that occurred on the card.")
enum IssuedCardEventType {
  authorization: "authorization",
  reversal: "reversal",
  authorizationAdvice: "authorization-advice",
  authorizationExpiration: "authorization-expiration",
  authorizationIncremental: "authorization-incremental",
  clearing: "clearing",
}

@doc("The result of an event.")
enum IssuedCardAuthorizationEventResult {
  approved,
  declined,
  processed,
}
