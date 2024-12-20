import "./models.refund.tsp";

namespace MoovAPI;

const ExampleCreateSyncRefundSuccess: CardAcquiringRefund = #{
  refundID: "d4963079-5b35-4d17-981e-8f851753f786",
  createdOn: utcDateTime.fromISO("2023-09-09T14:15:22Z"),
  updatedOn: utcDateTime.fromISO("2023-09-09T14:17:41Z"),
  status: RefundStatus.pending,
  amount: #{ currency: "USD", value: 1204 },
  cardDetails: #{
    status: RefundCardStatus.confirmed,
    initiatedOn: utcDateTime.fromISO("2023-09-09T14:16:22Z"),
    confirmedOn: utcDateTime.fromISO("2023-09-09T14:17:41Z"),
  },
};

const ExampleAsyncRefund: AsyncCreatedRefund = #{
  refundID: "d4963079-5b35-4d17-981e-8f851753f786",
  createdOn: utcDateTime.fromISO("2023-09-09T14:15:22Z"),
  amount: #{ currency: "USD", value: 1204 },
};

const ExampleCardAcquiringRefund: CardAcquiringRefund = #{
  refundID: "ec7e1848-dc80-4ab0-8827-dd7fc0737b43",
  amount: #{ currency: "USD", value: 1204 },
  cardDetails: #{
    completedOn: utcDateTime.fromISO("2024-08-24T14:15:22Z"),
    confirmedOn: utcDateTime.fromISO("2024-08-24T14:15:22Z"),
    initiatedOn: utcDateTime.fromISO("2024-08-24T14:15:22Z"),
    settledOn: utcDateTime.fromISO("2024-08-24T14:15:22Z"),
    status: RefundCardStatus.completed,
  },
  createdOn: utcDateTime.fromISO("2024-08-24T14:15:22Z"),
  status: RefundStatus.completed,
  updatedOn: utcDateTime.fromISO("2024-08-24T14:15:22Z"),
};
