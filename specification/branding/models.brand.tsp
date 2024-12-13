import "@typespec/openapi3";

using TypeSpec.OpenAPI;

namespace MoovAPI;

model Brand {
  @doc("Set brand accent colors for light and dark modes.")
  colors: Colors;
}

model Colors {
  dark: Dark;
  light: Light;
}

model Dark {
  @doc("A CSS hex color representing the accent color for use in dark mode.")
  @example("#111111")
  accent: string;
}

model Light {
  @doc("A CSS hex color representing the accent color for use in light mode.")
  @example("#ffffff")
  accent: string;
}

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
