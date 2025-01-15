namespace MoovAPI;

@doc("Describes an [RFC7517](https://datatracker.ietf.org/doc/html/rfc7517) web key.")
@example(
  #{
    use: "enc",
    kty: "EC",
    kid: "bOaoOIgm-7dI_gBIvsr0jQrPyYp6H_od0Ok-hSYZQ-g=",
    crv: "P-521",
    alg: "ECDH-ES+A256KW",
    x: "ABcm3wzKpPzYYwjDC0HSrxxVM3ULbuMDUuzkR5wNciaMHkZvQ02gLFdqTL65evV7EWaQyC7zRc28eW20p5MVDdQr",
    y: "AVa-eQsoiltOcQYy1QEcrQ9NbWktl_D4ewfg8diOZ2_svLEgEu4T1PqNcLbBGozP_VqPkXOMwNCUNI7pxajVGiIP",
  },
  #{ title: "Elliptic Curve public key" }
)
model JSONWebKey {
  // Common for all key types

  @doc("The cryptographic algorithm family used with the key (e.g., 'RSA', 'EC', 'oct').")
  kty: string;

  @doc("The intended use of the key. 'sig' for signature, 'enc' for encryption.")
  use?: "sig" | "enc";

  @doc("The permitted operations for the key, e.g., 'sign', 'verify', 'encrypt', 'decrypt'.")
  key_ops?: string[];

  @doc("The algorithm intended for use with the key, e.g., 'RS256' or 'ES256'.")
  alg?: string;

  @doc("A unique identifier for the key.")
  kid?: string;

  ///////////////////////////
  // Elliptic Curve
  ///////////////////////////

  @doc("""
    The curve for Elliptic Curve keys, e.g., 'P-256', 'P-384', or 'P-521'.
    
    This field is required when `kty` is 'EC'.
    """)
  crv?: string;

  @doc("""
    The x coordinate for Elliptic Curve keys.
    
    This field is required when `kty` is 'EC'.
    """)
  x?: string;

  @doc("""
    The y coordinate for Elliptic Curve keys.
    
    This field is required when `kty` is 'EC'.
    """)
  y?: string;

  ///////////////////////////
  // RSA
  ///////////////////////////

  @doc("""
    The modulus value for RSA keys.
    
    This field is required when `kty` is 'RSA'.
    """)
  n?: string;

  @doc("""
    The exponent value for RSA keys.
    
    This field is required when `kty` is 'RSA'.
    """)
  e?: string;
}
