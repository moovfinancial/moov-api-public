import "@typespec/http";
import "@typespec/openapi";
import "./models.dispute.tsp";
import "./models.evidence.tsp";
import "../auth/models.auth.tsp";
import "../common/models.header.tsp";
import "../common/models.parameter.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

@get
@route("/accounts/{accountID}/disputes/{disputeID}/evidence")
@tag("Disputes")
@doc("""
  Returns a dispute's public evidence by its ID. 
  
  Read our [disputes guide](https://docs.moov.io/guides/money-movement/accept-payments/card-acceptance/disputes/) to learn more.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/transfers.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.read"]>)
@extension("x-speakeasy-name-override", "listEvidence")
op listDisputeEvidence(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  accountID: string,

  @format("uuid")
  @path
  disputeID: string,
): ListResponses<DisputeEvidenceMetadata>;

@post
@route("/accounts/{accountID}/disputes/{disputeID}/evidence-file")
@tag("Disputes")
@doc("""
  Uploads a file as evidence for a dispute. 
  
  Read our [disputes guide](https://docs.moov.io/guides/money-movement/accept-payments/card-acceptance/disputes/) to learn more.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/transfers.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.write"]>)
@extension("x-speakeasy-name-override", "uploadEvidenceFile")
op uploadDisputeEvidenceFile(
  ...CommonRequestHeaders,
  @header contentType: "multipart/form-data",

  @format("uuid")
  @path
  accountID: string,

  @format("uuid")
  @path
  disputeID: string,

  @body body: CreateEvidenceFile,
):
  | NoContentResponse
  | BadRequestResponse
  | UnauthorizedResponse
  | ForbiddenResponse
  | NotFoundResponse
  | StateConflictResponse
  | RateLimitedResponse
  | InternalServerErrorResponse
  | GatewayTimeoutResponse;

@post
@route("/accounts/{accountID}/disputes/{disputeID}/evidence-text")
@tag("Disputes")
@doc("""
  Uploads text as evidence for a dispute.
  
  Read our [disputes guide](https://docs.moov.io/guides/money-movement/accept-payments/card-acceptance/disputes/) to learn more.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/transfers.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.write"]>)
@extension("x-speakeasy-name-override", "uploadEvidenceText")
op uploadDisputeEvidenceText(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  accountID: string,

  @format("uuid")
  @path
  disputeID: string,

  @body body: CreateEvidenceText,
):
  | CreatedResponse<EvidenceText>
  | BadRequestResponse
  | UnauthorizedResponse
  | ForbiddenResponse
  | NotFoundResponse
  | StateConflictResponse
  | RateLimitedResponse
  | InternalServerErrorResponse
  | GatewayTimeoutResponse;

@get
@route("/accounts/{accountID}/disputes/{disputeID}/evidence/{evidenceID}")
@tag("Disputes")
@doc("""
  Get dispute evidence by ID.
  
  Read our [disputes guide](https://docs.moov.io/guides/money-movement/accept-payments/card-acceptance/disputes/) to learn more.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/transfers.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.read"]>)
@extension("x-speakeasy-name-override", "getEvidence")
op getDisputeEvidence(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  accountID: string,

  @format("uuid")
  @path
  disputeID: string,

  @format("uuid")
  @path
  evidenceID: string,
): GetResponses<DisputeEvidenceMetadata>;

@patch
@route("/accounts/{accountID}/disputes/{disputeID}/evidence/{evidenceID}")
@tag("Disputes")
@doc("""
  Updates dispute evidence by ID.
  
  Read our [disputes guide](https://docs.moov.io/guides/money-movement/accept-payments/card-acceptance/disputes/) to learn more.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/transfers.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.write"]>)
@extension("x-speakeasy-name-override", "updateEvidence")
op updateDisputeEvidence(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  accountID: string,

  @format("uuid")
  @path
  disputeID: string,

  @format("uuid")
  @path
  evidenceID: string,

  @body body: UpdateEvidence,
):
  | OkResponse<DisputeEvidenceMetadata>
  | BadRequestResponse
  | UnauthorizedResponse
  | ForbiddenResponse
  | NotFoundResponse
  | RateLimitedResponse
  | InternalServerErrorResponse
  | GatewayTimeoutResponse;

@delete
@tag("Disputes")
@route("/accounts/{accountID}/disputes/{disputeID}/evidence/{evidenceID}")
@doc("""
  Deletes dispute evidence by ID. 
  
  Read our [disputes guide](https://docs.moov.io/guides/money-movement/accept-payments/card-acceptance/disputes/) to learn more.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/transfers.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.write"]>)
@extension("x-speakeasy-name-override", "deleteEvidence")
op deleteDisputeEvidenceFile(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  accountID: string,

  @format("uuid")
  @path
  disputeID: string,

  @format("uuid")
  @path
  evidenceID: string,
):
  | NoContentResponse
  | UnauthorizedResponse
  | ForbiddenResponse
  | NotFoundResponse
  | StateConflictResponse
  | RateLimitedResponse
  | InternalServerErrorResponse
  | GatewayTimeoutResponse;

@get
@route("/accounts/{accountID}/disputes/{disputeID}/evidence/{evidenceID}/data")
@tag("Disputes")
@doc("""
  Downloads dispute evidence data by ID.
  
  Read our [disputes guide](https://docs.moov.io/guides/money-movement/accept-payments/card-acceptance/disputes/) to learn more.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/transfers.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.read"]>)
@extension("x-speakeasy-name-override", "getEvidenceData")
op getDisputeEvidenceData(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  accountID: string,

  @format("uuid")
  @path
  disputeID: string,

  @format("uuid")
  @path
  evidenceID: string,
):
  | EvidenceDataResponse
  | UnauthorizedResponse
  | ForbiddenResponse
  | NotFoundResponse
  | RateLimitedResponse
  | InternalServerErrorResponse
  | GatewayTimeoutResponse;

@post
@tag("Disputes")
@route("/accounts/{accountID}/disputes/{disputeID}/evidence/submit")
@doc("""
  Submit the evidence associated with a dispute.
  
  Evidence items must be uploaded using the appropriate endpoint(s) prior to calling this endpoint to submit it. **Evidence can only
  be submitted once per dispute.**
  
  Read our [disputes guide](https://docs.moov.io/guides/money-movement/accept-payments/card-acceptance/disputes/) to learn more.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/transfers.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.write"]>)
@extension("x-speakeasy-name-override", "submitEvidence")
op submitDisputeEvidence(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  accountID: string,

  @format("uuid")
  @path
  disputeID: string,
):
  | OkResponse<Dispute>
  | BadRequestResponse
  | UnauthorizedResponse
  | ForbiddenResponse
  | NotFoundResponse
  | StateConflictResponse
  | RateLimitedResponse
  | InternalServerErrorResponse
  | GatewayTimeoutResponse;
