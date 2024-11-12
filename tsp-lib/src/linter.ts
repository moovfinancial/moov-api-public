import { defineLinter } from "@typespec/compiler";
import { noInterfaceRule } from "./rules/no-interfaces.rule.js";

export const $linter = defineLinter({
  rules: [noInterfaceRule],
  ruleSets: {
    recommended: {
      enable: { [`@moovfinancial/tsp-lib/${noInterfaceRule.name}`]: true },
    },
    all: {
      enable: { [`@moovfinancial/tsp-lib/${noInterfaceRule.name}`]: true },
    },
  },
});
