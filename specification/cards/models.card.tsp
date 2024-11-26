import "@typespec/http";
import "@typespec/openapi3";
import "@typespec/versioning";
import "../accounts/models.account.tsp";
import "../common/models.id.tsp";
import "../end2end/models.token.tsp";
import "../paymentmethods/models.paymentmethod.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace MoovAPI;

@doc("ID of the card.")
@format("uuid")
@example(exampleID)
scalar CardID extends string;

const exampleCard = #{
  cardID: exampleID,
  fingerprint: exampleCardFingerprint,
  brand: CardBrand.visa,
  cardType: CardType.credit,
  cardCategory: "CLASSIC",
  lastFourCardNumber: "1234",
  bin: "123456",
  expiration: exampleCardExpiration,
  holderName: "Jules Jackson",
  billingAddress: exampleAddress,
  cardVerification: exampleCardVerification,
  issuer: "GRINGOTTS BANK",
  issuerCountry: "US",
  issuerURL: "HTTPS://WWW.EXAMPLE.COM/",
  issuerPhone: "8185551212",
  commercial: false,
  regulated: false,
  cardOnFile: true,
  merchantAccountID: exampleID,
  cardAccountUpdater: exampleCardAccountUpdater,
  domesticPushToCard: DomesticPushToCard.standard,
  domesticPullFromCard: DomesticPullFromCard.supported,
  paymentMethods: #[
    #{
      paymentMethodID: exampleID,
      paymentMethodType: PaymentMethodType.cardPayment,
    },
    #{
      paymentMethodID: exampleID,
      paymentMethodType: PaymentMethodType.pushToCard,
    },
    #{
      paymentMethodID: exampleID,
      paymentMethodType: PaymentMethodType.pullFromCard,
    }
  ],
};

@doc("Describes a card on a Moov account.")
@example(exampleCard)
model Card {
  cardID: CardID;
  fingerprint: CardFingerprint;
  brand: CardBrand;
  cardType: CardType;

  @doc("""
    The category or level of the card defined by the issuer.
    Examples include, but not limited to, "REWARDS", "TRADITIONAL REWARDS", "CLASSIC", and "CORPORATE PURCHASING".
    """)
  cardCategory: string;

  @doc("Last four digits of the card number")
  @minLength(4)
  @maxLength(4)
  lastFourCardNumber: string;

  @doc("The first six to eight digits of the card number, which identifies the financial institution that issued the card.")
  @minLength(6)
  @maxLength(8)
  bin: string;

  expiration: CardExpiration;

  @doc("The name of the cardholder as it appears on the card.")
  holderName: string;

  billingAddress: Address;
  cardVerification: CardVerification;

  @doc("Financial institution that issued the card.")
  issuer: string;

  @doc("Country where the card was issued.")
  issuerCountry: string;

  @doc("URL of the issuer.")
  @format("uri")
  issuerURL: string;

  @doc("Phone number of the issuer.")
  issuerPhone: string;

  @doc("""
    If true, the card is for commercial use, or associated with a business.
    If false, the card is associated with a general consumer.
    """)
  commercial?: boolean;

  @doc("""
    If true, the card issuing bank is regulated, and the scheme fees for debit transactions will be limited based on the Durbin Amendment.
    If false, the card issuing bank is not regulated, and the scheme fees will not be limited.
    """)
  regulated?: boolean;

  @doc("Indicates cardholder has authorized card to be stored for future payments.")
  cardOnFile: boolean;

  @format("uuid")
  merchantAccountID?: string;

  cardAccountUpdater?: CardAccountUpdater;
  domesticPushToCard: DomesticPushToCard;
  domesticPullFromCard: DomesticPullFromCard;
  paymentMethods?: PaymentMethod[];
}

const exampleCardFingerprint = "9948962d92a1ce40c9f918cd9ece3a22bde62fb325a2f1fe2e833969de672ba3";

@doc("""
  Uniquely identifies a linked payment card or token.
  For Apple Pay, the fingerprint is based on the tokenized card number and may vary based on the user's device.
  This field can be used to identify specific payment methods across multiple accounts on your platform.
  """)
@maxLength(100)
@example(exampleCardFingerprint)
scalar CardFingerprint extends string;

@doc("The card brand.")
@example(CardBrand.visa)
enum CardBrand {
  americanExpress: "American Express",
  discover: "Discover",
  mastercard: "Mastercard",
  visa: "Visa",
  `unknown`: "Unknown",
}

@doc("The type of the card.")
@example(CardType.credit)
enum CardType {
  debit: "debit",
  credit: "credit",
  prepaid: "prepaid",
  `unknown`: "unknown",
}

const exampleCardExpiration = #{ month: "01", year: "21" };

@doc("The expiration date of the card or token.")
@example(exampleCardExpiration)
model CardExpiration {
  @minLength(2)
  @maxLength(2)
  month: string;

  @minLength(2)
  @maxLength(2)
  year: string;
}

const exampleCardVerification = #{
  cvv: CardVerificationResult.match,
  addressLine1: CardVerificationResult.match,
  postalCode: CardVerificationResult.match,
  accountName: exampleAccountNameVerification,
};

@doc("The results of submitting cardholder data to a card network for verification.")
@example(exampleCardVerification)
model CardVerification {
  cvv: CardVerificationResult;
  addressLine1: CardVerificationResult;
  postalCode: CardVerificationResult;
  accountName: AccountNameVerification;
}

const exampleAccountNameVerification = #{
  firstName: CardVerificationResult.match,
  lastName: CardVerificationResult.match,
  middleName: CardVerificationResult.match,
  fullName: CardVerificationResult.match,
};

@doc("The results of submitting cardholder name to a card network for verification.")
@example(exampleAccountNameVerification)
model AccountNameVerification {
  firstName: CardVerificationResult;
  lastName: CardVerificationResult;
  middleName: CardVerificationResult;
  fullName: CardVerificationResult;
}

@example(CardVerificationResult.match)
enum CardVerificationResult {
  noMatch: "noMatch",
  match: "match",
  notChecked: "notChecked",
  unavailable: "unavailable",
  partialMatch: "partialMatch",
}

@doc("Indicates which level of domestic push-to-card transfer is supported by the card, if any.")
@example(DomesticPushToCard.standard)
enum DomesticPushToCard {
  @doc("This card is ineligible for domestic push-to-card transfers.")
  notSupported: "not-supported",

  @doc("Fast Funds is not supported on this card. Transfer will follow regular settlement timing.")
  standard: "standard",

  @doc("Funds will be available to destination within 30 minutes of the authorization.")
  fastFunds: "fast-funds",

  @doc("It is unknown if this card is eligible for domestic push-to-card transfers.")
  `unknown`: "unknown",
}

@doc("Indicates if the card supports domestic pull-from-card transfer.")
@example(DomesticPullFromCard.supported)
enum DomesticPullFromCard {
  @doc("This card is ineligible for domestic pull-from-card transfers.")
  notSupported: "not-supported",

  @doc("This card supports pull-from-card transfers.")
  supported: "supported",

  @doc("It is unknown if this card is eligible for domestic pull-from-card transfers.")
  `unknown`: "unknown",
}

const exampleCardAccountUpdater = #{
  updatedOn: utcDateTime.fromISO("2024-05-06T12:20:38.184Z"),
  updateType: CardUpdateReason.numberUpdate,
};

@doc("The results of the most recent card update request.")
@example(exampleCardAccountUpdater)
model CardAccountUpdater {
  updatedOn?: utcDateTime;
  updateType?: CardUpdateReason;
}

@doc("The results of the card update request.")
@example(CardUpdateReason.numberUpdate)
enum CardUpdateReason {
  unspecified: "unspecified",
  accountClosed: "account-closed",
  contactCardholder: "contact-cardholder",
  expirationUpdate: "expiration-update",
  noChange: "no-change",
  noMatch: "no-match",
  numberUpdate: "number-update",
}

// Requests

model LinkCard {
  e2ee?: End2EndToken;
  cardNumber: string;
  cardCvv: string;
  expiration: CardExpiration;
  holderName: string;
  billingAddress: Address;
  cardOnFile: boolean;
  merchantAccountID?: string;
  verifyName: boolean;
}

enum LinkCardWaitFor {
  paymentMethod: "payment-method",
}

model UpdateCard {
  e2ee: End2EndToken;
  billingAddress?: UpdateAddress;
  expiration?: UpdateCardExpiration;
  cardCvv?: string;
  cardOnFile?: boolean;
  merchantAccountID?: string;
  verifyName?: boolean;
  holderName?: string;
}

model UpdateCardExpiration {
  month?: string;
  year?: string;
}

// Errors

model LinkCardError {
  e2ee?: End2EndTokenError;
  cardNumber?: string;
  cardCvv?: string;
  expiration?: CardExpirationError;
  holderName?: string;
  billingAddress?: AddressError;
  cardOnFile?: string;
  merchantAccountID?: string;
  verifyName?: string;
}

model CardExpirationError {
  month?: string;
  year?: string;
}

model UpdateCardError {
  e2ee?: End2EndTokenError;
  billingAddress?: AddressError;
  expiration?: CardExpirationError;
  cardCvv?: string;
  cardOnFile?: string;
  merchantAccountID?: string;
  verifyName?: string;
  holderName?: string;
}
