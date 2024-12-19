import "@typespec/http";
import "./models.schedules.tsp";
import "./models.occurrence.tsp";
import "./models.recur.tsp";
import "../auth/models.auth.tsp";
import "../common/models.response.tsp";
import "../common/models.header.tsp";

using TypeSpec.Http;

namespace MoovAPI {
  @doc("Describes the schedule to create or modify.")
  @tag("Scheduling")
  @route("/accounts/{accountID}/schedules")
  @post
  @useAuth(BasicAuth | OAuth2<["/accounts/{your-account-id}/transfers.write"]>)
  op createSchedule(
    ...CommonHeaders,

    @format("uuid")
    @path
    accountID: string,

    @body body: UpsertSchedule,
  ): PostResponses<ScheduleResponse, ScheduleValidationError>;

  @doc("Describes the schedule to modify.")
  @tag("Scheduling")
  @route("/accounts/{accountID}/schedules/{scheduleID}")
  @put
  @useAuth(BasicAuth | OAuth2<["/accounts/{your-account-id}/transfers.write"]>)
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

  @doc("Describes a schedule associated with an account. Requires at least 1 occurrence or recurTransfer to be specified.")
  @tag("Scheduling")
  @route("/accounts/{accountID}/schedules/{scheduleID}")
  @get
  @useAuth(BasicAuth | OAuth2<["/accounts/{your-account-id}/transfers.read"]>)
  op getSchedules(
    ...CommonHeaders,

    @format("uuid")
    @path
    accountID: string,

    @format("uuid")
    @path
    scheduleID: string,
  ): GetResponses<ScheduleResponse>;

  @doc("Describes a list of schedules associated with an account. Requires at least 1 occurrence or recurTransfer to be specified.")
  @tag("Scheduling")
  @route("/accounts/{accountID}/schedules/")
  @get
  @useAuth(BasicAuth | OAuth2<["/accounts/{your-account-id}/transfers.read"]>)
  op listSchedules(
    ...CommonHeaders,
    @query skip?: Skip,
    @query count?: Count,

    @format("uuid")
    @path
    accountID: string,
  ): ListResponses<ScheduleResponse>;

  @doc("Defines an occurrence for when to run a transfer.")
  @tag("Scheduling")
  @route("/accounts/{accountID}/schedules/{scheduleID}/occurrences/{occurrenceFilter}")
  @get
  @useAuth(BasicAuth | OAuth2<["/accounts/{your-account-id}/transfers.read"]>)
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

  @doc("Describes the schedule to cancel.")
  @tag("Scheduling")
  @route("/accounts/{accountID}/schedules/{scheduleID}")
  @delete
  @useAuth(BasicAuth | OAuth2<["/accounts/{your-account-id}/transfers.write"]>)
  op cancelSchedule(
    ...CommonHeaders,

    @format("uuid")
    @path
    accountID: string,

    @format("uuid")
    @path
    scheduleID: string,
  ): DisableResponses;
}
