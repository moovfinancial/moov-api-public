import "./models.transaction.tsp";
import "../common/examples.id.tsp";
import "../common/examples.time.tsp";
import "../money/models.amount.tsp";

namespace MoovAPI;

const ExampleWalletTransactionPending: WalletTransaction = #{
  walletID: ExampleID,
  transactionID: ExampleID,
  transactionType: WalletTransactionType.cardPayment,
  sourceType: WalletTransactionSourceType.transfer,
  sourceID: ExampleID,
  status: WalletTransactionStatus.pending,
  memo: "An example pending card payment",
  createdOn: ExampleUtcDateTime,
  currency: "USD",
  grossAmount: 2000,
  grossAmountDecimal: "20.00",
  fee: 30,
  feeDecimal: "0.30",
  netAmount: 1970,
  netAmountDecimal: "19.70",
};

const ExampleWalletTransactionCompleted: WalletTransaction = #{
  walletID: ExampleID,
  transactionID: ExampleID,
  transactionType: WalletTransactionType.cardPayment,
  sourceType: WalletTransactionSourceType.transfer,
  sourceID: ExampleID,
  status: WalletTransactionStatus.completed,
  memo: "An example completed card payment",
  createdOn: ExampleUtcDateTime,
  completedOn: ExampleUtcDateTime,
  currency: "USD",
  grossAmount: 2000,
  grossAmountDecimal: "20.00",
  fee: 30,
  feeDecimal: "0.30",
  netAmount: 1970,
  netAmountDecimal: "19.70",
  availableBalance: 10000,
  availableBalanceDecimal: "100.00",
};
