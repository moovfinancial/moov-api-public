import "./models.paymentmethod.tsp";
import "../common/examples.id.tsp";
import "../cards/models.card.tsp";

namespace MoovAPI;

const ExampleBasicPaymentMethod: BasicPaymentMethod = #{
  paymentMethodID: ExampleID,
  paymentMethodType: PaymentMethodType.moovWallet,
};

const ExampleMoovWalletPaymentMethod: MoovWalletPaymentMethod = #{
  paymentMethodID: ExampleID,
  paymentMethodType: PaymentMethodType.moovWallet,
  wallet: #{ walletID: ExampleID },
};

const ExampleApplePayPaymentMethod: ApplePayPaymentMethod = #{
  paymentMethodID: ExampleID,
  paymentMethodType: PaymentMethodType.applePay,
  applePay: #{
    brand: CardBrand.visa,
    cardType: CardType.credit,
    cardDisplayName: "Visa 1256",
    fingerprint: exampleCardFingerprint,
    expiration: exampleCardExpiration,
    dynamicLastFour: "1256",
    issuerCountry: "US",
  },
};
