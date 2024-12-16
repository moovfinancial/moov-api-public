import "@typespec/openapi3";

using TypeSpec.OpenAPI;

namespace MoovAPI;

model Brand {
  @doc("Set brand accent colors for light and dark modes.")
  colors: Colors;
}

model Colors {
  dark: BrandColor;
  light: BrandColor;
}

model BrandColor {
  accent: AccentColor;
}

model UpdateBrand {
  colors?: UpdateColors;
}

model UpdateColors {
  dark?: UpdateColor;
  light?: UpdateColor;
}

model UpdateColor {
  accent?: string;
}

@doc("A CSS hex color representing an accent color.")
@example("#111111")
scalar AccentColor extends string;

model BrandValidationError {
  colors?: ColorsValidationError;
}

model ColorsValidationError {
  light?: BrandColorValidationError;
  dark?: BrandColorValidationError;
}

model BrandColorValidationError {
  accent?: string;
}
