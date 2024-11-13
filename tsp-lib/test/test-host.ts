import { createTestHost, createTestWrapper } from "@typespec/compiler/testing";
import { MoovfinancialTspLibTestLibrary } from "../src/testing/index.js";

export async function createMoovfinancialTspLibTestHost() {
  return createTestHost({
    libraries: [MoovfinancialTspLibTestLibrary],
  });
}

export async function createMoovfinancialTspLibTestRunner() {
  const host = await createMoovfinancialTspLibTestHost();

  return createTestWrapper(host, {
    autoUsings: ["MoovfinancialTspLib"]
  });
}

