import "../money/models.amount.tsp";
import "../paymentmethods/models.paymentmethod.tsp";

namespace MoovAPI;

model CreateTransferOptions {
  source: SourceDestinationOptions;
  destination: SourceDestinationOptions;
  amount: Amount;
}

model SourceDestinationOptions {
  @format("uuid")
  accountID?: string;

  @format("uuid")
  paymentMethodID?: string;
}

model TransferOptions {
  sourceOptions?: PaymentMethod[];
  destinationOptions?: PaymentMethod[];
}

model TransferOptionsValidationError {
  amount?: string;
  source?: string;
  destination?: string;
}
