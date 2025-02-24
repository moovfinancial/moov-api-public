import "./models.transfer.tsp";

namespace MoovAPI;

const ExampleCreateCardToWalletTransfer: CreateTransfer = #{
  source: #{ paymentMethodID: "9506dbf6-4208-44c3-ad8a-e4431660e1f2" },
  destination: #{ paymentMethodID: "3f9969cf-a1f3-4d83-8ddc-229a506651cf" },
  amount: #{ currency: "USD", value: 32945 },
  description: "Transfer from card to wallet",
  metadata: #{ optional: "metadata" },
};

const ExamplePendingCardToWalletTransfer: Transfer = #{
  transferID: "d835gf30-4b19-4850-a9b2-c0624c41ecb3",
  source: #{
    paymentMethodID: "9506dbf6-4208-44c3-ad8a-e4431660e1f2",
    paymentMethodType: "card-payment",
    account: #{
      accountID: "7e4b26c2-b399-49ef-8390-50e1ea44d550",
      email: "jules@julesjackson.com",
      displayName: "Jules Jackson",
    },
    card: #{
      cardID: "aefd5563-93c6-413c-875e-1bd0ebfc116d",
      fingerprint: "2f5d782ceef1c3bd31ed5...",
      brand: CardBrand.visa,
      cardType: CardType.credit,
      lastFourCardNumber: "2000",
      bin: "400020",
      expiration: #{ month: "01", year: "28" },
      holderName: "Jules Jackson",
      billingAddress: #{ postalCode: "80301" },
      cardCategory: "credit",
      issuerURL: "https://www.visa.com",
      issuerPhone: "+18001234567",
      domesticPushToCard: DomesticPushToCard.standard,
      domesticPullFromCard: DomesticPullFromCard.supported,
      cardVerification: #{
        cvv: CardVerificationResult.unavailable,
        addressLine1: CardVerificationResult.unavailable,
        postalCode: CardVerificationResult.unavailable,
        accountName: #{
          firstName: CardVerificationResult.unavailable,
          lastName: CardVerificationResult.unavailable,
          middleName: CardVerificationResult.unavailable,
          fullName: CardVerificationResult.unavailable,
        },
      },
      issuer: "Moov Visa Sandbox",
      issuerCountry: "US",
      cardAccountUpdater: #{},
    },
    cardDetails: #{
      status: CardTransactionStatus.confirmed,
      dynamicDescriptor: "WhlBdy *Yoga 11-12",
      confirmedOn: utcDateTime.fromISO("2025-01-21T21:32:16.799681237Z"),
    },
  },
  destination: #{
    paymentMethodID: "3f9969cf-a1f3-4d83-8ddc-229a506651cf",
    paymentMethodType: "moov-wallet",
    account: #{
      accountID: "34233b72-780c-4a0d-8b08-cbbe23k878f8",
      email: "john@wholebodyfitness.io",
      displayName: "Whole Body Fitness",
    },
    wallet: #{ walletID: "744b2e78-8cc8-4a6a-af42-611e3b844503" },
  },
  status: TransferStatus.pending,
  amount: #{ currency: "USD", value: 32945 },
  description: "Transfer from card to wallet",
  createdOn: utcDateTime.fromISO("2025-01-21T21:32:16Z"),
};
