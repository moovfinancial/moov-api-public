import "../money/models.amount.tsp";

namespace MoovAPI;

@doc("An adjustment to a wallet.")
model Adjustment {
  @format("uuid")
  adjustmentID: string;

  @format("uuid")
  walletID: string;

  amount: AmountDecimal;
  createdOn: utcDateTime;
}
