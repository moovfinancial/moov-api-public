import "../accounts/models.profile.tsp";

namespace MoovAPI;

@doc("A list of industries and their MCC/SIC/NAICS codes.")
model EnrichedIndustryResponse {
  industryCodes?: IndustryCodes;

  @example("AC, Refrigeration Repair")
  title?: string;
}
