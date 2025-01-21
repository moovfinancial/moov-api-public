import "./models.paymentlink.tsp";

namespace MoovAPI;

const ExampleCreatePaymentRequest: CreatePaymentLink = #{
  partnerAccountID: "d290f1ee-6c54-4b01-90e6-d701748f0851",
  merchantPaymentMethodID: "4c4e7f8e-81f4-4f3d-8f6f-6f6e7f8e4c4e",
  amount: #{ currency: "USD", value: 10000 },
  display: #{
    title: "Example Payment Link",
    description: "This is an example payment link.",
    callToAction: CallToAction.pay,
  },
  customer: #{ requirePhone: true },
  payment: #{
    allowedMethods: #[
      CollectionPaymentMethodType.cardPayment,
      CollectionPaymentMethodType.achDebitCollect
    ],
  },
};

const ExampleUpdatePaymentLink: UpdatePaymentLink = #{
  amount: #{ currency: "USD", value: 12099 },
  customer: #{ requirePhone: true, requireAddress: true },
};

const ExampleCreatedPaymentLink: PaymentLink = #{
  code: "3QLHtONjd5",
  mode: Mode.sandbox,
  status: PaymentLinkStatus.active,
  partnerAccountID: "d290f1ee-6c54-4b01-90e6-d701748f0851",
  merchantAccountID: "34233b72-780c-4e0e-8b08-cbbe1bc878f8",
  merchantPaymentMethodID: "4c4e7f8e-81f4-4f3d-8f6f-6f6e7f8e4c4e",
  link: "https://moov.money/3QLHtONjd5",
  amount: #{ currency: "USD", value: 10000 },
  uses: 0,
  display: #{
    title: "Example Payment Link",
    description: "This is an example payment link.",
    callToAction: CallToAction.pay,
  },
  customer: #{ requirePhone: true },
  payment: #{
    allowedMethods: #[
      CollectionPaymentMethodType.cardPayment,
      CollectionPaymentMethodType.achDebitCollect
    ],
  },
  updatedOn: utcDateTime.fromISO("2025-01-09T17:09:13.33Z"),
  createdOn: utcDateTime.fromISO("2025-01-09T17:09:13.33Z"),
};
