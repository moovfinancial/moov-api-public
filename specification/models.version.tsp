namespace MoovAPI;

@doc("Moov API versions. Version strings are formatted as `vYYYY.MM.DD`, except preVerioned and latest.")
enum Versions {
  @doc("The default API version when no version header is specified")
  preVersioned: "",

  // add versions here, in chronological order

  latest: "latest",
}
