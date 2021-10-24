# 🌌 ~ Arisu.Telemetry
> Telemetry server for Arisu, to collect error reports and data usage around Arisu development tools, made in Elixir.

## Why? Is this needed?
Yes, and no.

Yes because it'll inform the team on the following things:

- data usage (based off CLI, backend, frontend, etc)
- error reports (ones to priortize; if it is repeative)

No because people have a sense of mind and think:

> "Huh, this application has telemetry built-in? Well... I am kinda scared
> of them using my data for [insert reasons here], so I won't use it."

But, I do not plan to sell your data to bigger companies and mask it in our servers so no one except
for our team can access it. You can read up on what we do with your data in our [Terms of Service](https://arisu.land/tos).

This will just report us on what we need to do to make Arisu better! Read up on your [documentation](https://docs.arisu.land/telemetry) for a more detailed introduction.

## Running **Arisu.Telemetry**
You will need the following tools before starting:

- [**PostgreSQL**](https://postgresql.org) ~ **Main database for holding telemetry data. Recommended version is 10 or higher.**
- [**Elixir**](https://elixir-lang.org) ~ **Dynamic, functional language for building scalable and maintainable applications.**

```sh
# 1. Pull the repository into your local machine
$ git clone https://github.com/arisuland/telemetry-server && cd telemetry-server

# 2. Pull dependencies with `mix`
$ mix deps.get

# 3. Run Ecto migrations
$ mix ecto.setup

# 4. Run the Phoenix server
$ iex -S mix phx.server

# Remove `iex -S` if you wish to run the server, and not have an interactive prompt.
```

## How do you not get counterfit packets?
It's easy to send couterfit packets since our components are 100% open source, but you need to be signed in
to send the packet since, it's tied to your user account. So, you'll need to send in a session token:

```http
Authorization: Session <token>
```

In which, it is not easy to retrieve unless you query the `login` mutation with a successful login.

## Structure
**Tsubaki**, **Arisu**, **CLI**, and the SDKs will send the following packet if telemetry is enabled:

```js
{
  "format_version": 1,
  "project": "user/project",
  "os": {
    "platform": "win32/macOS/linux",
    "version": "release version",
    "arch": "x86_64/x86/arm"
  },

  // If any unofficial SDKs send in telemetry,
  // it'll automatically return a 403 Forbidden status code.
  //
  // so, please don't create telemetry requests in an unofficial SDK.
  "sent_by": "tsubaki/frontend/cli/sdk-{{official_sdk_id}}",

  // If it's from the CLI:
  "platform": {
    "type": "cli",

    // flags are omitted!
    "arguments": "arisu init"
  },

  // If it's from Tsubaki:
  "platform": {
    "type": "tsubaki",
    "http": {
      "endpoint": "...",
      "method": "...",
      "time": 0.35
    },
    "graphql": {
      "operation": "query/mutation",
      "query": "// query string"
    }
  },

  // If it's from the frontend:
  "platform": {
    "type": "frontend",
    "route": "...", // using unknown routes, `/~/{username}`, or project settings will not be applied.
    "time": 0.35
  }
}
```

## How do I disable it?
It's easy to disable telemetry, you can:

- Disable it in [user settings](https://arisu.land/user/settings) under the **Telemetry** tab.
- Running `arisu telemetry opt-out`, if you're using the **CLI**.
- Using the `ARISU_TELEMETRY_ENABLED` environment variable.

## License
**telemetry-server** is released under the **GPL-3.0** License, read [here](/LICENSE) for more information.
