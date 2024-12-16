import "@typespec/http";
import "./models.brand.tsp";
import "../auth/models.auth.tsp";
import "../common/models.response.tsp";
import "../common/models.header.tsp";

using TypeSpec.Http;

namespace MoovAPI {
  @doc("Creates the brand properties for the specified account.")
  @tag("Branding")
  @route("/accounts/{accountID}/branding")
  @post
  @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/branding.write"]>)
  op postBrand(
    ...CommonHeaders,

    @format("uuid")
    @path
    accountID: string,

    @body body: Brand,
  ): PostResponses<Brand, BrandValidationError>;

  @doc("Gets the brand properties for the specified account.")
  @tag("Branding")
  @route("/accounts/{accountID}/branding")
  @get
  @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/branding.read"]>)
  op getBrand(
    ...CommonHeaders,

    @format("uuid")
    @path
    accountID: string,
  ): GetResponses<Brand>;

  @doc("Updates the brand properties for the specified account.")
  @tag("Branding")
  @route("/accounts/{accountID}/branding")
  @patch
  @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/branding.write"]>)
  op updateBrand(
    ...CommonHeaders,

    @format("uuid")
    @path
    accountID: string,

    @body body: UpdateBrand,
  ): UpdateResponses<Brand, BrandValidationError>;
}
