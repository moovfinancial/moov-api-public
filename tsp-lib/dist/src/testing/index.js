import { resolvePath } from "@typespec/compiler";
import { createTestLibrary } from "@typespec/compiler/testing";
import { fileURLToPath } from "url";
export const MoovfinancialTspLibTestLibrary = createTestLibrary({
    name: "@moovfinancial/tsp-lib",
    packageRoot: resolvePath(fileURLToPath(import.meta.url), "../../../"),
});
//# sourceMappingURL=index.js.map