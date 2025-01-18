import "./models.billing.tsp";

namespace MoovAPI;

model FeePlanAgreement {
  @format("uuid")
  aggreementID: string;

  @format("uuid")
  planID: string;

  @format("uuid")
  accountID?: string;

  acceptedOn: utcDateTime;
  status: FeePlanAgreementStatus;
  cardAcquringModel: CardAcquringModel;
  billableFees: BillableFee[];
}

model PartnerPricingAgreement extends FeePlanAgreement {
  @doc("The integer percentage value of the revenue split for partner.")
  @example(10)
  revenueShare: integer;
}

model CreateFeePlanAgreement {
  @format("uuid")
  planID: string;
}

model FeePlanAgreementError {
  planID?: string;
}

enum FeePlanAgreementStatus {
  active,
  terminated,
}
