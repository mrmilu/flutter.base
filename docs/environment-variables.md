# Environment variables

> ℹ️ .env variables are loaded automatically by Vite. Refer to this documentation for more information. [Loading Environment Variables](https://vitejs.dev/guide/env-and-mode#env-files).

> Good to know: `.env.beta`, `.env.dev`, and `.env.live` files should be included in your repository as they define defaults. `.env` should be added to .gitignore, as this files is intended to be ignored. `.env` is where secrets can be stored.

## Values

| Key                             | Responsible | Type      | Secret | Policy                    | Default value                       | Description                                                                            | Docs                                                                                                                          |
| ------------------------------- | ----------- | --------- | ------ | ------------------------- | ----------------------------------- | -------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| `API_URL`                       | DevOps      | `string`  | No     | `DEFAULT`                 | `https://f84a-2-139-107-2.ngrok.io` | Requests API URL                                                                       |
| `ENVIRONMENT`                   | DevOps      | `string`  | No     | `DEFAULT`                 | `dev`                               | Environment                                                                            | -                                                                                                                             |
| `APP_NAME`                      | DevOps      | `string`  | No     | `DEFAULT`                 | `Flutter base (dev)`                | Application name                                                                       | -                                                                                                                             |
| `FIREBASE_REVERSED_CLIENT_ID`   | DevOps      | `string`  | No     | `REQUIRED-IN-RELEASE-ENV` | -                                   | Value on `REVERSED_CLIENT_ID` from `GoogleService-Info.plist` downloaded from firebase | [Implementa el Acceso con Google](https://firebase.google.com/docs/auth/ios/google-signin?hl=es-419#implement_google_sign-in) |
| `DYNAMIC_LINK_HOST`             | DevOps      | `boolean` | No     | `REQUIRED-IN-RELEASE-ENV` | -                                   | Dynamic link domain url                                                                | [Receive Firebase Dynamic Links in a Flutter app](https://firebase.google.com/docs/dynamic-links/flutter/receive)             |
| `DYNAMIC_LINKS_URL_TYPE_SCHEMA` | DevOps      | `boolean` | No     | `REQUIRED-IN-RELEASE-ENV` | -                                   | applicationId/bundleId                                                                 | [Receive Firebase Dynamic Links in a Flutter app](https://firebase.google.com/docs/dynamic-links/flutter/receive)             |
| `SENTRY_DSN`                    | DevOps      | `string`  | No     | `REQUIRED-IN-RELEASE-ENV` | -                                   | Sentry DSN                                                                             | [Sentry DSN](https://docs.sentry.io/concepts/key-terms/dsn-explainer/)                                                        |

## Policies
- `DEFAULT`: This environment variable has a default value that works on most common usages
- `REQUIRED`: This environment variable must be set, otherwise the application will not start throwing an exception
- `REQUIRED-IN-RELEASE-ENV`: This environment variable must be set in release environments, the application will start but won't comply requirements: security, functionality, integration, performance, etc
- `FEATURE-FLAG`: This environment variable changes a feature behavior 
- `DEPRECATED`: Deprecated variables, see deprecated variables section

## Types
- `boolean`: string variable containing a boolean value 
- `string`: string variable
- `fs_path`: string variable containing a path in the file system
- `email`: string variable containing an email
- `string-list-by-comma`: list string values extracted by: split (using `,` as the separator) and trim