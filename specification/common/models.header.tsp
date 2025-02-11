import "@typespec/http";
import "@typespec/openapi";
import "../models.version.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

model VersionHeader {
  @doc("""
    Specify an API version.
    
    API versioning follows the format `vYYYY.QQ.BB`, where 
      - `YYYY` is the year
      - `QQ` is the two-digit month for the first month of the quarter (e.g., 01, 04, 07, 10)
      - `BB` is the build number, starting at `.01`, for subsequent builds in the same quarter. 
        - For example, `v2024.01.00` is the initial release of the first quarter of 2024.
    
    The `latest` version represents the most recent development state. It may include breaking changes and should be treated as a beta release.
    """)
  @header
  @example("v2025.01.00")
  @extension("x-speakeasy-globals-hidden", true)
  xMoovVersion?: string = "v2024.01.00"; // default to Versions.preVersioned;
}

model CommonRequestHeaders {
  ...VersionHeader;
}

model RequestIDHeader {
  @doc("A unique identifier used to trace requests.")
  @format("uuid")
  @header
  xRequestID: string;
}

model CommonResponseHeaders {
  ...RequestIDHeader;
}
