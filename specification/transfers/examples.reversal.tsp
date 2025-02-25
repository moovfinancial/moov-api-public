import "./models.refund.tsp";
import "./models.reversal.tsp";
import "../common/models.header.tsp";

namespace MoovAPI;

const ExampleReversalCancellation: OperationExample = #{
  returnType: #{
    xRequestID: ExampleID,
    statusCode: HttpStatusOK,
    body: #{
      cancellation: #{
        cancellationID: "89ca7f54-13ba-4714-b9af-17163eae2057",
        status: CancellationStatus.completed,
        createdOn: utcDateTime.fromISO("2025-01-19T03:02:43.255309588Z"),
      },
    },
  },
};

const ExampleReversalRefund: OperationExample = #{
  returnType: #{
    xRequestID: ExampleID,
    statusCode: HttpStatusOK,
    body: #{
      refund: #{
        refundID: "89ca7f54-13ba-4714-b9af-17163eae2057",
        createdOn: utcDateTime.fromISO("2025-01-19T03:07:26.001024809Z"),
        updatedOn: utcDateTime.fromISO("2025-01-19T03:07:26.602114307Z"),
        status: RefundStatus.pending,
        amount: #{ currency: "USD", value: 1938 },
        cardDetails: #{
          status: RefundCardStatus.confirmed,
          confirmedOn: utcDateTime.fromISO("2025-01-19T03:07:26.602114307Z"),
        },
      },
    },
  },
};
