import "@typespec/http";
import "./models.onboarding.tsp";
import "../auth/models.auth.tsp";
import "../common/models.header.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;

namespace MoovAPI;

@post
@route("/onboarding-invites")
@tag("Onboarding")
@doc("""
  Create an invitation containing a unique link that allows the recipient to onboard their organization with Moov.
  
  To access this endpoint using a [token](https://docs.moov.io/api/authentication/access-tokens/) you'll need 
  to specify the `/accounts.write` scope.
  """)
@useAuth(BasicAuth | OAuth2<["/accounts.write"]>)
op createOnboardingInvite(
  ...CommonHeaders,
  @body body: OnboardingInviteRequest,
): PostResponses<OnboardingInvite, OnboardingInviteError>;

@get
@route("/onboarding-invites")
@tag("Onboarding")
@doc("""
  List all the onboarding invites created by the caller's account.
  
  To access this endpoint using a [token](https://docs.moov.io/api/authentication/access-tokens/) you'll need 
  to specify the `/accounts.read` scope.
  """)
@useAuth(BasicAuth | OAuth2<["/accounts.read"]>)
op listOnboardingInvites(...CommonHeaders): ListResponses<OnboardingInvite>;

@route("/onboarding-invites/{code}")
@tag("Onboarding")
@doc("""
  Retrieve details about an onboarding invite.
  
  To access this endpoint using a [token](https://docs.moov.io/api/authentication/access-tokens/) you'll need 
  to specify the `/accounts.read` scope.
  """)
@useAuth(BasicAuth | OAuth2<["/accounts.read"]>)
op getOnboardingInvite(
  ...CommonHeaders,

  @path
  code: OnboardingInviteCode,
): GetResponses<OnboardingInvite>;

@delete
@route("/onboarding-invites/{code}")
@tag("Onboarding")
@doc("""
  Revoke an onboarding invite, rendering the invitation link unusable.
  
  To access this endpoint using a [token](https://docs.moov.io/api/authentication/access-tokens/) you'll need 
  to specify the `/accounts.write` scope.
  """)
@useAuth(BasicAuth | OAuth2<["/accounts.write"]>)
op revokeOnboardingInvite(
  ...CommonHeaders,

  @path
  code: OnboardingInviteCode,
): NoContentResponse;
