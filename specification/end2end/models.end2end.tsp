namespace MoovAPI;

const exampleEnd2EndEncryption = #{
  token: "eyJhbGciOiJFQ0RILUVTK0EyNTZLVyIsImVuYyI6IkEyNTZHQ00iLCJlcGsiOnsia3R5IjoiRUMiLCJjcnYiOiJQLTUyMSIsIngiOiJBS0NYVDM1WVdvTm8wbzExNy1SU0dqUGg3alN1NjFmLUhnYkx1dW0xVG1ueTRlcW5yX2hyU0hpY0w1d3gwODRCWDBRZjVTdEtkRUoydzY2ZUJqWHprRV9OIiwieSI6IkFIMEJfT2RaYTQtbG43dGJ4M3VBdlc1NDNQRE9HUXBCTDloRFFNWjlTQXNfOW05UWN3dnhRd1hrb1VrM3VzT1FnVV9ySVFrNFRoZ1NTUzV4UlhKcm5ZaTkifSwia2lkIjoiYmRvV3pLekpKUGw0TVFIaENDa05WYTZlZ1dmYi02V1haSjZKTFZqQ0hWMD0ifQ.HalyoHsfufBJEODd2lD9ThQvvVWw3b2kgWDLHGxmHhMv8rODyLL_Ug.rpQP178t8Ed_pUU2.Sn9UFeVoegAxiMUv11q7l3M0y9YHSLYi2n_JB7n7Pc777_47-icfaxstJemT0IC81w.akkq1EBxzWkBr4vEomSpWA",
};

@doc("""
  Optional and only used if planning to use End to End Encryption to pass PCI data through an intermediary. 
  This is the output of using compact serialization of a JWE token that wraps an AES key and uses the public key returned from /end-to-end-keys.
  Examples of how to create this token can be found on our [GitHub](https://github.com/moovfinancial/moov-go/blob/main/examples/e2ee/e2ee_test.go).
  Body for a JWE token following [RFC](https://datatracker.ietf.org/doc/html/rfc7516).
  """)
@example(exampleEnd2EndEncryption)
model End2EndEncryption {
  @format("JWE")
  token: string;
}

// Errors

model End2EndEncryptionError {
  token?: string;
}
