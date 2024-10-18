import "./models.common.capability.tsp";

namespace MoovAPI.Capabilities;

model Capability {
  capability: CommonCapabilities.CapabilityID;

  @format("uuid")
  accountID: string;

  status: CommonCapabilities.CapabilityStatus;
  requirements?: Requirement[];
  disabledReason?: string;
  createdOn: utcDateTime;
  updatedOn: utcDateTime;
  disabledOn?: utcDateTime | null;
}
