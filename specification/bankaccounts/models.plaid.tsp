namespace MoovAPI;

@summary("Plaid")
@doc("""
  Describes the account to link to the Moov account using a Plaid processor token.
  """)
model PlaidPayload {
  plaid: PlaidIntegration;
}

@doc("""
  The details of a Plaid processor integration for a linked funding source. 
  
  `sandbox` - When linking a bank account to a `sandbox` account using a Plaid processor token a default bank account
  response will be used. The following default data will be used to generate the bank account in this flow:
  
  ```
    RoutingNumber: "011401533",
    AccountNumber: "1111222233330000",
    AccountType:   "checking",
    Mask:          "0000"
  ```
  """)
model PlaidIntegration {
  token: string;
}

@summary("Plaid Link")
@doc("""
  This is used by Moov.js with a Plaid reseller relationship. 
  
  Describes the account to link to the Moov account using a Plaid using a Plaid public token.
  """)
model PlaidLinkPayload {
  plaidLink: PlaidLinkIntegration;
}

@doc("""
  This is used by Moov.js with a Plaid reseller relationship. The details of a Plaid link integration for a linked funding source.
  
  You can simulate linking bank accounts with Plaid in test mode. See our [test mode](https://docs.moov.io/guides/get-started/test-mode/#plaid)
  guide for more information.
  
  Plaid's `sandbox` environment - (requires Plaid reseller setup with Moov). When linking a bank account to a `sandbox` account using a Plaid 
  public token it will utilize Plaid's sandbox environment. The Plaid public token provided must be generated from Plaid's sandbox environment. 
  Please see <a href="https://plaid.com/docs/api/sandbox/#sandboxpublic_tokencreate" target="_blank">Plaid's sandbox documentation</a> for more 
  details.
  """)
model PlaidLinkIntegration {
  publicToken: string;
}
