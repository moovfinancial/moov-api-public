import "@typespec/http";
import "@typespec/openapi";
import "./models.onboarding.tsp";
import "../auth/models.auth.tsp";
import "../common/models.header.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

@post
@route("/onboarding-invites")
@tag("Onboarding")
@doc("""
  Create an invitation containing a unique link that allows the recipient to onboard their organization with Moov.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts.write"]>)
@extension("x-speakeasy-name-override", "createInvite")
op createOnboardingInvite(
  ...CommonRequestHeaders,
  @body body: OnboardingInviteRequest,
): PostResponses<OnboardingInvite, OnboardingInviteError>;

@get
@route("/onboarding-invites")
@tag("Onboarding")
@doc("""
  List all the onboarding invites created by the caller's account.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts.read"]>)
@extension("x-speakeasy-name-override", "listInvites")
op listOnboardingInvites(
  ...CommonRequestHeaders,
): ListResponses<OnboardingInvite>;

@route("/onboarding-invites/{code}")
@tag("Onboarding")
@doc("""
  Retrieve details about an onboarding invite.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts.read"]>)
@extension("x-speakeasy-name-override", "getInvite")
op getOnboardingInvite(
  ...CommonRequestHeaders,

  @path
  code: OnboardingInviteCode,
): GetResponses<OnboardingInvite>;

@delete
@route("/onboarding-invites/{code}")
@tag("Onboarding")
@doc("""
  Revoke an onboarding invite, rendering the invitation link unusable.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts.write"]>)
@extension("x-speakeasy-name-override", "revokeInvite")
op revokeOnboardingInvite(
  ...CommonRequestHeaders,

  @path
  code: OnboardingInviteCode,
): NoContentResponse;
