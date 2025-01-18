import "@typespec/http";
import "./models.agreement.tsp";
import "./models.billing.tsp";
import "../auth/models.auth.tsp";
import "../common/models.header.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;

namespace MoovAPI;

@get
@route("/accounts/{accountID}/fee-plans")
@tag("Billing")
@doc("""
  List all fee plans available for use by an account. This is intended to be used by an account when 
  selecting a fee plan to apply to a connected account.
  
  To access this endpoint using a [token](https://docs.moov.io/api/authentication/access-tokens/) you'll need 
  to specify the `/accounts/{accountID}/profile.read` scope.
  """)
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/profile.read"]>)
op listFeePlans(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @doc("A comma-separated list of plan IDs to filter the results by.")
  @query
  planIDs?: string[],
): ListResponses<FeePlan>;

@get
@route("/accounts/{accountID}/fee-plan-agreements")
@tag("Billing")
@doc("""
  List all fee plan agreements associated with an account.
  
  To access this endpoint using a [token](https://docs.moov.io/api/authentication/access-tokens/) you'll need 
  to specify the `/accounts/{accountID}/profile.read` scope.
  """)
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/profile.read"]>)
op listFeePlanAgreements(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @doc("A comma-separated list of agreement IDs to filter the results by.")
  @query
  agreementID?: string[],

  @doc("A comma-separated list of statuses to filter the results by.")
  @query
  status?: FeePlanAgreementStatus[],
): ListResponses<FeePlanAgreement>;

@post
@route("/accounts/{accountID}/fee-plan-agreements")
@tag("Billing")
@doc("""
  Creates the subscription of a fee plan to a merchant account. Merchants are required to accept the fee plan terms prior to activation.
  
  To access this endpoint using a [token](https://docs.moov.io/api/authentication/access-tokens/) you'll need 
  to specify the `/accounts/{accountID}/profile.write` scope.
  """)
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/profile.write"]>)
op createFeePlanAgreements(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @body body: CreateFeePlanAgreement,
): PostResponsesCreated<FeePlanAgreement, FeePlanAgreementError>;

@get
@route("/accounts/{accountID}/partner-pricing")
@tag("Billing")
@doc("""
  List all partner pricing plans available for use by an account.
  
  To access this endpoint using a [token](https://docs.moov.io/api/authentication/access-tokens/) you'll need 
  to specify the `/accounts/{accountID}/profile.read` scope.
  """)
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/profile.read"]>)
op listPartnerPricing(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @doc("A comma-separated list of plan IDs to filter the results by.")
  @query
  planIDs?: string[],
): ListResponses<PartnerPricing>;

@get
@route("/accounts/{accountID}/partner-pricing-agreements")
@tag("Billing")
@doc("""
  List all partner pricing agreements associated with an account.
  
  To access this endpoint using a [token](https://docs.moov.io/api/authentication/access-tokens/) you'll need 
  to specify the `/accounts/{accountID}/profile.read` scope.
  """)
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/profile.read"]>)
op listPartnerPricingAgreements(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @doc("A comma-separated list of agreement IDs to filter the results by.")
  @query
  agreementID?: string[],

  @doc("A comma-separated list of statuses to filter the results by.")
  @query
  status?: FeePlanAgreementStatus[],
): ListResponses<PartnerPricingAgreement>;
