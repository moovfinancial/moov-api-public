namespace MoovAPI;

@doc("Details of a card dispute.")
model CardTransferDispute {
  @format("uuid")
  disputeID: string;

  createdOn: utcDateTime;
  amount: Amount;
}
