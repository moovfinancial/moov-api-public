namespace MoovAPI;

@doc("Defines configuration for recurring transfers.")
model Recur {
  @doc("""
      RRule as defined by RFC 5545 (https://www.rfc-editor.org/rfc/rfc5545#section-3.3.10). 
      Generators available online at the following sites - https://freetools.textmagic.com/rrule-generator, https://jkbrzt.github.io/rrule/
    """)
  recurrenceRule: string;

  runTransfer: RunTransfer;

  @doc("True if the RRule set runs indefinitely.")
  indefinite?: boolean;

  @example(utcDateTime.fromISO("2009-11-10T23:00:00Z"))
  start?: utcDateTime;
}

@doc("Defines the attributes of a transfer.")
model RunTransfer {
  amount: Amount;
  destination: SchedulePaymentMethod;

  @format("uuid")
  @example("c520f1b9-0ba7-42f5-b977-248cdbe41c69")
  partnerAccountID: string;

  source: SchedulePaymentMethod;

  @doc("Simple description to place on the transfer.")
  description: string;
}
