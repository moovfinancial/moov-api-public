import "../money/models.amount.tsp";

namespace MoovAPI;

@format("uuid")
scalar WalletID extends string;

@doc("A Moov wallet to store funds for transfers.")
model Wallet {
  walletID: WalletID;
  availableBalance: WalletAvailableBalance;
}

model WalletAvailableBalance is Amount {
  @pattern(Decimal9StringPattern)
  valueDecimal: string;
}
