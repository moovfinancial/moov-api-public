namespace MoovAPI;

const BillingDecimalStringPattern = "^[0-9]+.?[0-9]*$";

model FeePlan {
  @format("uuid")
  planID: string;

  @doc("The name of the fee plan.")
  @example("Fixed Rate Merchant Plan")
  name: string;

  @doc("A description of the fee plan.")
  description?: string;

  cardAcquringModel: CardAcquringModel;

  @doc("Additional usage-based fees for this plan.")
  billableFees: BillableFee[];

  createdAt: utcDateTime;
}

model PartnerPricing {
  @format("uuid")
  planID: string;

  @doc("The name of the fee plan.")
  @example("Fixed Rate Merchant Plan")
  name: string;

  @doc("A description of the fee plan.")
  description?: string;

  @doc("The integer percentage value of the revenue split for partner.")
  @example(10)
  revenueShare: integer;

  cardAcquringModel: CardAcquringModel;
  billableFees: BillableFee[];
  createdAt: utcDateTime;
}

model BillableFee {
  @format("uuid")
  billableFeeID?: string;

  @doc("A unique code identifying a charge.")
  @example("ach-volume")
  billableEvent?: string;

  @doc("Specifies the name of the fee that will be billed.")
  @example("ACH Direct Debit")
  feeName?: string;

  feeModel: FeeModel;
  feeCategory: FeeCategory;
  feeProperties?: FeeProperties;
  feeConditions?: FeeConditions;
}

model FeeProperties {
  @doc("A fixed fee that is applied to the amount of each transaction in the `fixed` and `blended` fee models, expressed as a decimal.")
  @pattern(BillingDecimalStringPattern)
  @example("0.15")
  fixedAmount?: string;

  @doc("A percentage fee that is applied to the amount of each transaction in the `blended` fee model, expressed as a decimal.")
  @pattern(BillingDecimalStringPattern)
  @example("0.14")
  variableRate?: string;

  @doc("Specifies the minimum allowable spending for a single transaction, working as a transaction floor.")
  @pattern(BillingDecimalStringPattern)
  @example("1.75")
  minPerTransaction?: string;

  @doc("Specifies the maximum allowable spending for a single transaction, working as a transaction ceiling.")
  @pattern(BillingDecimalStringPattern)
  @example("3.50")
  maxPerTransaction?: string;
}

@doc("Defines the specific conditions that must be met for the fee to be applied.")
@example(#{ cardBrand: #["visa"] })
model FeeConditions is Record<unknown>;

@doc("Specifies the card processing pricing model")
enum CardAcquringModel {
  costPlus: "cost-plus",
  flatRate: "flat-rate",
}

enum FeeCategory {
  cardAcquiring: "card-acquiring",
  cardPush: "card-push",
  cardPull: "card-pull",
  ach: "ach",
  rtp: "rtp",
  cardOther: "card-other",
  networkPassthrough: "network-passthrough",
  other: "other",
}

@doc("Specifies the pricing model used for the calculation of the final fee.")
enum FeeModel {
  fixed,
  blended,
}
