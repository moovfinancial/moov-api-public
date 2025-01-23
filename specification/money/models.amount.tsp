namespace MoovAPI;

@doc("A 3-letter ISO 4217 currency code.")
@pattern("^[A-Za-z]{3}$")
@example("USD")
scalar Currency extends string;

@doc("A decimal-formatted numerical string that represents up to 2 decimal place precision. In USD for example, 12.34 is $12.34 and 0.99 is $0.99.")
@format(Decimal2StringPattern)
@example("-14.89")
scalar SignedDecimalString extends string;

model Amount {
  currency: Currency;

  @doc("""
    Quantity in the smallest unit of the specified currency. 
    
    In USD this is cents, for example, $12.04 is 1204 and $0.99 is 99.
    """)
  @example(1204)
  value: int64;
}

model AmountDecimal {
  currency: Currency;

  @doc("""
    A decimal-formatted numerical string that represents up to 9 decimal place precision. 
    
    For example, $12.987654321 is '12.987654321'.
    """)
  @pattern(Decimal9StringPattern)
  @example("12.987654321")
  valueDecimal: string;
}

const Decimal2StringPattern = "^\\d+\\.\\d{1,2}$";
const Decimal9StringPattern = "^\\d+\\.\\d{1,9}$";
