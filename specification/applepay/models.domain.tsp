import "@typespec/http";

using TypeSpec.Http;

namespace MoovAPI;

model RegisterApplePayMerchantDomains {
  displayName?: DomainDisplayName;

  @doc("A unique list of fully-qualified, top-level or sub-domain names where you will accept Apple Pay.")
  @example(#["checkout.classbooker.dev"])
  domains?: string[];
}

model ApplePayMerchantDomains {
  accountID: string;
  displayName: DomainDisplayName;

  @doc("A unique list of fully-qualified, top-level or sub-domain names where you will accept Apple Pay.")
  @example(#["checkout.classbooker.dev"])
  domains: string[];

  createdOn: utcDateTime;
  updatedOn: utcDateTime;
}

model UpdateApplePayMerchantDomains {
  @doc("A unique list of fully-qualified, top-level or sub-domain names to add.")
  @example(#["pay.classbooker.dev"])
  addDomains?: string[];

  @doc("A unique list of fully-qualified, top-level or sub-domain names to remove.")
  @example(#["checkout.classbooker.dev"])
  removeDomains?: string[];
}

@doc("A UTF-8 string to display in the Buy button.")
@maxLength(64)
scalar DomainDisplayName extends string;

@doc("The requested domains were not verified.")
model DomainNotVerifiedResponse {
  @statusCode statusCode: HttpsStatusExpectationFailed;
}

@doc("Apple Pay domains are already registered for this account.")
model DomainsAlreadyRegisteredResponse {
  @statusCode statusCode: HttpStatusConflict;
}
