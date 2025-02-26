import "./models.billing.tsp";

namespace MoovAPI;

const ExampleFeeProperties: FeeProperties = #{
  fixedAmount: #{ currency: "USD", valueDecimal: "0.0195" },
  variableRate: "0.15",
  minPerTransaction: #{ currency: "USD", valueDecimal: "0.0195" },
  maxPerTransaction: #{ currency: "USD", valueDecimal: "0.035" },
};

const ExampleBillableFeeACH: BillableFee = #{
  billableFeeID: "c520f1b9-0ba7-42f5-b977-248cdbe41c69",
  billableEvent: "ach-volume",
  feeName: "ACH Same Day Credit Fee",
  feeModel: FeeModel.blended,
  feeCategory: FeeCategory.ach,
  feeProperties: ExampleFeeProperties,
  feeConditions: #{ paymentMethodType: #["ach-credit-same-day"] },
};

const ExampleBillableFeeCard: BillableFee = #{
  billableFeeID: "c520f1b9-0ba7-42f5-b977-248cdbe41c69",
  billableEvent: "card-auth-volume",
  feeName: "Card decline fee",
  feeModel: FeeModel.blended,
  feeCategory: FeeCategory.cardAcquiring,
  feeProperties: ExampleFeeProperties,
  feeConditions: #{ transactionType: #["decline"] },
};
