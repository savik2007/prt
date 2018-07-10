# PRT

##Tasks
Before start use application please add all values in config in the section `config :prt, PRT.Repo`

For run dialyzer
```elixir
mix dialyzer
```

For run ecto migration
```elixir
mix ecto.migration
```

For start application:
```elixir
iex -S mix
```

For run first task:
```elixir
PRT.wrap_lists([1, 2], ["a", "b", "c"])
```

For run second task :
```elixir
PRT.ecto_query()
```

For run third task:
```elixir
PRT.starts("rails/rails")
```

##Question

I had worked with Erlang before I started work with Elixir. As Elixir was written over Erlang I can`t compare this language. 

As for me the main problem in Erlang(in Elixir too) - is that you have to be careful with memory. Under certain conditions, it begins to grow strongly

I don`t like next thinks in Elixir/Phoenix:
1) not original Bootstrap file
2) routing created very long links
3) you are limited in all
