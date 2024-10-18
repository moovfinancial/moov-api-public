import "@typespec/versioning";
import "../models.version.tsp";

// import all routes
import "./routes.capability.tsp";

using TypeSpec.Versioning;

@versioned(MoovAPI.Versions)
namespace MoovAPI.Capabilities;
