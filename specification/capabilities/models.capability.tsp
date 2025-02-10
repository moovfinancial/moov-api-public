import "./models.requirement.tsp";

namespace MoovAPI;

model Capability {
  capability: CapabilityID;

  @format("uuid")
  accountID: string;

  status: CapabilityStatus;
  requirements?: CapabilityRequirement;
  disabledReason?: string;
  createdOn: utcDateTime;
  updatedOn: utcDateTime;
  disabledOn?: utcDateTime;
}

@doc("""
  Moov account capabilities.
  
  The `production-app` capability might appear in your list. This is a read-only capability that Moov requests and uses for account verification purposes. The capability remains active with your account and requires no additional action.
  """)
enum CapabilityID {
  transfers: "transfers",
  sendFunds: "send-funds",
  collectFunds: "collect-funds",
  wallet: "wallet",
  cardIssuing: "card-issuing",
  productionApp: "production-app",
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
