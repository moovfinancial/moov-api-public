import { DecoratorContext, Operation, Program } from "@typespec/compiler";
export declare const namespace = "MoovfinancialTspLib";
/**
 * __Example implementation of the `@alternateName` decorator.__
 *
 * @param context Decorator context.
 * @param target Decorator target. Must be an operation.
 * @param name Alternate name.
 */
export declare function $alternateName(context: DecoratorContext, target: Operation, name: string): void;
/**
 * __Example accessor for  the `@alternateName` decorator.__
 *
 * @param program TypeSpec program.
 * @param target Decorator target. Must be an operation.
 * @returns Altenate name if provided on the given operation or undefined
 */
export declare function getAlternateName(program: Program, target: Operation): string | undefined;
