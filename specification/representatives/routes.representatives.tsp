import "@typespec/http";
import "@typespec/openapi";
import "../representatives/models.representatives.tsp";
import "../auth/models.auth.tsp";
import "../common/models.header.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

@post
@route("/accounts/{accountID}/representatives")
@tag("Representatives")
@doc("""
  Moov accounts associated with businesses require information regarding individuals who represent the business. 
  You can provide this information by creating a representative. Each account is allowed a maximum of 7 representatives. 
  Read our [business representatives guide](https://docs.moov.io/guides/accounts/requirements/business-representatives/) to learn more.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/representatives.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/representatives.write"]>)
@extension("x-speakeasy-name-override", "create")
op createRepresentative(
  ...CommonHeaders,

  @doc("ID of the account.")
  @format("uuid")
  @path
  accountID: string,

  @body body: CreateRepresentative,
): PostResponses<Representative, RepresentativeValidationError>;

@get
@route("/accounts/{accountID}/representatives")
@tag("Representatives")
@doc("""
  A Moov account may have multiple representatives depending on the associated business's ownership and management structure. 
  You can use this method to list all the representatives for a given Moov account. 
  Note that Moov accounts associated with an individual do not have representatives. 
  Read our [business representatives guide](https://docs.moov.io/guides/accounts/requirements/business-representatives/) to learn more.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/representatives.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/representatives.read"]>)
@extension("x-speakeasy-name-override", "list")
op listRepresentatives(
  ...CommonHeaders,

  @doc("ID of the account.")
  @format("uuid")
  @path
  accountID: string,
): ListResponses<Representative>;

@delete
@route("/accounts/{accountID}/representatives/{representativeID}")
@tag("Representatives")
@doc("""
  Deletes a business representative associated with a Moov account. Read our [business representatives guide](https://docs.moov.io/guides/accounts/requirements/business-representatives/) to learn more.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/representatives.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/representatives.write"]>)
@extension("x-speakeasy-name-override", "delete")
op deleteRepresentative(
  ...CommonHeaders,

  @doc("ID of the account.")
  @format("uuid")
  @path
  accountID: string,

  @doc("ID of the representative.")
  @format("uuid")
  @path
  representativeID: string,
): DisableResponses;

@get
@route("/accounts/{accountID}/representatives/{representativeID}")
@tag("Representatives")
@doc("""
  Retrieve a specific representative associated with a given Moov account. Read our [business representatives guide](https://docs.moov.io/guides/accounts/requirements/business-representatives/) to learn more.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/representatives.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/representatives.read"]>)
@extension("x-speakeasy-name-override", "get")
op getRepresentative(
  ...CommonHeaders,

  @doc("ID of the account.")
  @format("uuid")
  @path
  accountID: string,

  @doc("ID of the representative.")
  @format("uuid")
  @path
  representativeID: string,
): GetResponses<Representative>;

@patch
@route("/accounts/{accountID}/representatives/{representativeID}")
@tag("Representatives")
@doc("""
  If a representative's information has changed you can patch the information associated with a specific representative ID. 
  Read our [business representatives guide](https://docs.moov.io/guides/accounts/requirements/business-representatives/) to learn more.
  
  When **can** profile data be updated:
  
  - For unverified representatives, all profile data can be edited.
  - During the verification process, missing or incomplete profile data can be edited.
  - Verified representatives can only add missing profile data.
  
  When **can't** profile data be updated:
  
  - Verified representatives cannot change any existing profile data.
  
  If you need to update information in a locked state, please contact Moov support.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/representatives.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/representatives.write"]>)
@extension("x-speakeasy-name-override", "update")
op updateRepresentative(
  ...CommonHeaders,

  @doc("ID of the account.")
  @format("uuid")
  @path
  accountID: string,

  @doc("ID of the representative.")
  @format("uuid")
  @path
  representativeID: string,

  @body body: UpdateRepresentative,
):
  | OkResponse<Representative>
  | BadRequestResponse
  | UnauthorizedResponse
  | ForbiddenResponse
  | NotFoundResponse
  | StateConflictResponse
  | RateLimitedResponse
  | InternalServerErrorResponse
  | GatewayTimeoutResponse;
