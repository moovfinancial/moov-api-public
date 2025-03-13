import "@typespec/openapi3";
import "@typespec/versioning";

import "../applepay/models.token.tsp";
import "../bankaccounts/models.bankaccount.tsp";
import "../cards/models.card.tsp";
import "../models.version.tsp";
import "../wallets/models.wallet.tsp";
import "../common/examples.id.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

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

  @added(MoovAPI.Versions.v2025q2)
  cardPresentPayment: "card-present-payment",
}

@doc("A method of moving money")
@discriminator("paymentMethodType")
@oneOf
union PaymentMethod {
  moovWallet: MoovWalletPaymentMethod,
  AchDebitFundPaymentMethod,
  AchDebitCollectPaymentMethod,
  AchCreditStandardPaymentMethod,
  AchCreditSameDayPaymentMethod,
  RtpCreditPaymentMethod,
  CardPaymentPaymentMethod,
  PushToCardPaymentMethod,
  PullFromCardPaymentMethod,
  ApplePayPaymentMethod,

  @added(MoovAPI.Versions.v2025q2)
  CardPresentPaymentPaymentMethod,
}

// Wallet

model PaymentMethodsWallet {
  walletID: WalletID;
}

@summary("Moov wallet")
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

@summary("ACH debit fund")
model AchDebitFundPaymentMethod {
  paymentMethodID: PaymentMethodID;
  paymentMethodType: PaymentMethodType.achDebitFund;
  bankAccount: PaymentMethodsBankAccount;
}

@summary("ACH debit collect")
model AchDebitCollectPaymentMethod {
  paymentMethodID: PaymentMethodID;
  paymentMethodType: PaymentMethodType.achDebitCollect;
  bankAccount: PaymentMethodsBankAccount;
}

@summary("ACH credit standard")
model AchCreditStandardPaymentMethod {
  paymentMethodID: PaymentMethodID;
  paymentMethodType: PaymentMethodType.achCreditStandard;
  bankAccount: PaymentMethodsBankAccount;
}

@summary("ACH credit same day")
model AchCreditSameDayPaymentMethod {
  paymentMethodID: PaymentMethodID;
  paymentMethodType: PaymentMethodType.achCreditSameDay;
  bankAccount: PaymentMethodsBankAccount;
}

@summary("RTP credit")
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

@summary("Card payment")
model CardPaymentPaymentMethod {
  paymentMethodID: PaymentMethodID;
  paymentMethodType: PaymentMethodType.cardPayment;
  card: PaymentMethodsCard;
}

@summary("Push to card")
model PushToCardPaymentMethod {
  paymentMethodID: PaymentMethodID;
  paymentMethodType: PaymentMethodType.pushToCard;
  card: PaymentMethodsCard;
}

@summary("Pull from card")
model PullFromCardPaymentMethod {
  paymentMethodID: PaymentMethodID;
  paymentMethodType: PaymentMethodType.pullFromCard;
  card: PaymentMethodsCard;
}

// Apple Pay

@summary("Apple Pay")
model ApplePayPaymentMethod {
  paymentMethodID: PaymentMethodID;
  paymentMethodType: PaymentMethodType.applePay;
  applePay: ApplePayResponse;
}

// Card Present

@added(MoovAPI.Versions.v2025q2)
@doc("Describes payment card details captured with tap or in-person payment.")
@example(#{
  entryMode: EntryMode.contactless,
  brand: CardBrand.visa,
  bin: "123456",
  cardType: CardType.credit,
  expiration: exampleCardExpiration,
  fingerprint: exampleCardFingerprint,
  holderName: "Jules Jackson",
  issuer: "GRINGOTTS BANK",
  issuerCountry: "US",
  lastFourCardNumber: "1234",
})
model TerminalCard {
  entryMode?: EntryMode;
  brand?: CardBrand;

  @minLength(6)
  @maxLength(8)
  bin?: string;

  cardType?: CardType;
  expiration?: CardExpiration;
  fingerprint?: CardFingerprint;

  @doc("The name of the cardholder as it appears on the card.")
  holderName?: string;

  @doc("Financial institution that issued the card.")
  issuer?: string;

  @doc("Country where the card was issued.")
  issuerCountry?: string;

  @doc("Last four digits of the card number")
  @minLength(4)
  @maxLength(4)
  lastFourCardNumber?: string;
}

@added(MoovAPI.Versions.v2025q2)
@doc("How the card information was entered into the point of sale terminal.")
@example(EntryMode.contactless)
enum EntryMode {
  contactless,
}

@added(MoovAPI.Versions.v2025q2)
@doc("A card used at point of sale terminal for a card present transaction as contained within a payment method.")
model CardPresentPaymentPaymentMethod {
  paymentMethodID: PaymentMethodID;
  paymentMethodType: PaymentMethodType.cardPresentPayment;
  terminalCard?: TerminalCard;
}
