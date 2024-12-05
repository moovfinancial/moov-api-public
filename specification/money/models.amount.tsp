namespace MoovAPI;

@doc("A 3-letter ISO 4217 currency code.")
@pattern("^[A-Za-z]{3}$")
scalar Currency extends string;

model Amount {
  currency: Currency;

  @doc("""
    Quantity in the smallest unit of the specified currency. 
    
    In USD this is cents, for example, $12.04 is 1204 and $0.99 is 99.
    """)
  value: int64;
}

const Decimal2StringPattern = "^\\d+\\.\\d{1,2}$";
const Decimal9StringPattern = "^\\d+\\.\\d{1,9}$";
