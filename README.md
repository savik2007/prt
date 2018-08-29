# PRT

Before start use application you should add configuration of data in the section `config :prt, PRT.Repo`


### For run dialyzer
```elixir
mix dialyzer
```

### For run ecto migration
```elixir
mix ecto.migration
```

### For run tests
```elixir
mix test
```

### For start application:
```elixir
iex -S mix
```

### First task:
    Function that accepts two lists and returns keyword list with keys (a,b) that combines two list.
    Example:
      => wrap_lists([1, 2], ["a", "b", "c"])
      => [[a: 1, b: "a"], [a: 1, b: "b"], [a: 1, b: "c"], [a: 2, b: "a"], [a: 2, b: "b"], [a: 2, b: "c"]]
```elixir
PRT.wrap_list([1, 2], ["a", "b", "c"])
```

### Second task:
    There is a database with table users(id, name) and posts(id, kind, text) where kind in
      ('article', 'promotion', 'link', 'image').
    Write an ecto query that returns such array of maps for all users and count of each kind of posts
```elixir
PRT.ecto_query()
```

### Third task:
    Write a module with the function that accepts public repo name and returns stars count for this repo.
    If repo is private it returns `{:error, "repo is private"}`
    Example:
      => Github.starts("rails/rails")
      => {:ok, 40114}
```elixir
PRT.github_stars("rails/rails")
```