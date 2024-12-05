import "@typespec/http";
import "./models.sweepconfig.tsp";
import "./examples.sweepconfig.tsp";

using TypeSpec.Http;

namespace MoovAPI;

// Create

model CreateSweepConfig {
  walletID: WalletID;
  status: SweepConfigStatus;
  pushPaymentMethodID: PaymentMethodID;
  pullPaymentMethodID: PaymentMethodID;
  statementDescriptor?: SweepStatementDescriptor;

  @pattern(Decimal2StringPattern)
  minimumBalance?: string;
}

model CreateSweepConfigError {
  walletID?: string;
  status?: string;
  pushPaymentMethodID?: string;
  pullPaymentMethodID?: string;
  statementDescriptor?: string;
  minimumBalance?: string;
}

@doc("""
  Create a sweep config for a wallet.
  """)
@tag("Sweeps")
@route("/accounts/{accountID}/sweep-configs")
@post
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/wallets.write"]>)
@opExample(#{
  parameters: #{
    accountID: ExampleID,
    body: #{
      walletID: ExampleID,
      status: SweepConfigStatus.enabled,
      pushPaymentMethodID: ExampleID,
      pullPaymentMethodID: ExampleID,
    },
  },
  returnType: #{ statusCode: HttpStatusOK, body: ExampleEnabledSweepConfig },
})
op createSweepConfig(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @body body: CreateSweepConfig,
): PostResponses<SweepConfig, CreateSweepConfigError>;

// List

@doc("""
  List sweep configs associated with an account.
  """)
@tag("Sweeps")
@route("/accounts/{accountID}/sweep-configs")
@get
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/wallets.read"]>)
@opExample(#{
  parameters: #{ accountID: ExampleID },
  returnType: #{
    statusCode: HttpStatusOK,
    body: #[ExampleEnabledSweepConfig, ExampleDisabledSweepConfig],
  },
})
op listSweepConfigs(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,
): ListResponses<SweepConfig>;

// Get

@doc("""
  Get a sweep config associated with a wallet.
  """)
@tag("Sweeps")
@route("/accounts/{accountID}/sweep-configs/{sweepConfigID}")
@get
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/wallets.read"]>)
@opExample(#{
  parameters: #{ accountID: ExampleID, sweepConfigID: ExampleID },
  returnType: #{ statusCode: HttpStatusOK, body: ExampleEnabledSweepConfig },
})
op getSweepConfig(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @path
  sweepConfigID: SweepConfigID,
): GetResponses<SweepConfig>;

// Patch

model PatchSweepConfig {
  status?: SweepConfigStatus;
  pushPaymentMethodID?: PaymentMethodID;
  pullPaymentMethodID?: PaymentMethodID;
  statementDescriptor?: SweepStatementDescriptor;

  @pattern(Decimal2StringPattern)
  minimumBalance?: string;
}

model PatchSweepConfigError {
  status?: string;
  pushPaymentMethodID?: string;
  pullPaymentMethodID?: string;
  statementDescriptor?: string;
  minimumBalance?: string;
}

@doc("""
  Update settings on a sweep config.
  """)
@tag("Sweeps")
@route("/accounts/{accountID}/sweep-configs/{sweepConfigID}")
@patch
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/wallets.write"]>)
@opExample(#{
  parameters: #{
    accountID: ExampleID,
    sweepConfigID: ExampleID,
    body: #{ status: SweepConfigStatus.disabled },
  },
  returnType: #{ statusCode: HttpStatusOK, body: ExampleDisabledSweepConfig },
})
op patchSweepConfig(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @path
  sweepConfigID: SweepConfigID,

  @body body: PatchSweepConfig,
): UpdateResponses<SweepConfig, PatchSweepConfigError>;
