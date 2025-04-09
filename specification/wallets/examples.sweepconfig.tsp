import "./models.sweepconfig.tsp";
import "../common/examples.id.tsp";
import "../common/examples.time.tsp";

namespace MoovAPI;

const ExampleEnabledSweepConfig: SweepConfig = #{
  sweepConfigID: ExampleID,
  walletID: ExampleID,
  status: SweepConfigStatus.enabled,
  pushPaymentMethod: #{ paymentMethodID: ExampleID },
  pullPaymentMethod: #{ paymentMethodID: ExampleID },
  minimumBalance: "0.00",
  statementDescriptor: "swp_012345",
  createdOn: ExampleUtcDateTime,
  updatedOn: ExampleUtcDateTime,
};

const ExampleDisabledSweepConfig: SweepConfig = #{
  sweepConfigID: ExampleID,
  walletID: ExampleID,
  status: SweepConfigStatus.disabled,
  pushPaymentMethod: #{ paymentMethodID: ExampleID },
  pullPaymentMethod: #{ paymentMethodID: ExampleID },
  minimumBalance: "0.00",
  statementDescriptor: "swp_012345",
  createdOn: ExampleUtcDateTime,
  updatedOn: ExampleUtcDateTime,
};
