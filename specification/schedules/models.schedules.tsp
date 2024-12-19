import "./models.occurrence.tsp";
import "./models.recur.tsp";
import "../accounts/models.account.tsp";
import "../transfers/models.transfer.tsp";

namespace MoovAPI;

model UpsertSchedule {
  @doc("Simple description of what the schedule is.")
  description?: string;

  occurrences?: Occurrence[];
  recur?: Recur;
}

model SchedulePaymentMethod {
  @format("uuid")
  @example("c520f1b9-0ba7-42f5-b977-248cdbe41c69")
  paymentMethodID: string;

  achDetails?: {
    companyEntryDescription?: ACHCompanyEntryDescription;
    originatingCompanyName?: ACHOriginatingCompanyName;
  };
  cardDetails?: {
    dynamicDescriptor?: CardDynamicDescriptor;
  };
}

model ScheduleResponse {
  @doc("Simple description to place on the transfer.")
  description?: string;

  @format("uuid")
  @example("c520f1b9-0ba7-42f5-b977-248cdbe41c69")
  destinationAccountID: string;

  mode: Mode;
  occurrences?: OccurrencesResponse;

  @format("uuid")
  @example("c520f1b9-0ba7-42f5-b977-248cdbe41c69")
  ownerAccountID: string;

  @format("uuid")
  @example("c520f1b9-0ba7-42f5-b977-248cdbe41c69")
  partnerAccountID: string;

  recur?: Recur;

  @format("uuid")
  @example("c520f1b9-0ba7-42f5-b977-248cdbe41c69")
  scheduleID: string;

  @format("uuid")
  @example("c520f1b9-0ba7-42f5-b977-248cdbe41c69")
  sourceAccountID: string;

  createdOn: utcDateTime;
  updatedOn: utcDateTime;
  disabledOn?: utcDateTime;
}

model ScheduleValidationError {
  occurrences?: string;
  recur?: string;
  description?: string;
}
