import "./models.wallet.tsp";
import "../paymentmethods/models.paymentmethod.tsp";

namespace MoovAPI;

@format("uuid")
scalar SweepConfigID extends string;

model CreateSweepConfig {
  walletID: WalletID;
  status: SweepConfigStatus;
  pushPaymentMethodID: PaymentMethodID;
  pullPaymentMethodID: PaymentMethodID;
  statementDescriptor?: SweepStatementDescriptor;

  @pattern(Decimal2StringPattern)
  minimumBalance?: string;
}

model CreateSweepConfigError {
  walletID?: string;
  status?: string;
  pushPaymentMethodID?: string;
  pullPaymentMethodID?: string;
  statementDescriptor?: string;
  minimumBalance?: string;
}

model PatchSweepConfig {
  status?: SweepConfigStatus | null;
  pushPaymentMethodID?: PaymentMethodID | null;
  pullPaymentMethodID?: PaymentMethodID | null;
  statementDescriptor?: SweepStatementDescriptor | null;

  @pattern(Decimal2StringPattern)
  minimumBalance?: string | null;
}

model PatchSweepConfigError {
  status?: string;
  pushPaymentMethodID?: string;
  pullPaymentMethodID?: string;
  statementDescriptor?: string;
  minimumBalance?: string;
}

enum SweepConfigStatus {
  enabled,
  disabled,
}

@doc("""
  The payment method used to push or pull funds to a bank account.
  The push payment method can only be ach-credit-standard or ach-credit-same-day. The pull payment method can only be ach-debit-fund.
  """)
model SweepConfigPaymentMethod {
  paymentMethodID: PaymentMethodID;
  disabledOn?: utcDateTime;
}

model SweepConfig {
  sweepConfigID: SweepConfigID;
  walletID: WalletID;
  status: SweepConfigStatus;
  pushPaymentMethod: SweepConfigPaymentMethod;
  pullPaymentMethod: SweepConfigPaymentMethod;

  @doc("An optional field to specify an amount to maintain in the wallet. This is a decimal-formatted numerical string that represents up to 2 decimal place precision. In USD for example, 12.34 is $12.34 and 0.99 is $0.99. If not supplied, the default is 0.00.")
  @pattern(Decimal2StringPattern)
  minimumBalance?: string;

  statementDescriptor?: SweepStatementDescriptor;

  @doc("An array of fields that are locked. To request updates, please contact Moov support.")
  lockedFields?: string[];

  createdOn: utcDateTime;
  updatedOn: utcDateTime;
}
