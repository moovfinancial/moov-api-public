export declare const $lib: import("@typespec/compiler").TypeSpecLibrary<{
    "banned-alternate-name": {
        readonly default: import("@typespec/compiler").CallableMessage<["name"]>;
    };
}, Record<string, any>, "alternateName">;
export declare const reportDiagnostic: <C extends "banned-alternate-name", M extends keyof {
    "banned-alternate-name": {
        readonly default: import("@typespec/compiler").CallableMessage<["name"]>;
    };
}[C]>(program: import("@typespec/compiler").Program, diag: import("@typespec/compiler").DiagnosticReport<{
    "banned-alternate-name": {
        readonly default: import("@typespec/compiler").CallableMessage<["name"]>;
    };
}, C, M>) => void, createDiagnostic: <C extends "banned-alternate-name", M extends keyof {
    "banned-alternate-name": {
        readonly default: import("@typespec/compiler").CallableMessage<["name"]>;
    };
}[C]>(diag: import("@typespec/compiler").DiagnosticReport<{
    "banned-alternate-name": {
        readonly default: import("@typespec/compiler").CallableMessage<["name"]>;
    };
}, C, M>) => import("@typespec/compiler").Diagnostic, StateKeys: Record<"alternateName", symbol>;
