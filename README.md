Blatt
===

Just a Dependency Injection Container.

Why?
===

This gem allow us to write down the dependency graph in an external file, like JSON, [TOML](https://github.com/toml-lang/toml). It won't parse those files tho because we don't want to force down any format on you.

Usage
===

**dependencies.json**

```javascript
  {
    "photo_service": {
      "object": "Example::Services::Photo",
      "dependencies": ["photos_repository", "some string", 15]
    },
    "photos_repository": {
      "object": "Example::Repositories::Photos",
      "dependencies": []
    }
  }
```

**app.rb**

```ruby
  require "json"
  require "blatt"

  Blatt::Fetcher.new(JSON.parse("dependencies.json", symbolize_names: true))

  photo_service = Blatt.get("photo_service")

  # Let's suppose every dependency is public :)

  photo_service.the_injected_repository # => "Example::Repositories::Photos"
  photo_service.the_injected_string     # => "String:some string"
  photo_service.the_injected_integer    # => "Integer:15"

  # It always returns the same instance

  Blatt.get("photo_service") == photo_service # => True
```
