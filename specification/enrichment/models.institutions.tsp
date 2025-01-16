import "@typespec/http";
using TypeSpec.Http;

namespace MoovAPI;

model InstitutionsFilters {
  @doc("Name of the financial institution. Either `name` or `routingNumber` is required.")
  @example("Farmers")
  @query
  name: string;

  @doc("Routing number for a financial institution. Either `routingNumber` or `name` is required.")
  @example("044112187")
  @query
  routingNumber: string;

  @doc("The state where a financial institution is based.")
  @example("IA")
  @query
  state: string;

  @doc("Maximum results returned by a search.")
  @example(499)
  @query
  limit: integer;
}

model AchParticipants {
  achLocation?: AchLocation;

  @example("Main Street Bank")
  customerName?: string;

  @example("987654321")
  @maxLength(9)
  newRoutingNumber?: string;

  @example("0")
  officeCode?: string;

  @example("123-456-7789")
  phoneNumber?: string;

  @example("1")
  recordTypeCode?: string;

  @example("041921")
  revised?: string;

  @example("123456789")
  @maxLength(9)
  routingNumber?: string;

  @example("123456789")
  servicingFRBNumber?: string;

  @example("1")
  statusCode?: string;

  @example("1")
  viewCode?: string;
}

model AchLocation {
  @example("123 Main Street")
  @maxLength(32)
  address?: string;

  @example("Boulder")
  @maxLength(24)
  city?: string;

  @example("80301")
  @maxLength(5)
  postalCode?: string;

  @example("0000")
  @maxLength(4)
  postalCodeExtension?: string;

  @example("Colorado")
  @maxLength(24)
  state?: string;
}
