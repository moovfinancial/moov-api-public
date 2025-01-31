import "@typespec/http";
import "@typespec/openapi";
import "./models.paymentlink.tsp";
import "../auth/models.auth.tsp";
import "../common/models.header.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

@post
@route("/accounts/{accountID}/payment-links")
@tag("Payment links")
@doc("""
  Create a payment link that allows an end user to make a payment on Moov's hosted payment link page.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/transfers.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.write"]>)
@extension("x-speakeasy-name-override", "create")
op createPaymentLink(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  accountID: string,

  @body body: CreatePaymentLink,
): PostResponses<PaymentLink, CreatePaymentLinkError>;

@get
@route("/accounts/{accountID}/payment-links")
@tag("Payment links")
@doc("""
  List all the payment links created under a Moov account.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/transfers.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.read"]>)
@extension("x-speakeasy-name-override", "list")
op listPaymentLinks(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  accountID: string,
): ListResponses<PaymentLink>;

@get
@route("/accounts/{accountID}/payment-links/{paymentLinkCode}")
@tag("Payment links")
@doc("""
  Retrieve a payment link by code.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/transfers.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.read"]>)
@extension("x-speakeasy-name-override", "get")
op getPaymentLink(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  accountID: string,

  @path
  paymentLinkCode: PaymentLinkCode,
): GetResponses<PaymentLink>;

@patch
@route("/accounts/{accountID}/payment-links/{paymentLinkCode}")
@tag("Payment links")
@doc("""
  Update a payment link.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/transfers.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.write"]>)
@extension("x-speakeasy-name-override", "update")
op updatePaymentLink(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  accountID: string,

  @path
  paymentLinkCode: PaymentLinkCode,

  @body body: UpdatePaymentLink,
): UpdateResponses<PaymentLink, UpdatePaymentLinkError>;

@delete
@route("/accounts/{accountID}/payment-links/{paymentLinkCode}")
@tag("Payment links")
@doc("""
  Disable a payment link.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/transfers.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.write"]>)
@extension("x-speakeasy-name-override", "disable")
op disablePaymentLink(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  accountID: string,

  @path
  paymentLinkCode: PaymentLinkCode,
): NoContentResponse;

@get
@route("/accounts/{accountID}/payment-links/{paymentLinkCode}/qrcode")
@tag("Payment links")
@doc("""
  Retrieve the payment link encoded in a QR code. 
  
  Use the `Accept` header to specify the format of the response. Supported formats are `application/json` and `image/png`.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/transfers.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.write"]>)
@extension("x-speakeasy-name-override", "getQRCode")
op getPaymentLinkQRCode(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  accountID: string,

  @path
  paymentLinkCode: PaymentLinkCode,
):
  | QRCodeJSON
  | QRCodeImage
  | UnauthorizedResponse
  | ForbiddenResponse
  | NotFoundResponse
  | RateLimitedResponse
  | InternalServerErrorResponse
  | GatewayTimeoutResponse;
