import "@typespec/http";
import "../paymentmethods/models.paymentmethod.tsp";

using TypeSpec.Http;

namespace MoovAPI;

@doc("""
    The JSON structure returned from Apple Pay when authorizing a payment session.
  
    Refer to [Apple's documentation](https://developer.apple.com/documentation/apple_pay_on_the_web/applepaypayment) 
    for more information.
  """)
model LinkApplePay {
  token: LinkApplePayToken;
  billingContact?: AppleBillingContact;
}

@doc("""
    Contains the user's payment information as returned from Apple Pay.
  
    Refer to [Apple's documentation](https://developer.apple.com/documentation/apple_pay_on_the_web/applepaypaymenttoken) 
    for more information.
  """)
model LinkApplePayToken {
  paymentData: LinkApplePaymentData;
  paymentMethod: LinkApplePaymentMethod;

  @doc("A unique identifier provided by Apple Pay for this payment.")
  @example("32b...4f3")
  transactionIdentifier: string;
}

@doc("""
    Contains the encrypted payment data.
  
    Refer to [Apple's documentation](https://developer.apple.com/documentation/apple_pay_on_the_web/applepaypaymenttoken/1916115-paymentdata) 
    for more information.
  """)
model LinkApplePaymentData {
  @doc("""
    Specifies the encryption used for the payment token ("EC_v1" or "RSA_v1").
    """)
  @example("EC_v1")
  version: string;

  @doc("The encrypted, base64-encoded payment data.")
  @example("3+f4oOTwPa6f1UZ6tG...CE=")
  data: string;

  @doc("A base64 encoded signature of the payment and header data.")
  @example("MIAGCSqGSIb3DQ.AAAA==")
  signature: string;

  header: ApplePayHeader;
}

@doc("""
  Information needed to decrypt Apple Pay payment data.
  
  Refer to [Apple's documentation](https://developer.apple.com/documentation/passkit/payment-token-format-reference#Header-keys-and-values) 
  for more information.
  """)
model ApplePayHeader {
  @doc("Base64-encoded ephemeral public key, used for ECC-encrypted payment data.")
  @example("MFkwEK...Md==")
  ephemeralPublicKey?: string;

  @doc("A base64-encoded, SHA-256 hash of the merchant's public key.")
  @example("l0CnXdMv...D1I=")
  publicKeyHash: string;

  @doc("A device-generated identifier for the transaction.")
  @example("32b...4f3")
  transactionId: string;
}

@doc("""
    Provides information about the underlying card.
  
    Refer to [Apple's documentation](https://developer.apple.com/documentation/apple_pay_on_the_web/applepaypaymenttoken/1916113-paymentmethod) 
    for more information.
  """)
model LinkApplePaymentMethod {
  @doc("A display-friendly discription of the card.")
  @example("Visa 1234")
  displayName: string;

  @doc("The card's payment network.")
  @example("Visa")
  network: string;

  @doc("The type of card.")
  @example("debit")
  type: string;
}

@doc("""
    Billing contact information as returned from Apple Pay.
    
    Refer to [Apple's documentation](https://developer.apple.com/documentation/apple_pay_on_the_web/applepaypaymentcontact) 
    for more information.
  """)
model AppleBillingContact {
  @doc("Address lines 1 and 2 for the contact.")
  @example(#["123 Sesame Street"])
  addressLines?: string[];

  @doc("The contact's city.")
  @example("Phoenix")
  locality?: string;

  @doc("The contact's postal code.")
  @example("30345")
  postalCode?: string;

  @doc("The contact's two-letter state code.")
  @example("AZ")
  administrativeArea?: string;

  @doc("The contact's two-letter ISO 3166")
  @example("US")
  countryCode?: string;
}

model LinkApplePayError {
  @doc("Describes an error that wasn't attributable to a single request field.")
  error?: string;

  @doc("Describes an error within the `token.paymentData` request field.")
  paymentData?: string;

  @doc("Describes an error within the `token.paymentMethod` request field.")
  paymentMethod?: string;

  @doc("Describes an error within the `token.transactionIdentifier` request field.")
  transactionIdentifier?: string;
}

model LinkedApplePayPaymentMethod {
  @doc("The new payment method's ID.")
  @format("uuid")
  paymentMethodID: string;

  paymentMethodType: PaymentMethodType;
  applePay: ApplePayResponse;
}

@doc("Describes an Apple Pay token on a Moov account.")
model ApplePayResponse {
  brand: CardBrand;
  cardType: CardType;

  @doc("""
      User-friendly name of the tokenized card returned by Apple.
      
      It usually contains the brand and the last four digits of the underlying card.
      There is no standard format.
    """)
  @example("Visa 1256")
  cardDisplayName: string;

  fingerprint: CardFingerprint;
  expiration: CardExpiration;

  @doc("The last four digits of the Apple Pay token, which may differ from the tokenized card's last four digits.")
  dynamicLastFour: string;

  @doc("Country where the underlying card was issued.")
  @example("US")
  issuerCountry?: string;
}
