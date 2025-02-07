# Cat Breeds App

## 📌 Overview
Cat Breeds App is a SwiftUI-based iOS application that fetches and displays information about different cat breeds using [TheCatAPI](https://thecatapi.com/). The app follows the MVVM architecture and includes features such as pagination, image loading, and detailed breed information.

---

## 🚀 Setup Instructions

### Prerequisites
- Xcode (Latest version recommended)
- iOS 15.0 or later
- Swift Package Manager (SPM)

### Installation Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/your-repository/cat-breeds-app.git
   cd cat-breeds-app
   ```
2. Open `CatBreedsApp.xcodeproj` in Xcode.
3. Ensure you have an active internet connection to fetch API data.
4. Build and run the app on a simulator or physical device.

---

## 📦 Project Dependencies
This project does not use third-party dependencies. It relies on:
- `URLSession` for network requests.
- `SwiftUI` for building the user interface.
- `Combine` for reactive data binding (optional but recommended).

---

## ✅ Running Unit & UI Tests

### Unit Tests
The project includes unit tests for API calls and ViewModel logic.
To run the tests:
1. Open Xcode.
2. Select `Product > Test` or use the shortcut `Cmd + U`.
3. Ensure tests pass successfully.

### UI Tests
UI tests validate the navigation and interactions of the app.
To execute them:
1. Select the `PruebaTecASDUITests` target.
2. Run tests using `Cmd + U`.
3. Confirm UI elements behave as expected.

---

## 🏗️ Architectural Decisions

### MVVM Pattern
The project follows the **Model-View-ViewModel (MVVM)** pattern:
- **Model:** Represents data structures (e.g., `CatBreed`).
- **ViewModel:** Handles API calls and business logic (`CatBreedViewModel`).
- **View:** Displays UI elements (`ContentView`, `CatDetailView`).

### API Handling
- **Networking layer (`APIService.swift`)**: Uses `URLSession` to fetch data from `TheCatAPI`.
- **Error handling**: Ensures proper error messages are displayed when API calls fail.

### Pagination
- The app dynamically fetches more breeds when reaching the end of the list.

---

🎯 **Thank you for checking out Cat Breeds App! 🚀**

