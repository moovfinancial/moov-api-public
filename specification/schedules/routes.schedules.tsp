import "@typespec/http";
import "@typespec/openapi";
import "./models.schedules.tsp";
import "./models.occurrence.tsp";
import "./models.recur.tsp";
import "../auth/models.auth.tsp";
import "../common/models.response.tsp";
import "../common/models.header.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

@post
@route("/accounts/{accountID}/schedules")
@tag("Scheduling")
@doc("""
  Describes the schedule to create or modify.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/transfers.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.write"]>)
@useAuth(BasicAuth)
@extension("x-speakeasy-name-override", "create")
op createSchedule(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @body body: UpsertSchedule,
): PostResponses<ScheduleResponse, ScheduleValidationError>;

@put
@route("/accounts/{accountID}/schedules/{scheduleID}")
@tag("Scheduling")
@doc("""
  Describes the schedule to modify.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/transfers.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.write"]>)
@useAuth(BasicAuth)
@extension("x-speakeasy-name-override", "update")
op updateSchedule(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @format("uuid")
  @path
  scheduleID: string,

  @body body: UpsertSchedule,
): UpdateResponses<ScheduleResponse, ScheduleValidationError>;

@get
@route("/accounts/{accountID}/schedules/{scheduleID}")
@tag("Scheduling")
@doc("""
  Describes a schedule associated with an account. Requires at least 1 occurrence or recurTransfer to be specified.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/transfers.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.read"]>)
@useAuth(BasicAuth)
@extension("x-speakeasy-name-override", "get")
op getSchedules(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @format("uuid")
  @path
  scheduleID: string,
): GetResponses<ScheduleResponse>;

@get
@route("/accounts/{accountID}/schedules")
@tag("Scheduling")
@doc("""
  Describes a list of schedules associated with an account. Requires at least 1 occurrence or recurTransfer to be specified.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/transfers.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.read"]>)
@useAuth(BasicAuth)
@extension("x-speakeasy-name-override", "list")
op listSchedules(
  ...CommonHeaders,
  @query skip?: Skip,
  @query count?: Count,

  @format("uuid")
  @path
  accountID: string,
): ListResponses<ScheduleResponse>;

@get
@route("/accounts/{accountID}/schedules/{scheduleID}/occurrences/{occurrenceFilter}")
@tag("Scheduling")
@doc("""
  Defines an occurrence for when to run a transfer.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/transfers.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.read"]>)
@useAuth(BasicAuth)
@extension("x-speakeasy-name-override", "getOccurrance")
op getScheduledOccurrence(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @format("uuid")
  @path
  scheduleID: string,

  @doc("""
      Allows the specification of additional filters beyond the UUID.
    
      Specifying a UUID string returns the exact occurrence.
      Specifying a RFC 3339 timestamp returns the latest occurrence at or before that timestamp.
      Specifying `latest` returns the latest occurrence at or before now.
    """)
  @path
  occurrenceFilter: string,
): GetResponses<ScheduleResponse>;

@delete
@route("/accounts/{accountID}/schedules/{scheduleID}")
@tag("Scheduling")
@doc("""
  Describes the schedule to cancel.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/transfers.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.write"]>)
@useAuth(BasicAuth)
@extension("x-speakeasy-name-override", "cancel")
op cancelSchedule(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @format("uuid")
  @path
  scheduleID: string,
): DisableResponses;
