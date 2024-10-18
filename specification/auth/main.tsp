import "@typespec/versioning";
import "../models.version.tsp";

import "./routes.auth.tsp";

using TypeSpec.Versioning;

@versioned(MoovAPI.Versions)
namespace MoovAPI.Auth;
