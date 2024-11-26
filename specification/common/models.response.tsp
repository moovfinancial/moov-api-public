import "@typespec/http";

using TypeSpec.Http;

namespace MoovAPI;

@doc("The request completed successfully.")
model OkResponse<T> {
  @statusCode statusCode: "200";

  @body
  body: T;
}

@doc("The request completed successfully, but there is no content to return.")
model NoContentResponse {
  @statusCode statusCode: "204";
}

@error
model GenericError {
  error: string;
}

@error
model BadRequestResponse {
  @statusCode statusCode: "400";

  @body
  error?: GenericError;
}

@doc("The request contained missing or expired authentication.")
@error
model UnauthorizedResponse {
  @statusCode statusCode: "401";
}

@doc("The user is not authorized to make the request.")
@error
model ForbiddenResponse {
  @statusCode statusCode: "403";
}

@doc("The requested resource was not found.")
@error
model NotFoundResponse {
  @statusCode statusCode: "404";
}

@doc("The request conflicted with the current state of the target resource.")
@error
model StateConflictResponse {
  @statusCode statusCode: "409";

  @body
  @doc("""
    In most cases this will be a GenericError, but some APIs may
    return the existing resource with which this request conflicted.
    """)
  error?: string;
}

@doc("The request was well-formed, but the contents failed validation. Check the request for missing or invalid fields.")
@error
model UnprocessableEntityResponse<T> {
  @statusCode statusCode: "422";

  @body
  @doc("Descriptions of any field validations that failed.")
  error?: T;
}

@doc("Request was refused due to rate limiting.")
@error
model RateLimitedResponse {
  @statusCode statusCode: "429";
}

union ListResponses<T> {
  MoovAPI.OkResponse<Array<T>>,
  MoovAPI.UnauthorizedResponse,
  MoovAPI.ForbiddenResponse,
  MoovAPI.RateLimitedResponse,
}

union GetResponses<T> {
  MoovAPI.OkResponse<T>,
  MoovAPI.UnauthorizedResponse,
  MoovAPI.ForbiddenResponse,
  MoovAPI.NotFoundResponse,
  MoovAPI.RateLimitedResponse,
}

union PostResponses<OK, ValidationError> {
  MoovAPI.OkResponse<OK>,
  MoovAPI.BadRequestResponse,
  MoovAPI.UnauthorizedResponse,
  MoovAPI.ForbiddenResponse,
  MoovAPI.NotFoundResponse,
  MoovAPI.StateConflictResponse,
  MoovAPI.UnprocessableEntityResponse<ValidationError>,
  MoovAPI.RateLimitedResponse,
}

union UpdateResponses<OK, ValidationError> {
  MoovAPI.OkResponse<OK>,
  MoovAPI.BadRequestResponse,
  MoovAPI.UnauthorizedResponse,
  MoovAPI.ForbiddenResponse,
  MoovAPI.NotFoundResponse,
  MoovAPI.StateConflictResponse,
  MoovAPI.UnprocessableEntityResponse<ValidationError>,
  MoovAPI.RateLimitedResponse,
}

union UpdateNoContentResponses<ValidationError> {
  MoovAPI.NoContentResponse,
  MoovAPI.BadRequestResponse,
  MoovAPI.UnauthorizedResponse,
  MoovAPI.ForbiddenResponse,
  MoovAPI.NotFoundResponse,
  MoovAPI.StateConflictResponse,
  MoovAPI.UnprocessableEntityResponse<ValidationError>,
  MoovAPI.RateLimitedResponse,
}

union DisableResponses {
  MoovAPI.NoContentResponse,
  MoovAPI.BadRequestResponse,
  MoovAPI.UnauthorizedResponse,
  MoovAPI.ForbiddenResponse,
  MoovAPI.NotFoundResponse,
  MoovAPI.StateConflictResponse,
  MoovAPI.RateLimitedResponse,
}
