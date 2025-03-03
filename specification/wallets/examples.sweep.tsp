import "./models.sweep.tsp";
import "../common/examples.id.tsp";

namespace MoovAPI;

const ExampleAccruedSweep: Sweep = #{
  accruedAmount: "100.00",
  accrualStartedOn: ExampleUtcDateTime,
  currency: "USD",
  status: SweepStatus.accruing,
  sweepID: ExampleID,
};

const ExamplePaidSweep: Sweep = #{
  accruedAmount: "100.00",
  accrualStartedOn: ExampleUtcDateTime,
  accrualEndedOn: ExampleUtcDateTime,
  currency: "USD",
  pushPaymentMethodID: ExampleID,
  residualBalance: "0.00",
  statementDescriptor: "swp_012345",
  status: SweepStatus.paid,
  sweepID: ExampleID,
  transferAmount: "12.98",
  transferID: ExampleID,
};
