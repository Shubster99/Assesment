#Flutter Article App

A clean and modern Flutter application that fetches and displays a list of articles from a public API. Built using **clean architecture** principles and designed with responsiveness and usability in mind.

---

## Features

- **List of Articles**  
  Fetches and displays a dynamic list of articles in an elegant UI.

- **Search Functionality**  
  Allows users to filter articles in real-time via a search bar.

- **Detail View**  
  Navigate to a detailed screen showing full article content.

- **Responsive UI**  
  Fully adaptive layout supporting different screen sizes and orientations.

---

## Architecture

This app follows the **Clean Architecture** pattern with a clear separation of concerns:
- **Presentation Layer**: Handles UI and user interaction.
- **Domain Layer**: Contains business logic and use cases.
- **Data Layer**: Manages data sources and repositories (API, persistence).

---

## Tech Stack

- **Flutter SDK**: `3.29.2`
- **State Management**: [`Provider`](https://pub.dev/packages/provider) – Simple and efficient state management suited for this project scale.
- **HTTP Client**: [`Dio`](https://pub.dev/packages/dio) – Robust HTTP client used for REST API calls.
- **Persistence**: [`shared_preferences`](https://pub.dev/packages/shared_preferences) – Used to persist user data locally (e.g., favorites).

---

## Bonus Features

- **Pull to Refresh**  (implemented)
  Easily refresh the article list by pulling down.

- **Favorites Tab**  (implemented)
  Users can mark articles as favorites and view them in a separate **Favorites** tab using tab-based navigation.
