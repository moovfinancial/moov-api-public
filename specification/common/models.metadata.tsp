namespace MoovAPI;

@doc("Free-form key-value pair list. Useful for storing information that is not captured elsewhere.")
@example(#{ optional: "metadata" })
model Metadata is Record<string>;
