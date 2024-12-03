import "@typespec/http";
import "./examples.paymentmethod.tsp";
import "./models.paymentmethod.tsp";
import "../auth/models.auth.tsp";
import "../common/examples.id.tsp";
import "../common/models.response.tsp";
import "../common/models.header.tsp";
import "../common/models.parameter.tsp";

using TypeSpec.Http;

namespace MoovAPI;

// List

@doc("""
  Retrieve a list of payment methods associated with a Moov account. Read our [payment methods guide](https://docs.moov.io/guides/money-movement/payment-methods/) to learn more.
  
  To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/payment-methods.read` scope when generating a [token](https://docs.moov.io/api/authentication/access-tokens/).
  """)
@tag("Payment methods")
@route("/accounts/{accountID}/payment-methods")
@get
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/payment-methods.read"]>)
@opExample(#{
  parameters: #{ accountID: ExampleID },
  returnType: #{
    statusCode: HttpStatusOK,
    body: #[ExampleMoovWalletPaymentMethod, ExampleApplePayPaymentMethod],
  },
})
op listPaymentMethods(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @doc("""
    Optional parameter to filter the account's payment methods by source ID. A source ID can be a [walletID](https://docs.moov.io/api/sources/wallets/list/), [cardID](https://docs.moov.io/api/sources/cards/list/), or [bankAccountID](https://docs.moov.io/api/sources/bank-accounts/list/).
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

@doc("""
  Get the specified payment method associated with a Moov account. Read our [payment methods guide](https://docs.moov.io/guides/money-movement/payment-methods/) to learn more.
  
  To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/payment-methods.read` scope when generating a [token](https://docs.moov.io/api/authentication/access-tokens/).
  """)
@tag("Payment methods")
@route("/accounts/{accountID}/payment-methods/{paymentMethodID}")
@get
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/payment-methods.read"]>)
@opExample(#{
  parameters: #{ accountID: ExampleID, paymentMethodID: ExampleID },
  returnType: #{
    statusCode: HttpStatusOK,
    body: ExampleMoovWalletPaymentMethod,
  },
})
op getPaymentMethod(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @path
  paymentMethodID: PaymentMethodID,
): GetResponses<PaymentMethod>;
