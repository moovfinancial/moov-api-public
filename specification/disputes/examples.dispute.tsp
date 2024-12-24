import "./models.dispute.tsp";

namespace MoovAPI;

const ExampleDispute: Dispute = #{
  disputeID: "6e356108-fdfa-4910-bbe4-1e3c8abf5520",
  merchantAccountID: "34233b72-780c-4e0e-8b08-cbbe1bc878f8",
  createdOn: utcDateTime.fromISO("2024-12-23T17:55:00Z"),
  amount: #{ currency: "USD", value: 257753 },
  networkReasonCode: "10.4",
  transfer: #{ transferID: "ecac148a-917e-4ee0-b46a-c51408939fff" },
  respondBy: utcDateTime.fromISO("2024-12-23T18:55:00Z"),
  status: DisputeStatus.responseNeeded,
  phase: DisputePhase.chargeback,
};

const ExampleAcceptedDispute: Dispute = #{
  disputeID: "6e356108-fdfa-4910-bbe4-1e3c8abf5520",
  merchantAccountID: "34233b72-780c-4e0e-8b08-cbbe1bc878f8",
  createdOn: utcDateTime.fromISO("2024-12-23T17:55:00Z"),
  amount: #{ currency: "USD", value: 257753 },
  networkReasonCode: "10.4",
  transfer: #{ transferID: "ecac148a-917e-4ee0-b46a-c51408939fff" },
  respondBy: utcDateTime.fromISO("2024-12-23T18:55:00Z"),
  status: DisputeStatus.accepted,
  phase: DisputePhase.chargeback,
};
