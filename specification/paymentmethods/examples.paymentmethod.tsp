import "./models.paymentmethod.tsp";
import "../common/examples.id.tsp";

namespace MoovAPI;

const ExampleBasicPaymentMethod: BasicPaymentMethod = #{
  paymentMethodID: ExampleID,
  paymentMethodType: PaymentMethodType.moovWallet,
};

const ExampleMoovWalletPaymentMethod: MoovWalletPaymentMethod = #{
  paymentMethodID: ExampleID,
  paymentMethodType: PaymentMethodType.moovWallet,
  wallet: #{},
};

const ExampleApplePayPaymentMethod: ApplePayPaymentMethod = #{
  paymentMethodID: ExampleID,
  paymentMethodType: PaymentMethodType.applePay,
  applePay: #{},
};
