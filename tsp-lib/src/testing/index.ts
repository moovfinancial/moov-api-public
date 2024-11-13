import { resolvePath } from "@typespec/compiler";
import { createTestLibrary, TypeSpecTestLibrary } from "@typespec/compiler/testing";
import { fileURLToPath } from "url";

export const MoovfinancialTspLibTestLibrary: TypeSpecTestLibrary = createTestLibrary({
  name: "@moovfinancial/tsp-lib",
  packageRoot: resolvePath(fileURLToPath(import.meta.url), "../../../"),
});
