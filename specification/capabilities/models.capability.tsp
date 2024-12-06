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
  transfers: "transfers",
  sendFunds: "send-funds",
  collectFunds: "collect-funds",
  wallet: "wallet",
  cardIssuing: "card-issuing",
}

@doc("The status of the capability requested for an account.")
enum CapabilityStatus {
  enabled: "enabled",
  disabled: "disabled",
  pending: "pending",
  inReview: "in-review",
}

model AddCapabilities {
  capabilities: CapabilityID[];
}

model AddCapabilitiesError {
  error?: CapabilitiesError;
}

model CapabilitiesError {
  capabilities?: Record<string>;
}
