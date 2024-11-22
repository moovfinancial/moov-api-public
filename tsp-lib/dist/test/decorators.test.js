import { strictEqual } from "node:assert";
import { expectDiagnostics, extractCursor } from "@typespec/compiler/testing";
import { getAlternateName } from "../src/decorators.js";
import { createMoovfinancialTspLibTestRunner } from "./test-host.js";
describe("decorators", () => {
    let runner;
    beforeEach(async () => {
        runner = await createMoovfinancialTspLibTestRunner();
    });
    describe("@alternateName", () => {
        it("set alternate name on operation", async () => {
            const { test } = (await runner.compile(`@alternateName("bar") @test op test(): void;`));
            strictEqual(getAlternateName(runner.program, test), "bar");
        });
        it("emit diagnostic if not used on an operation", async () => {
            const diagnostics = await runner.diagnose(`@alternateName("bar") model Test {}`);
            expectDiagnostics(diagnostics, {
                severity: "error",
                code: "decorator-wrong-target",
                message: "Cannot apply @alternateName decorator to Test since it is not assignable to Operation"
            });
        });
        it("emit diagnostic if using banned name", async () => {
            const { pos, source } = extractCursor(`@alternateName(┆"banned") op test(): void;`);
            const diagnostics = await runner.diagnose(source);
            expectDiagnostics(diagnostics, {
                severity: "error",
                code: "@moovfinancial/tsp-lib/banned-alternate-name",
                message: `Banned alternate name "banned".`,
                pos: pos + runner.autoCodeOffset
            });
        });
    });
});
//# sourceMappingURL=decorators.test.js.map