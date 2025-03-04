import "./models.cancellation.tsp";
import "../common/models.header.tsp";

namespace MoovAPI;

const ExampleCreateCancellation: OperationExample = #{
  returnType: #{
    xRequestID: ExampleID,
    statusCode: HttpStatusOK,
    body: ExampleCancellation,
  },
};

const ExampleGetCancellation: OperationExample = #{
  returnType: #{
    xRequestID: ExampleID,
    statusCode: HttpStatusOK,
    body: ExampleCancellation,
  },
};

const ExampleCancellation: Cancellation = #{
  cancellationID: "89ca7f54-13ba-4714-b9af-17163eae2057",
  status: CancellationStatus.completed,
  createdOn: utcDateTime.fromISO("2025-01-19T03:02:43.255309588Z"),
};
