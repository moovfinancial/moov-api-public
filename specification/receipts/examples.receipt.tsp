import "./models.receipt.tsp";
import "../common/models.email.tsp";

namespace MoovAPI;

const ExampleReceiptTransfer: ReceiptResponse = #{
  createdBy: "25a02396-1048-48f9-bf93-102d2fb7895e",
  receiptID: "4925c8a5-3b9a-4488-a514-9fd992546aca",
  forTransferID: "193ceb53-94c7-41c4-9272-c90c2832cb4c",
  kind: ReceiptKind.saleCustomer,
  email: "jordan.lee@classbooker.dev",
  sentFor: #[
    #{
      idempotencyKey: "0c14c6a6-6f50-4d1e-b0c4-b46ff43ba6a1",
      receiptID: "4925c8a5-3b9a-4488-a514-9fd992546aca",
      sentOn: utcDateTime.fromISO("2025-01-16T17:52:14.219311143Z"),
    }
  ],
};

const ExampleReceiptScheduled: ReceiptResponse = #{
  createdBy: "25a02396-1048-48f9-bf93-102d2fb7895e",
  receiptID: "4925c8a5-3b9a-4488-a514-9fd992546aca",
  forScheduleID: "193ceb53-94c7-41c4-9272-c90c2832cb4c",
  kind: ReceiptKind.saleCustomer,
  email: "jordan.lee@classbooker.dev",
  sentFor: #[
    #{
      idempotencyKey: "0c14c6a6-6f50-4d1e-b0c4-b46ff43ba6a1",
      receiptID: "4925c8a5-3b9a-4488-a514-9fd992546aca",
      sentOn: utcDateTime.fromISO("2025-01-16T17:52:14.219311143Z"),
    }
  ],
};

const ExampleReceiptOccurrence: ReceiptResponse = #{
  createdBy: "25a02396-1048-48f9-bf93-102d2fb7895e",
  receiptID: "4925c8a5-3b9a-4488-a514-9fd992546aca",
  forOccurrenceID: "193ceb53-94c7-41c4-9272-c90c2832cb4c",
  kind: ReceiptKind.saleCustomer,
  email: "jordan.lee@classbooker.dev",
  sentFor: #[
    #{
      idempotencyKey: "0c14c6a6-6f50-4d1e-b0c4-b46ff43ba6a1",
      receiptID: "4925c8a5-3b9a-4488-a514-9fd992546aca",
      sentOn: utcDateTime.fromISO("2025-01-16T17:52:14.219311143Z"),
    }
  ],
};
