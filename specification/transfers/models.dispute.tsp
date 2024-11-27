namespace MoovAPI;

@doc("Details of a card dispute.")
model CardAcquiringDispute {
  @format("uuid")
  disputeID: string;

  createdOn: utcDateTime;
  amount: Amount;
}
