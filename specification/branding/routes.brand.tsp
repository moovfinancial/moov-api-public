import "@typespec/http";
import "@typespec/openapi";
import "./models.brand.tsp";
import "../auth/models.auth.tsp";
import "../common/models.response.tsp";
import "../common/models.header.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

@post
@route("/accounts/{accountID}/branding")
@tag("Branding")
@doc("""
  Create brand properties for the specified account.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/branding.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/branding.write"]>)
@extension("x-speakeasy-name-override", "create")
op createBrand(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  accountID: string,

  @body body: BrandProperties,
): PostResponses<BrandProperties, BrandValidationError>;

@put
@route("/accounts/{accountID}/branding")
@tag("Branding")
@doc("""
  Create or replace brand properties for the specified account.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/branding.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/branding.write"]>)
@extension("x-speakeasy-name-override", "upsert")
op upsertBrand(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  accountID: string,

  @body body: BrandProperties,
): UpdateResponses<BrandProperties, BrandValidationError>;

@get
@route("/accounts/{accountID}/branding")
@tag("Branding")
@doc("""
  Get brand properties for the specified account.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/branding.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/branding.read"]>)
@extension("x-speakeasy-name-override", "get")
op getBrand(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  accountID: string,
): GetResponses<BrandProperties>;

@patch
@route("/accounts/{accountID}/branding")
@tag("Branding")
@doc("""
  Updates the brand properties for the specified account.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/branding.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/branding.write"]>)
@extension("x-speakeasy-name-override", "update")
op updateBrand(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  accountID: string,

  @body body: UpdateBrand,
): UpdateResponses<BrandProperties, BrandValidationError>;
