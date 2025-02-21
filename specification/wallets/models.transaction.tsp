import "@typespec/http";
import "../common/models.parameter.tsp";

using TypeSpec.Http;

namespace MoovAPI;

@format("uuid")
scalar WalletTransactionID extends string;

enum WalletTransactionType {
  accountFunding: "account-funding",
  achReversal: "ach-reversal",
  autoSweep: "auto-sweep",
  cardPayment: "card-payment",
  cardDecline: "card-decline",
  cardReversal: "card-reversal",
  cashOut: "cash-out",
  dispute: "dispute",
  disputeReversal: "dispute-reversal",
  facilitatorFee: "facilitator-fee",
  issuingRefund: "issuing-refund", // @TODO: LEDG-2661 deprecate issuing v1 transaction types
  issuingTransaction: "issuing-transaction",
  issuingTransactionAdjustment: "issuing-transaction-adjustment", // @TODO: LEDG-2661 deprecate issuing v1 transaction types
  issuingAuthHold: "issuing-auth-hold",
  issuingAuthRelease: "issuing-auth-release",
  issuingDecline: "issuing-decline", // @TODO: LEDG-2661 deprecate issuing v1 transaction types
  moovFee: "moov-fee",
  payment: "payment",
  payout: "payout",
  refund: "refund",
  refundFailure: "refund-failure",
  rtpFailure: "rtp-failure",
  topUp: "top-up",
  walletTransfer: "wallet-transfer",
  adjustment: "adjustment",
}

enum WalletTransactionSourceType {
  transfer: "transfer",
  dispute: "dispute",
  issuingCardTransaction: "issuing-card-transaction",
  issuingAuthorization: "issuing-authorization",
  sweep: "sweep",
  adjustment: "adjustment",
}

enum WalletTransactionStatus {
  pending,
  completed,
  canceled,
  failed,
}

@doc("A transaction that funds or deducts from the wallet.")
model WalletTransaction {
  walletID: WalletID;
  transactionID: WalletTransactionID;
  transactionType: WalletTransactionType;
  sourceType: WalletTransactionSourceType;

  @doc("The ID of the Moov object to which this transaction is related.")
  @format("uuid")
  sourceID: string;

  status: WalletTransactionStatus;

  @doc("Detailed description of the transaction.")
  memo: string;

  createdOn: utcDateTime;
  completedOn?: utcDateTime;
  currency: Currency;

  @doc("The total transaction amount. The amount is in the smallest unit of the specified currency. In USD this is cents, for example, $12.04 is 1204 and $0.99 is 99.")
  grossAmount: int64;

  @doc("The total transaction amount. Same as `grossAmount`, but a decimal-formatted numerical string that represents up to 9 decimal place precision. In USD for example, 12.987654321 is $12.987654321 and 0.9987634521 is $0.9987634521.")
  @pattern(Decimal9StringPattern)
  grossAmountDecimal: string;

  @doc("Total fees paid for the transaction. The value is in the smallest unit of the specified currency. In USD this is cents, for example, $12.04 is 1204 and $0.99 is 99.")
  fee: int64;

  @doc("The IDs of the fees paid for the transaction.")
  feeIDs?: string[];

  @doc("Total fees paid for the transaction. Same as `fee`, but a decimal-formatted numerical string that represents up to 9 decimal place precision. In USD for example, 12.987654321 is $12.987654321 and 0.9987634521 is $0.9987634521.")
  @pattern(Decimal9StringPattern)
  feeDecimal: string;

  @doc("Net amount is the gross amount less fees paid, and the amount that affects the wallet's balance. The amount is in the smallest unit of the specified currency. In USD this is cents, for example, $12.04 is 1204 and $0.99 is 99.")
  netAmount: int64;

  @doc("Net amount is the gross amount less fees paid, and the amount that affects the wallet's balance. Same as `netAmount`, but a decimal-formatted numerical string that represents up to 9 decimal place precision. In USD for example, 12.987654321 is $12.987654321 and 0.9987634521 is $0.9987634521.")
  @pattern(Decimal9StringPattern)
  netAmountDecimal: string;

  @doc("The wallet's total available balance after recording a completed transaction. The value is in the smallest unit of the specified currency. In USD this is cents, for example, $12.04 is 1204 and $0.99 is 99.")
  availableBalance?: int64;

  @doc("The wallet's total available balance after recording a completed transaction. Same as `availableBalance`, but a decimal-formatted numerical string that represents up to 9 decimal place precision. In USD for example, 12.987654321 is $12.987654321 and 0.9987634521 is $0.9987634521.")
  @pattern(Decimal9StringPattern)
  availableBalanceDecimal?: string;

  sweepID?: SweepID;
}

model ListTransactionsQuery {
  ...Pagination;

  @path
  walletID: WalletID;

  @doc("""
    Optional parameter to filter by transaction type.
    """)
  @query
  transactionType?: WalletTransactionType;

  @doc("""
    Optional parameter to filter by source type (i.e. transfer, dispute, issuing-transaction).
    """)
  @query
  sourceType?: WalletTransactionSourceType;

  @doc("""
    Optional parameter to filter by source ID.
    """)
  @format("uuid")
  @query
  sourceID?: string;

  @doc("""
    Optional parameter to filter by status (`pending` or `completed`).
    """)
  @query
  status?: WalletTransactionStatus;

  @doc("""
    Optional date-time which inclusively filters all transactions created after this date-time.  
    """)
  @query
  createdStartDateTime?: utcDateTime;

  @doc("""
    Optional date-time which exclusively filters all transactions created before this date-time.
    """)
  @query
  createdEndDateTime?: utcDateTime;

  @doc("""
    Optional date-time which inclusively filters all transactions completed after this date-time.
    """)
  @query
  completedStartDateTime?: utcDateTime;

  @doc("""
    Optional date-time which exclusively filters all transactions completed before this date-time.
    """)
  @query
  completedEndDateTime?: utcDateTime;

  @doc("""
    Optional ID to filter for transactions accrued in a sweep.
    """)
  @query
  sweepID?: SweepID;
}
