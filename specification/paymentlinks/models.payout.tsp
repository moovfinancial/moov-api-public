import "../common/models.email.tsp";

namespace MoovAPI;

model PaymentLinkPayoutDetails {
  @doc("A list of payment methods that should be supported for this payment link.")
  @minItems(1)
  allowedMethods: DisbursementPaymentMethodType[];

  recipient: PayoutRecipient;
}

@error
model PayoutDetailsError {
  allowedMethods?: string;
  recipient?: PayoutRecipientError;
}

@doc("""
  Specify the intended recipient of the payout.
  
  This information will be used to authenticate the end user when they follow the payment link.
  """)
model PayoutRecipient {
  email: Email;
}

@error
model PayoutRecipientError {
  email?: string;
}

@doc("Payment methods allowed for disbursing funds.")
enum DisbursementPaymentMethodType {
  pushToCard: "push-to-card",
  rtpCredit: "rtp-credit",
  achCreditSameDay: "ach-credit-same-day",
  achCreditStandard: "ach-credit-standard",
}
