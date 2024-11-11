import "@typespec/http";
import "./models.account.tsp";
import "../auth/models.auth.tsp";
import "../common/models.response.tsp";
import "../common/models.header.tsp";
import "../common/models.parameter.tsp";

using TypeSpec.Http;

@tag("Accounts")
@route("/accounts")
namespace MoovAPI.Accounts {
  @doc("""
    You can create **business** or **individual** accounts for your users (i.e., customers, merchants) by passing the required
    information to Moov. Requirements differ per account type and requested [capabilities](https://docs.moov.io/guides/accounts/capabilities/requirements/).
    
    If you're requesting the `wallet`, `send-funds`, `collect-funds`, or `card-issuing` capabilities, you'll need to:
      + Send Moov the user [platform terms of service agreement](https://docs.moov.io/guides/accounts/requirements/platform-agreement/) acceptance.
        This can be done upon account creation, or by [patching](https://docs.moov.io/api/moov-accounts/accounts/patch/) the account using the `termsOfService` field.
    If you're creating a business account with the business type `llc`, `partnership`, or `privateCorporation`, you'll need to:
      + Provide [business representatives](https://docs.moov.io/api/moov-accounts/representatives/) after creating the account.
      + [Patch](https://docs.moov.io/api/moov-accounts/accounts/patch/) the account to indicate that business representative ownership information is complete.
    
    Visit our documentation to read more about [creating accounts](https://docs.moov.io/guides/accounts/create-accounts/) and [verification requirements](https://docs.moov.io/guides/accounts/requirements/identity-verification/).
    Note that the `mode` field (for production or sandbox) is only required when creating a _facilitator_ account. All non-facilitator account requests will ignore the mode field and be set to the calling facilitator's mode.
    """)
  @post
  @useAuth(BasicAuth | Auth.OAuth2<["/accounts.write"]>)
  op createAccount(
    ...Common.Headers,
    @body body: Accounts.CreateAccount,
  ): Common.Post<
    Accounts.Account,
    {
      error: Accounts.CreateAccountError;
    }
  >;

  @doc("""
    List or search accounts to which the caller is connected.
    
    All supported query parameters are optional. If none are provided the response will include all connected accounts.
    Pagination is supported via the `skip` and `count` query parameters.
    Searching by name and email will overlap and return results based on relevance.
    """)
  @get
  @useAuth(BasicAuth | Auth.OAuth2<["/accounts.read"]>)
  op listAccounts(
    ...Common.Headers,
    ...Accounts.AccountsQuery,
    @query skip: Common.Skip,
    @query count: Common.Count,
  ): Common.List<Accounts.Account>;

  @doc("Retrieves details for the account with the specified ID.")
  @get
  @useAuth(BasicAuth | Auth.OAuth2<["/accounts/{accountID}/profile.read"]>)
  op getAccount(
    ...Common.Headers,

    @format("uuid")
    @path
    accountID: string,
  ): Common.Get<Accounts.Account>;
}
