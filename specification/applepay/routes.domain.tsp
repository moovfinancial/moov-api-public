import "@typespec/http";
import "@typespec/openapi";
import "./models.domain.tsp";
import "../auth/models.auth.tsp";
import "../common/models.response.tsp";
import "../common/models.header.tsp";
import "../common/models.parameter.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

@post
@route("/accounts/{accountID}/apple-pay/domains")
@tag("Apple pay")
@doc("""
  Add domains to be registered with Apple Pay.
  
  Any domains that will be used to accept payments must first be [verified](https://docs.moov.io/guides/sources/cards/apple-pay/#register-your-domains) 
  with Apple.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/apple-pay.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/apple-pay.write"]>)
@extension("x-speakeasy-name-override", "registerMerchantDomains")
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
  | RateLimitedResponse
  | InternalServerErrorResponse
  | GatewayTimeoutResponse;

@patch
@route("/accounts/{accountID}/apple-pay/domains")
@tag("Apple pay")
@doc("""
  Add or remove domains to be registered with Apple Pay. 
  
  Any domains that will be used to accept payments must first be [verified](https://docs.moov.io/guides/sources/cards/apple-pay/#register-your-domains) 
  with Apple.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/apple-pay.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/apple-pay.write"]>)
@extension("x-speakeasy-name-override", "updateMerchantDomains")
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
  | RateLimitedResponse
  | InternalServerErrorResponse
  | GatewayTimeoutResponse;

@get
@tag("Apple pay")
@route("/accounts/{accountID}/apple-pay/domains")
@doc("""
  Get domains registered with Apple Pay. 
  
  Read our [Apple Pay tutorial](https://docs.moov.io/guides/sources/cards/apple-pay/#register-your-domains) to learn more. 
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/apple-pay.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/apple-pay.read"]>)
@extension("x-speakeasy-name-override", "getMerchantDomains")
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
  | RateLimitedResponse
  | InternalServerErrorResponse
  | GatewayTimeoutResponse;
