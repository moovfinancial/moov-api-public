import { StateKeys, reportDiagnostic } from "./lib.js";
export const namespace = "MoovfinancialTspLib";
/**
 * __Example implementation of the `@alternateName` decorator.__
 *
 * @param context Decorator context.
 * @param target Decorator target. Must be an operation.
 * @param name Alternate name.
 */
export function $alternateName(context, target, name) {
    if (name === "banned") {
        reportDiagnostic(context.program, {
            code: "banned-alternate-name",
            target: context.getArgumentTarget(0),
            format: { name },
        });
    }
    context.program.stateMap(StateKeys.alternateName).set(target, name);
}
/**
 * __Example accessor for  the `@alternateName` decorator.__
 *
 * @param program TypeSpec program.
 * @param target Decorator target. Must be an operation.
 * @returns Altenate name if provided on the given operation or undefined
 */
export function getAlternateName(program, target) {
    return program.stateMap(StateKeys.alternateName).get(target);
}
//# sourceMappingURL=decorators.js.map