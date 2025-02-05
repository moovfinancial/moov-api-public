namespace MoovAPI;

model BrandProperties {
  colors: BrandColors;
}

@doc("Brand colors for light and dark modes.")
model BrandColors {
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
