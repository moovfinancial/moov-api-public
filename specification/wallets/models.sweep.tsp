import "../money/models.amount.tsp";
import "../paymentmethods/models.paymentmethod.tsp";
import "../transfers/models.transfer.tsp";

namespace MoovAPI;

@format("uuid")
scalar SweepID extends string;

@doc("""
  The text that appears on the banking statement. The default descriptor is a 10 character ID if an override is not set in the sweep configs statementDescriptor.
  """)
@minLength(4)
@maxLength(10)
scalar SweepStatementDescriptor extends string;

enum SweepStatus {
  accruing: "accruing",
  actionRequired: "action-required",
  canceled: "canceled",
  closed: "closed",
  failed: "failed",
  paid: "paid",
}

model Sweep {
  sweepID: SweepID;
  status: SweepStatus;

  @doc("The total net amount of wallet transactions accrued in the sweep.")
  @pattern(Decimal9StringPattern)
  accruedAmount: string;

  @doc("Amount remaining in the wallet after the sweep transfer completes.")
  @pattern(Decimal9StringPattern)
  residualBalance?: string;

  currency: Currency;

  @doc("The date-time the sweep began accruing transactions.")
  accrualStartedOn: utcDateTime;

  @doc("The date-time the sweep stopped accruing transactions.")
  accrualEndedOn?: utcDateTime;

  pushPaymentMethodID?: PaymentMethodID;
  pullPaymentMethodID?: PaymentMethodID;

  @format("uuid")
  transferID?: string;

  @doc("Amount that is transferred.")
  @pattern(Decimal9StringPattern)
  transferAmount?: string;

  statementDescriptor?: SweepStatementDescriptor;
}
