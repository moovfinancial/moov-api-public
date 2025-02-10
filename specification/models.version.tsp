namespace MoovAPI;

@doc("""
  Moov API versions. 
  
  API versioning follows the format `vYYYY.QQ.BB`, where 
    - `YYYY` is the year
    - `QQ` is the two-digit month for the first month of the quarter (e.g., 01, 04, 07, 10)
    - `BB` is the build number, starting at `.01`, for subsequent builds in the same quarter. 
      - For example, `v2024.01.00` is the initial release of the first quarter of 2024.
  
  The `latest` version represents the most recent development state. It may include breaking changes and should be treated as a beta release.
  """)
enum Versions {
  @doc("The default API version when no version header is specified")
  preVersioned: "v2024.01.00",

  // Add quarterly versions here, in chronological order

  v2025q1: "v2025.01.00",

  v2025q2: "v2025.04.00",

  // latest should always be the last entry
  latest: "latest",
}
