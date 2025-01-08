import "../transfers/models.card.tsp";
import "../transfers/models.ach.tsp";

namespace MoovAPI;

@doc("Options for payment links used to collect payment.")
model PaymentLinkPaymentDetails {
  @doc("A list of payment methods that should be supported for this payment link.")
  @minItems(1)
  allowedMethods: CollectionPaymentMethodType[];

  cardDetails?: CardPaymentDetails;
  achDetails?: ACHPaymentDetails;
}

model PaymentDetailsError {
  allowedMethods?: string;
  cardDetails?: CardPaymentDetailsError;
  achDetails?: ACHPaymentDetailsError;
}

@doc("Options for payment links used to collect a card payment.")
model CardPaymentDetails {
  dynamicDescriptor?: CardDynamicDescriptor;
}

@error
model CardPaymentDetailsError {
  dynamicDescriptor?: string;
}

@doc("Options for payment links used to collect an ACH payment.")
model ACHPaymentDetails {
  companyEntryDescription?: ACHCompanyEntryDescription;
  originatingCompanyName?: ACHOriginatingCompanyName;
}

@error
model ACHPaymentDetailsError {
  companyEntryDescription?: string;
  originatingCompanyName?: string;
}

@doc("Payment methods allowed for collecting a payment.")
enum CollectionPaymentMethodType {
  applePay: "apple-pay",
  cardPayment: "card-payment",
  achDebitCollect: "ach-debit-collect",
}
