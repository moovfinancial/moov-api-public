namespace MoovAPI;

@doc("The operating mode for an account.")
@example(Mode.production)
enum Mode {
  @doc("Sandbox mode is used to develop and test API integrations without actually moving money.")
  sandbox,

  @doc("Production mode is used for real money movement in a production environment.")
  production,
}
