import "./models.billing.tsp";

namespace MoovAPI;

model FeePlanAgreement {
  @format("uuid")
  agreementID: string;

  @format("uuid")
  planID: string;

  @format("uuid")
  accountID?: string;

  @doc("The name of the agreement.")
  name: string;

  @doc("The description of the agreement.")
  description?: string;

  acceptedOn: utcDateTime;
  status: FeePlanAgreementStatus;
  cardAcquiringModel: CardAcquiringModel;
  billableFees: BillableFee[];
  minimumCommitment: MinimumCommitment;
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
