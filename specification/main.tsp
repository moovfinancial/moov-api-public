import "@typespec/http";
import "@typespec/openapi";
import "@typespec/versioning";
import "@moovfinancial/tsp-lib";
import "./auth/models.auth.tsp";

// import each subdirectory's main
import "./accounts";
import "./adjustments";
import "./applepay";
import "./auth";
import "./bankaccounts";
import "./billing";
import "./branding";
import "./capabilities";
import "./cards";
import "./common";
import "./disputes";
import "./end2end";
import "./enrichment";
import "./files";
import "./issuing";
import "./onboarding";
import "./paymentlinks";
import "./paymentmethods";
import "./ping";
import "./representatives";
import "./schedules";
import "./transfers";
import "./underwriting";
import "./wallets";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

@service({
  title: "Moov API",
})
@doc("""
  Moov is a platform that enables developers to integrate all aspects of money movement with ease and speed.
  The Moov API makes it simple for platforms to send, receive, and store money. Our API is based upon REST
  principles, returns JSON responses, and uses standard HTTP response codes. To learn more about how Moov
  works at a high level, read our [concepts](https://docs.moov.io/guides/get-started/glossary/) guide.
  """)
@info({
  contact: {
    name: "Moov Developer Support",
    email: "help@moov.io",
    url: "https://moov.io",
  },
  license: {
    name: "Unlicensed",
    url: "http://www.apache.org/licenses/LICENSE-2.0.html",
  },
})
@server("https://api.moov.io", "Production API host")
@useAuth(BasicAuth | OAuth2<[]>)
@versioned(Versions)
@extension(
  "x-speakeasy-globals",
  {
    parameters: [
      {
        name: "x-moov-version",
        in: "header",
        schema: {
          $ref: "#/components/schemas/Versions",
        },
        `x-speakeasy-globals-hidden`: true,
      }
    ],
  }
)
namespace MoovAPI;
