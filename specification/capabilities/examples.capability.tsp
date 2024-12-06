import "../common/examples.id.tsp";
import "../common/examples.time.tsp";
import "./models.capability.tsp";

namespace MoovAPI;

const ExampleTransfersCapability: Capability = #{
  capability: CapabilityID.transfers,
  accountID: ExampleID,
  status: CapabilityStatus.enabled,
  createdOn: ExampleUtcDateTime,
  updatedOn: ExampleUtcDateTime,
};

const ExampleCollectFundsCapability: Capability = #{
  capability: CapabilityID.collectFunds,
  accountID: ExampleID,
  status: CapabilityStatus.inReview,
  requirements: #[#{ currentlyDue: #[RequirementID.businessOwners] }],
  createdOn: ExampleUtcDateTime,
  updatedOn: ExampleUtcDateTime,
};
