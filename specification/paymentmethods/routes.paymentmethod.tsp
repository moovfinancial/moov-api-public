import "@typespec/http";
import "@typespec/openapi";
import "./examples.paymentmethod.tsp";
import "./models.paymentmethod.tsp";
import "../auth/models.auth.tsp";
import "../common/examples.id.tsp";
import "../common/models.response.tsp";
import "../common/models.header.tsp";
import "../common/models.parameter.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

// List

@get
@route("/accounts/{accountID}/payment-methods")
@tag("Payment methods")
@doc("""
  Retrieve a list of payment methods associated with a Moov account. Read our [payment methods 
  guide](https://docs.moov.io/guides/money-movement/payment-methods/) to learn more.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/payment-methods.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/payment-methods.read"]>)
@opExample(#{
  parameters: #{ accountID: ExampleID },
  returnType: #{
    xRequestID: ExampleID,
    statusCode: HttpStatusOK,
    body: #[ExampleMoovWalletPaymentMethod, ExampleApplePayPaymentMethod],
  },
})
@extension("x-speakeasy-name-override", "list")
op listPaymentMethods(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  accountID: string,

  @doc("""
    Optional parameter to filter the account's payment methods by source ID. 
    
    A source ID can be a [walletID](https://docs.moov.io/api/sources/wallets/list/), [cardID](https://docs.moov.io/api/sources/cards/list/), 
    or [bankAccountID](https://docs.moov.io/api/sources/bank-accounts/list/).
    """)
  @format("uuid")
  @query
  sourceID?: string,

  @doc("""
    Optional parameter to filter the account's payment methods by payment method type.
    """)
  @query
  paymentMethodType?: PaymentMethodType,
): ListResponses<PaymentMethod>;

// Get

@get
@route("/accounts/{accountID}/payment-methods/{paymentMethodID}")
@tag("Payment methods")
@doc("""
  Get the specified payment method associated with a Moov account. Read our [payment methods guide](https://docs.moov.io/guides/money-movement/payment-methods/) to learn more.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/payment-methods.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/payment-methods.read"]>)
@opExample(#{
  parameters: #{ accountID: ExampleID, paymentMethodID: ExampleID },
  returnType: #{
    xRequestID: ExampleID,
    statusCode: HttpStatusOK,
    body: ExampleMoovWalletPaymentMethod,
  },
})
@extension("x-speakeasy-name-override", "get")
op getPaymentMethod(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  accountID: string,

  @path
  paymentMethodID: PaymentMethodID,
): GetResponses<PaymentMethod>;
