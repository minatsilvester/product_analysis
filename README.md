# ProductAnalysis

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

### post "/events"
- Api to create events
- Takes JSON in format 
```json
{
    "event": {
        "user_id": "user1",
        "event_time": "2024-02-28T12:34:56Z",
        "event_name": "subscription_activated",
        "attributes": {
            "plan": "pro",
            "billing_interval": "year"
        }

    }
}
```

- The event can contain the following data:
  1. User ID - Required. A string
  2. Event time - Optional. If left empty, should default to "now". Note that clients can send historical events, and not necessarily in chronological order.
  3. Event name - Required.
  4. Attributes - Required. A free-form JSON object

### get "/user_analytics"
 - Api to get user analytics
 - Return a JSON
 ```json
 [
    {
        "count": 2,
        "last_event_time": "2024-02-28T12:34:56",
        "user_id": "user1"
    }
]
 ```
 - accetps event name as a query param

 ### get "/event_analytics"
 - API endpoint to return aggregated event counts over time
 - returns a json
 ```json
 [
    {
        "count": 2,
        "date": "2024-02-28T12:34:56",
        "unique_count": 1
    }
]
 ```
 - accepts from, to and event_name as query params