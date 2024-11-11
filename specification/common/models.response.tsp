import "@typespec/http";

using TypeSpec.Http;

namespace Common;

@doc("The request completed successfully.")
model Ok<T> {
  @statusCode statusCode: "200";

  @body
  body: T;
}

@error
model GenericError {
  error: string;
}

@error
model BadRequest {
  @statusCode statusCode: "400";

  @body
  error?: GenericError;
}

@doc("The request contained missing or expired authentication.")
@error
model Unauthorized {
  @statusCode statusCode: "401";
}

@doc("The user is not authorized to make the request.")
@error
model Forbidden {
  @statusCode statusCode: "403";
}

@doc("The request conflicted with the current state of the target resource.")
@error
model StateConflict {
  @statusCode statusCode: "409";

  @body
  @doc("""
    In most cases this will be a GenericError, but some APIs may
    return the existing resource with which this request conflicted.
    """)
  error?: GenericError;
}

@doc("The request was well-formed, but the contents failed validation. Check the request for missing or invalid fields.")
@error
model UnprocessableEntity<T> {
  @statusCode statusCode: "422";

  @body
  @doc("Descriptions of any field validations that failed.")
  error?: T;
}

@doc("Request was refused due to rate limiting.")
@error
model RateLimited {
  @statusCode statusCode: "429";
}

union List<T> {
  Ok<Array<T>>,
  Unauthorized,
  Forbidden,
  RateLimited,
}

union Get<T> {
  Ok<T>,
  Unauthorized,
  Forbidden,
  NotFoundResponse,
  RateLimited,
}

union Post<OK, ValidationError> {
  Ok<OK>,
  BadRequest,
  Unauthorized,
  Forbidden,
  NotFoundResponse,
  StateConflict,
  UnprocessableEntity<ValidationError>,
  RateLimited,
}

union Update<OK, ValidationError> {
  Ok<OK>,
  BadRequest,
  Unauthorized,
  Forbidden,
  NotFoundResponse,
  StateConflict,
  UnprocessableEntity<ValidationError>,
  RateLimited,
}

union UpdateNoContent<ValidationError> {
  NoContentResponse,
  BadRequest,
  Unauthorized,
  Forbidden,
  NotFoundResponse,
  StateConflict,
  UnprocessableEntity<ValidationError>,
  RateLimited,
}

union Disable {
  NoContentResponse,
  BadRequest,
  Unauthorized,
  Forbidden,
  NotFoundResponse,
  StateConflict,
  RateLimited,
}
