import "@typespec/versioning";
import "../models.version.tsp";

// import all routes
import "./routes.account.tsp";

using TypeSpec.Versioning;

@versioned(MoovAPI.Versions)
namespace MoovAPI.Accounts;
