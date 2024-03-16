# Store

```bash
MIX_ENV=dev  mix ecto.drop && mix ecto.setup
MIX_ENV=test mix ecto.drop && mix ecto.migrate
```

`mix run priv/repo/seeds.exs`
