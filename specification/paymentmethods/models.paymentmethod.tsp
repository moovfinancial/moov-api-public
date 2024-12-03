import "@typespec/openapi3";

import "../bankaccounts/models.bankaccount.tsp";
import "../cards/models.card.tsp";
import "../common/examples.id.tsp";

using TypeSpec.OpenAPI;

namespace MoovAPI;

@doc("ID of the payment method.")
@format("uuid")
scalar PaymentMethodID extends string;

model BasicPaymentMethod {
  paymentMethodID: PaymentMethodID;
  paymentMethodType: PaymentMethodType;
}

@doc("The payment method type that represents a payment rail and directionality")
enum PaymentMethodType {
  moovWallet: "moov-wallet",
  achDebitFund: "ach-debit-fund",
  achDebitCollect: "ach-debit-collect",
  achCreditStandard: "ach-credit-standard",
  achCreditSameDay: "ach-credit-same-day",
  rtpCredit: "rtp-credit",
  cardPayment: "card-payment",
  pushToCard: "push-to-card",
  pullFromCard: "pull-from-card",
  applePay: "apple-pay",
}

@doc("A method of moving money")
@discriminator("paymentMethodType")
@oneOf
union PaymentMethod {
  MoovWalletPaymentMethod,
  AchDebitFundPaymentMethod,
  AchDebitCollectPaymentMethod,
  AchCreditStandardPaymentMethod,
  AchCreditSameDayPaymentMethod,
  RtpCreditPaymentMethod,
  CardPaymentPaymentMethod,
  PushToCardPaymentMethod,
  PullFromCardPaymentMethod,
  ApplePayPaymentMethod,
}

// Wallet

model MoovWalletPaymentMethod {
  paymentMethodID: PaymentMethodID;
  paymentMethodType: PaymentMethodType.moovWallet;
  wallet: unknown; // @TODO: Update when wallets is done
}

// Bank Account

alias BankAccountPaymentMethod = {
  paymentMethodID: PaymentMethodID;
  bankAccount: BankAccount;
};

model AchDebitFundPaymentMethod {
  ...BankAccountPaymentMethod;
  paymentMethodType: PaymentMethodType.achDebitFund;
}

model AchDebitCollectPaymentMethod {
  ...BankAccountPaymentMethod;
  paymentMethodType: PaymentMethodType.achDebitCollect;
}

model AchCreditStandardPaymentMethod {
  ...BankAccountPaymentMethod;
  paymentMethodType: PaymentMethodType.achCreditStandard;
}

model AchCreditSameDayPaymentMethod {
  ...BankAccountPaymentMethod;
  paymentMethodType: PaymentMethodType.achCreditSameDay;
}

model RtpCreditPaymentMethod {
  ...BankAccountPaymentMethod;
  paymentMethodType: PaymentMethodType.rtpCredit;
}

// Card

alias CardPaymentMethod = {
  paymentMethodID: PaymentMethodID;
  card: Card;
};

model CardPaymentPaymentMethod {
  ...CardPaymentMethod;
  paymentMethodType: PaymentMethodType.cardPayment;
}

model PushToCardPaymentMethod {
  ...CardPaymentMethod;
  paymentMethodType: PaymentMethodType.pushToCard;
}

model PullFromCardPaymentMethod {
  ...CardPaymentMethod;
  paymentMethodType: PaymentMethodType.pullFromCard;
}

// Apple Pay

model ApplePayPaymentMethod {
  paymentMethodID: PaymentMethodID;
  paymentMethodType: PaymentMethodType.applePay;
  applePay: unknown; // @TODO: Update when apple pay is done
}
