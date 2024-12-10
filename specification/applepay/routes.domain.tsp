import "@typespec/http";
import "./models.domain.tsp";
import "../auth/models.auth.tsp";
import "../common/models.response.tsp";
import "../common/models.header.tsp";
import "../common/models.parameter.tsp";

using TypeSpec.Http;

namespace MoovAPI;

@doc("""
  Add domains to be registered with Apple Pay.
  
  Any domains that will be used to accept payments must first be [verified](https://docs.moov.io/guides/sources/cards/apple-pay/#register-your-domains) 
  with Apple.
  
  To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/apple-pay.write` scope when generating a 
  [token](https://docs.moov.io/api/authentication/access-tokens/).
  """)
@tag("Cards")
@route("/accounts/{accountID}/apple-pay/domains")
@post
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/apple-pay.write"]>)
op registerApplePayMerchantDomains(
  ...CommonHeaders,

  @doc("ID of the Moov account representing the merchant.")
  @format("uuid")
  @path
  accountID: string,

  @body body: RegisterApplePayMerchantDomains,
):
  | OkResponse<ApplePayMerchantDomains>
  | BadRequestResponse
  | UnauthorizedResponse
  | ForbiddenResponse
  | DomainsAlreadyRegisteredResponse
  | DomainNotVerifiedResponse
  | RateLimitedResponse;

@doc("""
    Add or remove domains to be registered with Apple Pay. 
  
    Any domains that will be used to accept payments must first be [verified](https://docs.moov.io/guides/sources/cards/apple-pay/#register-your-domains) 
    with Apple.
    
    To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/apple-pay.write` scope when generating a 
    [token](https://docs.moov.io/api/authentication/access-tokens/).
  """)
@tag("Cards")
@route("/accounts/{accountID}/apple-pay/domains")
@patch
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/apple-pay.write"]>)
op updateApplePayMerchantDomains(
  ...CommonHeaders,

  @doc("ID of the Moov account representing the merchant.")
  @format("uuid")
  @path
  accountID: string,

  @body body: UpdateApplePayMerchantDomains,
):
  | NoContentResponse
  | BadRequestResponse
  | UnauthorizedResponse
  | ForbiddenResponse
  | NotFoundResponse
  | DomainsAlreadyRegisteredResponse
  | DomainNotVerifiedResponse
  | RateLimitedResponse;

@doc("""
    Get domains registered with Apple Pay. 
    
    Read our [Apple Pay tutorial](https://docs.moov.io/guides/sources/cards/apple-pay/#register-your-domains) to learn more. 
    
    To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/apple-pay.read` scope when generating a 
    [token](https://docs.moov.io/api/authentication/access-tokens/).
  """)
@tag("Cards")
@route("/accounts/{accountID}/apple-pay/domains")
@get
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/apple-pay.read"]>)
op getApplePayMerchantDomains(
  ...CommonHeaders,

  @doc("ID of the Moov account representing the merchant.")
  @format("uuid")
  @path
  accountID: string,
):
  | OkResponse<ApplePayMerchantDomains>
  | UnauthorizedResponse
  | ForbiddenResponse
  | NotFoundResponse
  | RateLimitedResponse;
