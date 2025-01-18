namespace MoovAPI;

@doc("Describes underwriting values (in USD) used for card payment acceptance.")
model Underwriting {
  averageTransactionSize: int64;
  maxTransactionSize: int64;
  averageMonthlyTransactionVolume: int64;
  status: UnderwritingStatus;
  volumeByCustomerType: VolumeByCustomerType;
  cardVolumeDistribution: CardVolumeDistribution;
  fulfillment: FulfillmentDetails;
}

model VolumeByCustomerType {
  businessToBusinessPercentage: int32;
  consumerToBusinessPercentage: int32;
}

model CardVolumeDistribution {
  ecommercePercentage: int32;
  cardPresentPercentage: int32;
  mailOrPhonePercentage: int32;
  debtRepaymentPercentage: int32;
}

model FulfillmentDetails {
  hasPhysicalGoods: boolean;
  isShippingProduct: boolean;
  shipmentDurationDays: int64;
  returnPolicy: ReturnPolicyType;
}

model UpdateUnderwriting {
  averageTransactionSize: int64;
  maxTransactionSize: int64;
  averageMonthlyTransactionVolume: int64;
  volumeByCustomerType: VolumeByCustomerType;
  cardVolumeDistribution: CardVolumeDistribution;
  fulfillment: FulfillmentDetails;
}

model UpdateUnderwritingError {
  error: {
    averageMonthlyTransactionVolume?: string;
    averageTransactionSize?: string;
    maxTransactionSize?: string;
    volumeByCustomerType?: VolumeByCustomerTypeError;
    cardVolumeDistribution?: CardVolumeDistributionError;
    fulfillment?: FulfillmentDetailsError;
  };
}

model VolumeByCustomerTypeError {
  businessToBusinessPercentage?: string;
  consumerToBusinessPercentage?: string;
}

model CardVolumeDistributionError {
  ecommercePercentage?: string;
  cardPresentPercentage?: string;
  mailOrPhonePercentage?: string;
  debtRepaymentPercentage?: string;
}

model FulfillmentDetailsError {
  shipmentDurationDays?: string;
  returnPolicy?: string;
}

#deprecated "This field is deprecated and will be removed in a future release."
enum UnderwritingStatus {
  approved,
  rejected,
  pendingReview,
  pending,
  notRequested,
}

enum ReturnPolicyType {
  none,
  exchangeOnly,
  withinThirtyDays,
  other,
}
