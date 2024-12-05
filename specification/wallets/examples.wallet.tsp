import "./models.wallet.tsp";
import "../common/examples.id.tsp";

namespace MoovAPI;

const ExampleWallet: Wallet = #{
  walletID: ExampleID,
  availableBalance: #{ currency: "USD", value: 1234, valueDecimal: "12.34" },
};
