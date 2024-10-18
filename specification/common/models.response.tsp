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
  error: GenericError;
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
  message?: GenericError;
}

@doc("The request was well-formed, but the contents failed validation. Check the request for missing or invalid fields.")
@error
model UnprocessableEntity {
  @statusCode statusCode: "422";

  @body
  @doc("HTTP 422 will have a body that matches the shape of the request body, or is a GenericError.")
  message: unknown;
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

union Post<T> {
  Ok<T>,
  BadRequest,
  Unauthorized,
  Forbidden,
  NotFoundResponse,
  StateConflict,
  UnprocessableEntity,
  RateLimited,
}

union Update<T> {
  Ok<T>,
  BadRequest,
  Unauthorized,
  Forbidden,
  NotFoundResponse,
  StateConflict,
  UnprocessableEntity,
  RateLimited,
}

union UpdateNoContent {
  NoContentResponse,
  BadRequest,
  Unauthorized,
  Forbidden,
  NotFoundResponse,
  StateConflict,
  UnprocessableEntity,
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
