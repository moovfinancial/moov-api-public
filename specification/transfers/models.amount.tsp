namespace MoovAPI;

model Amount {
  @doc("A 3-letter ISO 4217 currency code.")
  @example("USD")
  currency: string;

  @doc("""
    Quantity in the smallest unit of the specified currency. 
    
    In USD this is cents, for example, $12.04 is 1204 and $0.99 is 99.
    """)
  @example(1204)
  value: int64;
}
