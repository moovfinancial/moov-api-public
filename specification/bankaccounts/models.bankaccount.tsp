import "@typespec/openapi3";
import "./models.plaid.tsp";
import "./models.mx.tsp";
import "../paymentmethods/models.paymentmethod.tsp";

using TypeSpec.OpenAPI;

namespace MoovAPI;

@oneOf
union LinkBankAccount {
  BankAccountPayload,
  PlaidPayload,
  PlaidLinkPayload,
  MxPayload,
}

@doc("Describes the bank account to link to the Moov account.")
model BankAccountPayload {
  account: BankAccountIntegration;
}

model BankAccountIntegration {
  holderName: string;
  holderType: BankAccountHolderType;
  accountNumber: string;
  bankAccountType: BankAccountType;
  routingNumber: string;
}

model BankAccountValidationError {
  account?: string;
  plaid?: string;
  plaidLink?: string;
  mx?: string;
  error?: string;
}

@doc("Describes a bank account linked to a Moov account.")
@example(#{
  bankAccountID: "833fa3ef-14d3-4c97-ba45-6af66f739832",
  fingerprint: "dd4cbfe5fbaf47b392770b5b595bec604fd99394749b7d017153e2b9cfbea40e",
  status: BankAccountStatus.new,
  holderName: "John Doe",
  holderType: BankAccountHolderType.individual,
  bankName: "Gringotts Bank",
  bankAccountType: BankAccountType.checking,
  routingNumber: "123456780",
  lastFourAccountNumber: "6789",
  updatedOn: utcDateTime.fromISO("2024-11-26T22:37:06Z"),
  statusReason: BankAccountStatusReason.bankAccountCreated,
})
model BankAccount {
  @format("uuid")
  bankAccountID: string;

  @doc("""
    Once the bank account is linked, we don't reveal the full bank account number. 
    
    The fingerprint acts as a way to identify whether two linked bank accounts are the same.
    """)
  @maxLength(100)
  fingerprint: string;

  status: BankAccountStatus;
  holderName: string;
  holderType: BankAccountHolderType;
  bankName: string;
  bankAccountType: BankAccountType;
  routingNumber: string;
  lastFourAccountNumber: string;
  updatedOn: utcDateTime;
  statusReason: BankAccountStatusReason;
  exceptionDetails?: BankAccountException;

  @doc("""
    Includes any payment methods generated for a newly created bank account, removing the need to
    call the List Payment Methods endpoint following a successful Create BankAccount request.
    
    **NOTE: This field is only populated for Create BankAccount requests made with the `X-Wait-For` header.**
    """)
  paymentMethods?: BasicPaymentMethod[];
}

@doc("Reason for, and details related to, an `errored` or `verificationFailed` bank account status.")
model BankAccountException {
  achReturnCode: ACHReturnCode;
  rtpRejectionCode: RTPRejectionCode;

  @doc("Details related to an `errored` or `verificationFailed` bank account status.")
  description: string;
}

@doc("The type of holder on a funding source.")
enum BankAccountHolderType {
  individual: "individual",
  business: "business",
}

@doc("The bank account type.")
enum BankAccountType {
  checking: "checking",
  savings: "savings",
  generalLedger: "general-ledger",
  loan: "loan",
}

enum BankAccountStatus {
  new: "new",
  verified: "verified",
  verificationFailed: "verificationFailed",
  pending: "pending",
  errored: "errored",
}

@doc("The reason the bank account status changed to the current value.")
enum BankAccountStatusReason {
  bankAccountCreated: "bank-account-created",
  verificationInitiated: "verification-initiated",
  microDepositAttemptsExceeded: "micro-deposit-attempts-exceeded",
  microDepositExpired: "micro-deposit-expired",
  maxVerificationFailures: "max-verification-failures",
  verificationAttemptsExceeded: "verification-attempts-exceeded",
  verificationExpired: "verification-expired",
  verificationSuccessful: "verification-successful",
  achDebitReturn: "ach-debit-return",
  achCreditReturn: "ach-credit-return",
  rtpCreditFailure: "rtp-credit-failure",
  microDepositReturn: "micro-deposit-return",
  adminAction: "admin-action",
  other: "other",
}

@doc("""
  The return code of an ACH transaction that caused the bank account status to change.
  
  - R02: Account Closed
  - R03: No Account/Unable to Locate Account
  - R04: Invalid Account Number
  - R05: Improper Debit to Consumer Account
  - R07: Authorization Revoked by Customer
  - R08: Payment Stopped
  - R10: Customer Advises Originator is Not Known or Authorized to Receiver
  - R11: Customer Advises Entry Not in Accordance with the Terms of the Authorization
  - R12: Branch Sold to Another DFI
  - R13: RDFI not qualified to participate
  - R14: Representative payee deceased or unable to continue in that capacity
  - R15: Beneficiary or bank account holder
  - R16: Bank account frozen
  - R17: Entry with Invalid Account Number Initiated Under Questionable Circumstances
  - R20: Non-payment bank account
  - R23: Credit entry refused by receiver
  - R29: Corporate customer advises not authorized
  - R34: Limited participation RDFI
  - R38: Stop Payment on Source Document (Adjustment Entry)
  - R39: Improper Source Document
  """)
enum ACHReturnCode {
  R02: "R02",
  R03: "R03",
  R04: "R04",
  R05: "R05",
  R07: "R07",
  R08: "R08",
  R10: "R10",
  R11: "R11",
  R12: "R12",
  R13: "R13",
  R14: "R14",
  R15: "R15",
  R16: "R16",
  R17: "R17",
  R20: "R20",
  R23: "R23",
  R29: "R29",
  R34: "R34",
  R38: "R38",
  R39: "R39",
}

@doc("""
  The rejection code of an RTP transaction that caused the bank account status to change.
  
  - AC03: Account Invalid
  - AC04: Account Closed
  - AC06: Account Blocked
  - AC14: Creditor Account Type Invalid
  - AG01: Transactions Forbidden On Account
  - AG03: Transaction Type Not Supported
  - MD07: Customer Deceased
  """)
enum RTPRejectionCode {
  AC03: "AC03",
  AC04: "AC04",
  AC06: "AC06",
  AC14: "AC14",
  AG01: "AG01",
  AG03: "AG03",
  MD07: "MD07",
}

enum BankAccountWaitFor {
  paymentMethod: "payment-method",
  railResponse: "rail-response",
}
