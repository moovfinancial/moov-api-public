import "@typespec/http";
import "./models.dispute.tsp";
import "./models.evidence.tsp";
import "../auth/models.auth.tsp";
import "../common/models.header.tsp";
import "../common/models.parameter.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;

namespace MoovAPI;

@doc("""
  Returns a dispute's public evidence by its ID. 
  
  Read our [disputes guide](https://docs.moov.io/guides/money-movement/accept-payments/card-acceptance/disputes/) to learn more.
  
  To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/transfers.read` scope when generating 
  a [token](https://docs.moov.io/api/authentication/access-tokens/).
  """)
@get
@tag("Disputes")
@route("/accounts/{accountID}/disputes/{disputeID}/evidence")
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.read"]>)
op listDisputeEvidence(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @format("uuid")
  @path
  disputeID: string,
): ListResponses<DisputeEvidenceMetadata>;

@doc("""
  Uploads a file as evidence for a dispute. 
  
  Read our [disputes guide](https://docs.moov.io/guides/money-movement/accept-payments/card-acceptance/disputes/) to learn more.
  
  To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/transfers.write` scope when generating 
  a [token](https://docs.moov.io/api/authentication/access-tokens/).
  """)
@post
@tag("Disputes")
@route("/accounts/{accountID}/disputes/{disputeID}/evidence-file")
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.write"]>)
op uploadDisputeEvidenceFile(
  ...CommonHeaders,
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

@doc("""
  Uploads text as evidence for a dispute.
  
  Read our [disputes guide](https://docs.moov.io/guides/money-movement/accept-payments/card-acceptance/disputes/) to learn more.
  
  To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/transfers.write` scope when generating 
  a [token](https://docs.moov.io/api/authentication/access-tokens/).
  """)
@post
@tag("Disputes")
@route("/accounts/{accountID}/disputes/{disputeID}/evidence-text")
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.write"]>)
op uploadDisputeEvidenceText(
  ...CommonHeaders,

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

@doc("""
  Get dispute evidence by ID.
  
  Read our [disputes guide](https://docs.moov.io/guides/money-movement/accept-payments/card-acceptance/disputes/) to learn more.
  
  To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/transfers.read` scope when generating 
  a [token](https://docs.moov.io/api/authentication/access-tokens/).
  """)
@get
@tag("Disputes")
@route("/accounts/{accountID}/disputes/{disputeID}/evidence/{evidenceID}")
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.read"]>)
op getDisputeEvidence(
  ...CommonHeaders,

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

@doc("""
  Updates dispute evidence by ID.
  
  Read our [disputes guide](https://docs.moov.io/guides/money-movement/accept-payments/card-acceptance/disputes/) to learn more.
  
  To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/transfers.write` scope when generating
  a [token](https://docs.moov.io/api/authentication/access-tokens/).
  """)
@patch
@tag("Disputes")
@route("/accounts/{accountID}/disputes/{disputeID}/evidence/{evidenceID}")
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.write"]>)
op updateDisputeEvidence(
  ...CommonHeaders,

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

@doc("""
  Deletes dispute evidence by ID. 
  
  Read our [disputes guide](https://docs.moov.io/guides/money-movement/accept-payments/card-acceptance/disputes/) to learn more.
  
  To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/transfers.write` scope when generating 
  a [token](https://docs.moov.io/api/authentication/access-tokens/).
  """)
@delete
@tag("Disputes")
@route("/accounts/{accountID}/disputes/{disputeID}/evidence/{evidenceID}")
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.write"]>)
op deleteDisputeEvidenceFile(
  ...CommonHeaders,

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

@doc("""
  Downloads dispute evidence data by ID.
  
  Read our [disputes guide](https://docs.moov.io/guides/money-movement/accept-payments/card-acceptance/disputes/) to learn more.
  
  To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/transfers.read` scope when generating 
  a [token](https://docs.moov.io/api/authentication/access-tokens/).
  """)
@get
@tag("Disputes")
@route("/accounts/{accountID}/disputes/{disputeID}/evidence/{evidenceID}/data")
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.read"]>)
op getDisputeEvidenceData(
  ...CommonHeaders,

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

@doc("""
  Submit the evidence associated with a dispute.
  
  Evidence items must be uploaded using the appropriate endpoint(s) prior to calling this endpoint to submit it. **Evidence can only
  be submitted once per dispute.**
  
  Read our [disputes guide](https://docs.moov.io/guides/money-movement/accept-payments/card-acceptance/disputes/) to learn more.
  
  To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/transfers.write` scope when generating 
  a [token](https://docs.moov.io/api/authentication/access-tokens/).
  """)
@post
@tag("Disputes")
@route("/accounts/{accountID}/disputes/{disputeID}/evidence/submit")
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.write"]>)
op submitDisputeEvidence(
  ...CommonHeaders,

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
