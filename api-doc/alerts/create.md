# Create Alert

Create alert based on payload passed in request parameters. Send slack alert if it matches predefined rules

**URL** : `api/v1/alerts`

**Method** : `POST`

## Success Response

**Code** : `201 Created`

**Sample Raw JSON data**
```json
{
  "RecordType": "Bounce",
  "Type": "SpamNotification",
  "TypeCode": 512,
  "Name": "Spam notification",
  "Tag": "",
  "MessageStream": "outbound",
  "Description": "The message was delivered, but was either blocked by the user, or classified as spam, bulk mail, or had rejected content.",
  "Email": "zaphod@example.com",
  "From": "notifications@honeybadger.io",
  "BouncedAt": "2023-02-27T21:41:30Z"
}
```

**Sample response**

```json
{
    "status": "success"
}
```

**Format of Slack Message received**

```
The message sent to zaphod@example.com was delivered, but was either blocked by the user, or classified as spam, bulk mail, or had rejected content.
```

## Error Response

* No title passed

    **Code** : `403 Forbidden`

    **Reason** : Incorrect basic auth credentials

    **Sample Raw JSON data**
    ```json
    {
    "RecordType": "Bounce",
    "Type": "SpamNotification",
    "TypeCode": 512,
    "Name": "Spam notification",
    "Tag": "",
    "MessageStream": "outbound",
    "Description": "The message was delivered, but was either blocked by the user, or classified as spam, bulk mail, or had rejected content.",
    "Email": "zaphod@example.com",
    "From": "notifications@honeybadger.io",
    "BouncedAt": "2023-02-27T21:41:30Z"
    }
    ```

    **Sample response**

    ```json
    {
        "errors": {
            "request": [
                "Not authenticated"
            ]
        }
    }
    ```