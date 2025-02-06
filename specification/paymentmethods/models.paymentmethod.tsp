import "@typespec/openapi3";

import "../applepay/models.token.tsp";
import "../bankaccounts/models.bankaccount.tsp";
import "../cards/models.card.tsp";
import "../wallets/models.wallet.tsp";
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

model PaymentMethodsWallet {
  walletID: WalletID;
}

model MoovWalletPaymentMethod {
  paymentMethodID: PaymentMethodID;
  paymentMethodType: PaymentMethodType.moovWallet;
  wallet: PaymentMethodsWallet;
}

// Bank Accounts

@doc("A bank account as contained within a payment method.")
model PaymentMethodsBankAccount
  is OmitProperties<
    BankAccount,
    "statusReason" | "exceptionDetails" | "paymentMethods"
  >;

model AchDebitFundPaymentMethod {
  paymentMethodID: PaymentMethodID;
  paymentMethodType: PaymentMethodType.achDebitFund;
  bankAccount: PaymentMethodsBankAccount;
}

model AchDebitCollectPaymentMethod {
  paymentMethodID: PaymentMethodID;
  paymentMethodType: PaymentMethodType.achDebitCollect;
  bankAccount: PaymentMethodsBankAccount;
}

model AchCreditStandardPaymentMethod {
  paymentMethodID: PaymentMethodID;
  paymentMethodType: PaymentMethodType.achCreditStandard;
  bankAccount: PaymentMethodsBankAccount;
}

model AchCreditSameDayPaymentMethod {
  paymentMethodID: PaymentMethodID;
  paymentMethodType: PaymentMethodType.achCreditSameDay;
  bankAccount: PaymentMethodsBankAccount;
}

model RtpCreditPaymentMethod {
  paymentMethodID: PaymentMethodID;
  paymentMethodType: PaymentMethodType.rtpCredit;
  bankAccount: PaymentMethodsBankAccount;
}

// Cards

@doc("A card as contained within a payment method.")
model PaymentMethodsCard
  is OmitProperties<
    Card,

      | "cardCategory"
      | "issuerURL"
      | "issuerPhone"
      | "commercial"
      | "regulated"
      | "paymentMethods"
  >;

model CardPaymentPaymentMethod {
  paymentMethodID: PaymentMethodID;
  paymentMethodType: PaymentMethodType.cardPayment;
  card: PaymentMethodsCard;
}

model PushToCardPaymentMethod {
  paymentMethodID: PaymentMethodID;
  paymentMethodType: PaymentMethodType.pushToCard;
  card: PaymentMethodsCard;
}

model PullFromCardPaymentMethod {
  paymentMethodID: PaymentMethodID;
  paymentMethodType: PaymentMethodType.pullFromCard;
  card: PaymentMethodsCard;
}

// Apple Pay

model ApplePayPaymentMethod {
  paymentMethodID: PaymentMethodID;
  paymentMethodType: PaymentMethodType.applePay;
  applePay: ApplePayResponse;
}
