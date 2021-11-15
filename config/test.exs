import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :vse_minesweeper, VseMinesweeperWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "qlk/879msutc+eACqhQE1I5F+Wh9nfaytzd3mfwr8eNu5I///KiVhnhyGrG42uGz",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
