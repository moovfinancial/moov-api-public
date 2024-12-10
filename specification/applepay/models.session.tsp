import "./models.domain.tsp";

namespace MoovAPI;

model CreateApplePaySession {
  @doc("""
    A fully qualified top-level or sub-domain name where you will accept Apple Pay. Should not include "https".
    """)
  @example("checkout.classbooker.dev")
  domain: string;

  displayName: DomainDisplayName;
}

@doc("""
  Stringified session object returned from Apple Pay.
  
  The string value should be deserialized as a JSON object before passing to Apple.
  """)
@example("""
  {\"epochTimestamp\":1733783167685,\"expiresAt\":1733786767685...}
  """)
scalar ApplePaySession extends string;
