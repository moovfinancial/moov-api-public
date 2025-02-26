import "./models.billing.tsp";

namespace MoovAPI;

const ExampleFeeProperties: FeeProperties = #{
  fixedAmount: #{ currency: "USD", valueDecimal: "0.0195" },
  variableRate: "0.15",
  minPerTransaction: #{ currency: "USD", valueDecimal: "0.0195" },
  maxPerTransaction: #{ currency: "USD", valueDecimal: "0.035" },
};

const ExampleBillableFeeACH: BillableFee = #{
  billableFeeID: "ca2515ae-467c-4c67-9f74-40613cdaca55",
  billableEvent: "ach-volume",
  feeName: "ACH Same Day Credit Fee",
  feeModel: FeeModel.fixed,
  feeCategory: FeeCategory.ach,
  feeProperties: #{
    fixedAmount: #{
      currency: "USD",
      valueDecimal: "0.5"
    }
  },
  feeConditions: #{
    paymentMethodType: #[
      PaymentMethodType.achCreditSameDay,
    ]
  }
};

const ExampleBillableFeeCard: BillableFee = #{
  billableFeeID: "9d957d33-1a9a-47aa-9460-fe1a90f003dd",
  billableEvent: "card-auth-volume",
  feeName: "Card decline fee",
  feeModel: FeeModel.fixed,
  feeCategory: FeeCategory.cardAcquiring,
  feeProperties: #{
    fixedAmount: #{
      currency: "USD",
      valueDecimal: "0.1"
    }
  },
  feeConditions: #{
    transactionType: #[
      "decline"
    ]
  }
};
