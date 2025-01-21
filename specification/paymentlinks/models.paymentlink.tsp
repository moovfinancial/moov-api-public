import "@typespec/http";
import "./examples.paymentlink.tsp";
import "./models.payment.tsp";
import "./models.payout.tsp";
import "../accounts/models.mode.tsp";
import "../money/models.amount.tsp";

using TypeSpec.Http;

namespace MoovAPI;

@doc("""
  Request to create a new payment link.
  
  A payment link must include either `payment` or `payout` details, but not both. For payout payment links,
  `maxUses` will automatically be set to 1, as these are intended for a one-time disbursement
  to a specific recipient.
  
  **Note:** The `payout` option is currently under development and is not yet available for general use.
  """)
@example(ExampleCreatePaymentRequest)
model CreatePaymentLink {
  @doc("The partner's Moov account ID.")
  @format("uuid")
  partnerAccountID: string;

  @doc("The merchant's preferred payment method ID. Must be a wallet payment method.")
  @format("uuid")
  merchantPaymentMethodID: string;

  amount: Amount;

  @doc("""
    An optional limit on the number of times this payment link can be used. 
    
    **For payouts, `maxUses` is always 1.**
    """)
  maxUses?: int64;

  @doc("An optional expiration date for this payment link.")
  expiresOn?: utcDateTime;

  display: PaymentLinkDisplayOptions;
  customer?: PaymentLinkCustomerOptions;
  payment?: PaymentLinkPaymentDetails;
  payout?: PaymentLinkPayoutDetails;
}

@error
model CreatePaymentLinkError {
  partnerAccountID?: string;
  merchantPaymentMethodID?: string;
  amount?: AmountValidationError;
  maxUses?: string;
  expiresOn?: string;
  display?: DisplayOptionsError;
  payment?: PaymentDetailsError;
  payout?: PayoutDetailsError;
}

@example(ExampleUpdatePaymentLink)
model UpdatePaymentLink {
  amount?: Amount;
  expiresOn?: utcDateTime | null;
  display?: PaymentLinkDisplayOptions;
  customer?: PaymentLinkCustomerOptions;
  payment?: PaymentLinkPaymentDetails;
  payout?: PaymentLinkPayoutDetails;
}

@error
model UpdatePaymentLinkError {
  amount?: AmountValidationError;
  expiresOn?: string;
  display?: DisplayOptionsError;
  payment?: PaymentDetailsError;
  payout?: PayoutDetailsError;
}

@error
model AmountValidationError {
  currency?: string;
  value?: string;
}

@doc("Unique code identifying this payment link.")
@example("uc7ZYKrMhi")
scalar PaymentLinkCode extends string;

@example(ExampleCreatedPaymentLink)
model PaymentLink {
  code: PaymentLinkCode;
  mode: Mode;
  status: PaymentLinkStatus;

  @doc("The partner's Moov account ID.")
  @format("uuid")
  partnerAccountID: string;

  @doc("The merchant's Moov account ID.")
  @format("uuid")
  merchantAccountID: string;

  @doc("The merchant's preferred payment method ID. Must be a wallet payment method.")
  @format("uuid")
  merchantPaymentMethodID: string;

  @doc("Link to the payment landing page for this payment link.")
  @format("uri")
  link: string;

  amount: Amount;

  @doc("The number of times this payment link has been used.")
  uses: int64;

  @doc("""
    An optional limit on the number of times this payment link can be used. 
    
    **For payouts, `maxUses` is always 1.**
    """)
  maxUses?: int64;

  @doc("The timestamp when this payment link was last used.")
  lastUsedOn?: utcDateTime;

  @doc("An optional expiration date for this payment link.")
  expiresOn?: utcDateTime;

  display: PaymentLinkDisplayOptions;
  customer: PaymentLinkCustomerOptions;
  payment?: PaymentLinkPaymentDetails;
  payout?: PaymentLinkPayoutDetails;
  createdOn: utcDateTime;
  updatedOn: utcDateTime;
  disabledOn?: utcDateTime;
}

@doc("Customizable display options for a payment link.")
model PaymentLinkDisplayOptions {
  @doc("The payment page title displayed to the user.")
  title: string;

  @doc("A payment description displayed to the user.")
  description: string;

  callToAction: CallToAction;
}

@error
model DisplayOptionsError {
  title?: string;
  description?: string;
  callToAction?: string;
}

model PaymentLinkCustomerOptions {
  @doc("If true, a billing address is required when completing the payment form.")
  requireAddress?: boolean;

  @doc("If true, a phone number is required when completing the payment form.")
  requirePhone?: boolean;

  @doc("Optional free-form metadata for the Moov account that will represent this customer.")
  metadata?: Record<string>;
}

model QRCodeImage {
  @statusCode statusCode: HttpStatusOK;
  @header contentType: "image/png";

  @doc("PNG encoded QR code image.")
  @body
  body: bytes;
}

model QRCodeJSON {
  @statusCode statusCode: HttpStatusOK;
  @header contentType: "application/json";
  @body body: QRCode;
}

model QRCode {
  @doc("A base64-encoded PNG image of the QR code.")
  @example("iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAIAAADaA7F0AAAACXBIWXMAAAsTAAALEwEAmpwYAAAA...")
  qrCode: string;
}

enum PaymentLinkStatus {
  active,
  used,
  disabled,
  expired,
}

@doc("""
  The text to be displayed on web form's submit button.
  
  If set to "auto" the UI will automatically select between 
  "pay" and "confirm" for payments and payouts respectively.
  """)
enum CallToAction {
  pay,
  book,
  subscribe,
  donate,
  confirm,
  auto,
}
