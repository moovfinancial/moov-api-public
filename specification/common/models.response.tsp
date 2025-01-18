import "@typespec/http";

using TypeSpec.Http;

namespace MoovAPI;

alias HttpStatusOK = 200;

@doc("The request completed successfully.")
model OkResponse<T> {
  @statusCode statusCode: HttpStatusOK;

  @body
  body: T;
}

alias HttpStatusCreated = 201;

@doc("The resource was successfully created.")
model CreatedResponse<T> {
  @statusCode statusCode: HttpStatusCreated;

  @body
  body: T;
}

alias HttpStatusAccepted = 202;

alias HttpStatusNoContent = 204;

@doc("The request completed successfully, but there is no content to return.")
model NoContentResponse {
  @statusCode statusCode: HttpStatusNoContent;
}

@error
model GenericError {
  error: string;
}

alias HttpStatusBadRequest = 400;

@error
model BadRequestResponse {
  @statusCode statusCode: HttpStatusBadRequest;

  @body
  error?: GenericError;
}

alias HttpStatusUnauthorized = 401;

@doc("The request contained missing or expired authentication.")
@error
model UnauthorizedResponse {
  @statusCode statusCode: HttpStatusUnauthorized;
}

alias HttpStatusForbidden = 403;

@doc("The user is not authorized to make the request.")
@error
model ForbiddenResponse {
  @statusCode statusCode: HttpStatusForbidden;
}

alias HttpStatusNotFound = 404;

@doc("The requested resource was not found.")
@error
model NotFoundResponse {
  @statusCode statusCode: HttpStatusNotFound;
}

alias HttpStatusConflict = 409;

@doc("The request conflicted with the current state of the target resource.")
@error
model StateConflictResponse {
  @statusCode statusCode: HttpStatusConflict;

  @body
  @doc("""
    In most cases this will be a GenericError, but some APIs may
    return the existing resource with which this request conflicted.
    """)
  error?: GenericError;
}

alias HttpsStatusExpectationFailed = 417;

alias HttpStatusUnprocessableEntity = 422;

@doc("The request was well-formed, but the contents failed validation. Check the request for missing or invalid fields.")
@error
model UnprocessableEntityResponse<T> {
  @statusCode statusCode: HttpStatusUnprocessableEntity;

  @body
  @doc("Descriptions of any field validations that failed.")
  error?: T;
}

alias HttpStatusRateLimited = 429;

@doc("Request was refused due to rate limiting.")
@error
model RateLimitedResponse {
  @statusCode statusCode: HttpStatusRateLimited;
}

alias HttpStatusInternalServerError = 500;

@doc("The request failed due to an unexpected error.")
@error
model InternalServerErrorResponse {
  @statusCode statusCode: HttpStatusInternalServerError;
}

alias HttpStatusGatewayTimeout = 504;

@doc("The request failed because a downstream service failed to respond.")
@error
model GatewayTimeoutResponse {
  @statusCode statusCode: HttpStatusGatewayTimeout;
}

union ListResponses<T> {
  OkResponse<Array<T>>,
  UnauthorizedResponse,
  ForbiddenResponse,
  RateLimitedResponse,
  InternalServerErrorResponse,
  GatewayTimeoutResponse,
}

union GetResponses<T> {
  OkResponse<T>,
  UnauthorizedResponse,
  ForbiddenResponse,
  NotFoundResponse,
  RateLimitedResponse,
  InternalServerErrorResponse,
  GatewayTimeoutResponse,
}

union PostResponses<OK, ValidationError> {
  OkResponse<OK>,
  BadRequestResponse,
  UnauthorizedResponse,
  ForbiddenResponse,
  NotFoundResponse,
  StateConflictResponse,
  UnprocessableEntityResponse<ValidationError>,
  RateLimitedResponse,
  InternalServerErrorResponse,
  GatewayTimeoutResponse,
}

union PostResponsesCreated<OK, ValidationError> {
  CreatedResponse<OK>,
  BadRequestResponse,
  UnauthorizedResponse,
  ForbiddenResponse,
  NotFoundResponse,
  StateConflictResponse,
  UnprocessableEntityResponse<ValidationError>,
  RateLimitedResponse,
  InternalServerErrorResponse,
  GatewayTimeoutResponse,
}

union UpdateResponses<OK, ValidationError> {
  OkResponse<OK>,
  BadRequestResponse,
  UnauthorizedResponse,
  ForbiddenResponse,
  NotFoundResponse,
  StateConflictResponse,
  UnprocessableEntityResponse<ValidationError>,
  RateLimitedResponse,
  InternalServerErrorResponse,
  GatewayTimeoutResponse,
}

union UpdateNoContentResponses<ValidationError> {
  NoContentResponse,
  BadRequestResponse,
  UnauthorizedResponse,
  ForbiddenResponse,
  NotFoundResponse,
  StateConflictResponse,
  UnprocessableEntityResponse<ValidationError>,
  RateLimitedResponse,
  InternalServerErrorResponse,
  GatewayTimeoutResponse,
}

union DisableResponses {
  NoContentResponse,
  BadRequestResponse,
  UnauthorizedResponse,
  ForbiddenResponse,
  NotFoundResponse,
  StateConflictResponse,
  RateLimitedResponse,
  InternalServerErrorResponse,
  GatewayTimeoutResponse,
}
