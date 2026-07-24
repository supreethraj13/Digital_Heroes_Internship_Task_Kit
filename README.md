# Order Tracker

A two-screen Flutter order tracker that fetches orders from a mock JSON API hosted as a raw GitHub file.

## Run

```bash
flutter pub get
flutter run --dart-define=ORDERS_API_URL=https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/mock_api/orders.json
```

If `ORDERS_API_URL` is not provided, the app uses a placeholder GitHub raw URL. Replace it before submitting.

## Architecture

The Flutter code uses Bloc state management and a clean architecture folder split:

```text
lib/
  app/
  core/
  features/
    orders/
      data/
      domain/
      presentation/
        bloc/
        pages/
        widgets/
```

## Host the JSON on GitHub

1. Create a GitHub repository, for example `order-tracker-api`.
2. Add the file `mock_api/orders.json` from this project to that repository.
3. Commit and push it to the `main` branch.
4. Open the file on GitHub.
5. Click **Raw**.
6. Copy the browser URL. It will look like:

```text
https://raw.githubusercontent.com/YOUR_USERNAME/order-tracker-api/main/mock_api/orders.json
```

7. Use that URL in the Flutter app:

```bash
flutter run --dart-define=ORDERS_API_URL=https://raw.githubusercontent.com/YOUR_USERNAME/order-tracker-api/main/mock_api/orders.json
```

8. For a permanent default, replace `defaultOrdersApiUrl` in `lib/main.dart` with your raw GitHub URL.
# Digital_Heroes_Internship_Task_Kit
