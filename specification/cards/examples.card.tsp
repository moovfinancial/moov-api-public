import "../common/examples.id.tsp";

namespace MoovAPI;

const exampleCard: Card = #{
  cardID: ExampleID,
  fingerprint: exampleCardFingerprint,
  brand: CardBrand.visa,
  cardType: CardType.credit,
  cardCategory: "CLASSIC",
  lastFourCardNumber: "1111",
  bin: "411111",
  expiration: exampleCardExpiration,
  holderName: "Jules Jackson",
  billingAddress: exampleCardAddress,
  cardVerification: exampleCardVerification,
  issuer: "GRINGOTTS BANK",
  issuerCountry: "US",
  issuerURL: "HTTPS://WWW.EXAMPLE.COM/",
  issuerPhone: "8185551212",
  commercial: false,
  regulated: false,
  cardOnFile: true,
  merchantAccountID: ExampleID,
  cardAccountUpdater: exampleCardAccountUpdater,
  domesticPushToCard: DomesticPushToCard.standard,
  domesticPullFromCard: DomesticPullFromCard.supported,
};

const exampleLinkCardOperation: OperationExample = #{
  parameters: #{
    xWaitFor: LinkCardWaitFor.paymentMethod,
    accountID: ExampleID,
    body: #{
      cardNumber: "4111111111111111",
      cardCvv: "123",
      expiration: exampleCardExpiration,
      holderName: "Jules Jackson",
      billingAddress: #{ postalCode: "80301" },
    },
  },
  returnType: #{
    xRequestID: ExampleID,
    statusCode: HttpStatusOK,
    body: #{
      ...exampleCard,
      paymentMethods: #[
        #{
          paymentMethodID: ExampleID,
          paymentMethodType: PaymentMethodType.cardPayment,
        },
        #{
          paymentMethodID: ExampleID,
          paymentMethodType: PaymentMethodType.pushToCard,
        },
        #{
          paymentMethodID: ExampleID,
          paymentMethodType: PaymentMethodType.pullFromCard,
        }
      ],
    },
  },
};
