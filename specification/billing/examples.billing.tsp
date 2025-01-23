import "./models.billing.tsp";

namespace MoovAPI;

const ExampleFeeProperties: FeeProperties = #{
  fixedAmount: #{ currency: "USD", valueDecimal: "0.0195" },
  variableRate: "0.15",
  minPerTransaction: #{ currency: "USD", valueDecimal: "0.0195" },
  maxPerTransaction: #{ currency: "USD", valueDecimal: "0.035" },
};
