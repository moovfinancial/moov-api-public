import "@typespec/http";
import "./examples.dispute.tsp";
import "../common/models.parameter.tsp";
import "../money/models.amount.tsp";

using TypeSpec.Http;

namespace MoovAPI;

@doc("Details of a card transaction dispute.")
@example(ExampleDispute)
model Dispute {
  @format("uuid")
  disputeID: string;

  @format("uuid")
  merchantAccountID: string;

  amount: Amount;

  @doc("""
    Indicates the card network's category for the dispute. 
    
    These codes may differ between card brands. You can find more information on the code from the networkReasonDescription field.
    """)
  networkReasonCode: string;

  @doc("Provides detail on the card network's categorization of the dispute.")
  networkReasonDescription?: string;

  transfer: DisputeTransferDetails;
  respondBy: utcDateTime;
  status: DisputeStatus;
  phase: DisputePhase;
  createdOn: utcDateTime;
}

model DisputeTransferDetails {
  @doc("The disputed transfer's ID.")
  @format("uuid")
  transferID: string;
}

model DisputeListFilters {
  ...Pagination;

  @doc("Optional date-time parameter to filter all disputes created on and after the provided date and time.")
  @query
  startDateTime?: utcDateTime;

  @doc("Optional date-time parameter to filter all disputes created on and before the provided date and time.")
  @query
  endDateTime?: utcDateTime;

  @doc("Optional date-time which exclusively filters all disputes with respond by before this date-time.")
  @query
  respondStartDateTime?: utcDateTime;

  @doc("Optional date-time which exclusively filters all disputes with respond by before this date-time.")
  @query
  respondEndDateTime?: utcDateTime;

  @doc("Optional dispute status by which to filter the disputes.")
  @query
  status?: DisputeStatus;

  @doc("Optional parameter to filter by merchant account ID.")
  @format("uuid")
  @query
  merchantAccountID?: string;

  @doc("Optional parameter to filter by cardholder account ID.")
  @format("uuid")
  @query
  cardholderAccountID?: string;

  @doc("Optional parameter to filter by a comma separated list of dispute IDs.")
  @query
  disputeIDs?: string[];

  @doc("Optional parameter to filter by a comma separated list of transfer IDs.")
  @query
  transferIDs?: string[];

  @query
  orderBy?: string;
}

@doc("""
  The status of a particular dispute. 
  
  Read our [disputes guide](https://docs.moov.io/guides/money-movement/accept-payments/card-acceptance/disputes/#dispute-statuses) to learn what each status means.
  """)
enum DisputeStatus {
  responseNeeded: "response-needed",
  resolved: "resolved",
  underReview: "under-review",
  closed: "closed",
  accepted: "accepted",
  expired: "expired",
  won: "won",
  lost: "lost",
}

@doc("The phase of a dispute within the dispute lifecycle.")
enum DisputePhase {
  predispute: "pre-dispute",
  inquiry: "inquiry",
  chargeback: "chargeback",
  `unknown`: "unknown",
}
