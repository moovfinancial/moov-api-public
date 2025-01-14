import "@typespec/http";
import "./models.authorization.tsp";
import "../common/models.parameter.tsp";
import "../money/models.amount.tsp";

using TypeSpec.Http;

namespace MoovAPI;

model ListIssuingTransactionsQuery {
  ...Pagination;

  @doc("Optional ID of the issued card to filter results.")
  @format("uuid")
  @query
  issuedCardID?: string;

  @doc("Optional date-time which inclusively filters all card transactions created after this date-time.")
  @query
  startDateTime?: utcDateTime;

  @doc("Optional date-time which exclusively filters all card transactions created before this date-time.")
  @query
  endDateTime?: utcDateTime;
}

model IssuedCardTransaction {
  @format("uuid")
  cardTransactionID: string;

  @format("uuid")
  issuedCardID: string;

  @format("uuid")
  fundingWalletID: string;

  amount: SignedDecimalString;

  @format("uuid")
  authorizationID?: string;

  authorizedOn: utcDateTime;
  merchantData: IssuingMerchantData;
  createdOn: utcDateTime;
}
