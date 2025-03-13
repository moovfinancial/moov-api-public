import "@typespec/openapi3";
import "./examples.billing.tsp";
import "../money/models.amount.tsp";

using TypeSpec.OpenAPI;

namespace MoovAPI;

const BillingRateStringPattern = "^[0-9]+.?[0-9]*$";

@format("uuid")
scalar uuid extends string;

model FeePlan {
  @format("uuid")
  planID: string;

  @doc("The name of the fee plan.")
  @example("Fixed Rate Merchant Plan")
  name: string;

  @doc("A description of the fee plan.")
  description?: string;

  cardAcquiringModel: CardAcquiringModel;

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

  cardAcquiringModel: CardAcquiringModel;
  billableFees: BillableFee[];
  createdAt: utcDateTime;
}

@example(ExampleBillableFeeACH, #{ title: "ACH Fee" })
@example(ExampleBillableFeeCard, #{ title: "Card Fee" })
model BillableFee {
  @format("uuid")
  billableFeeID?: string;

  @doc("A unique code identifying a charge.")
  billableEvent?: string;

  @doc("Specifies the name of the fee that will be billed.")
  feeName?: string;

  feeModel: FeeModel;
  feeCategory: FeeCategory;
  feeProperties?: FeeProperties;
  feeConditions?: FeeConditions;
}

@doc("Defines the specific parameters used for fee calculation.")
@example(ExampleFeeProperties)
model FeeProperties {
  @doc("A fixed fee that is applied to the amount of each transaction in the `fixed` and `blended` fee models.")
  fixedAmount?: AmountDecimal;

  @doc("""
    A percentage fee that is applied to the amount of each transaction in the `blended` fee model, expressed as a decimal. 
    
    For example, 0.05% is '0.05'.
    """)
  @pattern(BillingRateStringPattern)
  @example("0.05")
  variableRate?: string;

  @doc("Specifies the minimum allowable spending for a single transaction, working as a transaction floor.")
  minPerTransaction?: AmountDecimal;

  @doc("Specifies the maximum allowable spending for a single transaction, working as a transaction ceiling.")
  maxPerTransaction?: AmountDecimal;
}

@doc("Defines the specific conditions that must be met for the fee to be applied.")
@example(#{ cardBrand: #["visa"] })
model FeeConditions is Record<unknown>;

@doc("Specifies the card processing pricing model")
enum CardAcquiringModel {
  costPlus: "cost-plus",
  flatRate: "flat-rate",
}

enum FeeCategory {
  ach: "ach",
  cardAcquiring: "card-acquiring",
  cardOther: "card-other",
  cardPull: "card-pull",
  cardPush: "card-push",
  monthlyPlatform: "monthly-platform",
  networkPassthrough: "network-passthrough",
  other: "other",
  rtp: "rtp",
}

@doc("Specifies the pricing model used for the calculation of the final fee.")
enum FeeModel {
  fixed,
  blended,
  variable,
}

@doc("A fee incurred by a user.")
model IncurredFee {
  @format("uuid")
  feeID?: string;

  @format("uuid")
  accountID?: string;

  @format("uuid")
  walletID?: string;

  createdOn?: utcDateTime;
  feeName?: string;
  amount?: AmountDecimal;
  generatedBy?: GeneratedBy;
}

@doc("The entity that generated the fee.")
@oneOf
union GeneratedBy {
  GeneratedByTransferID,
  GeneratedByCardID,
  GeneratedByDisputeID,
  GeneratedByAccountID,
  GeneratedByBankAccountID,
}

@summary("Transfer ID")
model GeneratedByTransferID {
  @format("uuid")
  transferID?: string;
}

@summary("Card ID")
model GeneratedByCardID {
  @format("uuid")
  CardID?: string;
}

@summary("Dispute ID")
model GeneratedByDisputeID {
  @format("uuid")
  DisputeID?: string;
}

@summary("Account ID")
model GeneratedByAccountID {
  @format("uuid")
  AccountID?: string;
}

@summary("Bank account ID")
model GeneratedByBankAccountID {
  @format("uuid")
  BankAccountID?: string;
}

@doc("Array of fee IDs to fetch.")
model ListFeesFetchRequest {
  feeIDs?: uuid[];
}
