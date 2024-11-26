import "./models.requirement.tsp";

namespace MoovAPI;

model Capability {
  capability: CapabilityID;

  @format("uuid")
  accountID: string;

  status: CapabilityStatus;
  requirements?: CapabilityRequirement[];
  disabledReason?: string;
  createdOn: utcDateTime;
  updatedOn: utcDateTime;
  disabledOn?: utcDateTime;
}

@doc("Moov account capabilities.")
enum CapabilityID {
  Transfers: "transfers",
  SendFunds: "send-funds",
  CollectFunds: "collect-funds",
  Wallet: "wallet",
  CardIssuing: "card-issuing",
}

@doc("The status of the capability requested for an account.")
enum CapabilityStatus {
  Enabled: "enabled",
  Disabled: "disabled",
  Pending: "pending",
  InRreview: "in-review",
}
