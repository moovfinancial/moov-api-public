import "../common/models.id.tsp";

namespace MoovAPI;

const exampleBasicPaymentMethod = #{
  paymentMethodID: exampleID,
  paymentMethodType: PaymentMethodType.moovWallet,
};

@example(exampleBasicPaymentMethod)
model BasicPaymentMethod {
  paymentMethodID: string;
  paymentMethodType: PaymentMethodType;
}

enum PaymentMethodType {
  moovWallet: "moov-wallet",
  achDebitFund: "ach-debit-fund",
  achDebitCollect: "ach-debit-collect",
  achCreditStandard: "ach-credit-standard",
  achCreditSameDay: "ach-credit-same-day",
  rtpCredit: "rtp-credit",
  cardPayment: "card-payment",
  applePay: "apple-pay",
  pushToCard: "push-to-card",
  pullFromCard: "pull-from-card",
}
