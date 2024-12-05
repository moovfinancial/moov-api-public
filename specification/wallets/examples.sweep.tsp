import "./models.sweep.tsp";
import "../common/examples.id.tsp";

namespace MoovAPI;

const ExampleSweep: Sweep = #{
  sweepID: ExampleID,
  status: SweepStatus.accruing,
  accruedAmount: "100.00",
  currency: "USD",
  accrualStartedOn: ExampleUtcDateTime,
};
