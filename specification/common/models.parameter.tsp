namespace MoovAPI;

@doc("The number of entries to skip when paginating a large result set.")
@example(60)
scalar Skip extends int64;

@doc("Limits the maximum number of results returned, or determines the page size when used with `skip` for pagination.")
@example(20)
scalar Count extends int64;
