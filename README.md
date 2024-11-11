# GenGen

### Description
GenGen is a multi-purpose custom text generator app for iPhone. Now also using OpenAI API.

You can use it to:
- Brainstorm
- Create text-based content
- Lorem ipsum placeholder text
- Generate password
- Name your iguana, cat or the dragon in your next best seller
- Find a motto to your next billion dollar company, start-up, music band
- Funny phrases and jokes
  
It combines the concepts you feed it, adds the element of randomness and then AI magic. 

Demonstrating a modern, scalable, and testable architecture built using SOLID principles, clean architecture and protocol-oriented programming in Swift using UIKit. 
This project is designed to showcase best practices in iOS development, with modular components, reusable patterns, and a clear separation of concerns. 

---

### How to Run the Project

1. Clone the repository:
   ```sh
   git clone https://github.com/cgmajoor/GenGen.git
   cd GenGen
   ```

2. Open the Xcode project:
   ```sh
   open GenGen.xcodeproj
   ```

3. Configure Environment: Update any necessary configurations in the `Configuration` folder, such as API_KEY for OpenAI.

4. Build and Run:
   - Ensure a valid iOS simulator or device is connected.
   - Build and run the app in Xcode (⌘ + R).

---

### Project Structure

The project is organized into distinct folders to support modularity, scalability, and maintainability. Each folder and component adheres to a specific responsibility, following the principles of Clean Architecture and SOLID:

- **Configuration**: Contains environment configurations and initial project settings for a streamlined and adaptable app configuration.
- **GenGen**: The core module encapsulating all app logic, data, and UI components, organized as follows:
  - **App**: Entry point and environment setup with key components like `AppRouter`, `AppDelegate`, `Environment`, `AppConfig`, `AppTheme`, `Texts`, and `AppDependencies`.
  - **UseCases**: Business logic and application-specific rules organized as single-responsibility use cases, supporting testability, readability, and maintainability.
  - **GGData**: Contains data models, utilities, and CoreData integration.
  - **Modules**: Encapsulates individual feature modules with a focus on modularization and separation of concerns.
      - **Loading**: Manages initial app loading and preloading data states.
      - **Main**: Sets up the main interface and primary navigation structure.
      - **Onboarding**: Manages the user onboarding experience.
      - **Generator**: Core feature for generating and customizing content.
      - **Library**: Manages the library with books.
      - **Book**: Handles book-related features and its content management.
      - **Rules**: Provides content rules and restrictions management.
      - **RuleCreator**: Allows dynamic rule creation and management.
      - **Favorites**: Stores and manages user favorites.
   - **CustomViews**: Reusable and custom UI elements, enhancing modularity and ease of UI customization.
   - **Utility**: Shared utilities and helper functions that support the overall functionality of the app.
   - **Extensions**: Swift extensions used throughout the app, adhering to DRY principles and enhancing standard functionality.

---

### Requirements

- **iOS**: Version 16.2 and above.(Will be migrating to SwiftUI)
- **Xcode**: Version 14.0 or higher.
- **Swift**: Version 5.6 or higher.

---
### TO DO
- Auto fill a book with relevant words using AI
- Send a favorite back to generator
- Separate generator into 3 fields:
  - an editable text field that can be generated from user's library
  - text content generated by AI on that subject
  - image content generated by AI on that subject
- Add a collection view of premade prompts.
- Subscription to support AI.
- 

### Contributing

Contributions welcome from the open-source community to enhance functionality, improve modularity, and expand test coverage. Please follow the standard pull request process.

---

### License

This project is licensed under the MIT License. See the `LICENSE` file for more details.

---

### Contact

For questions, suggestions, or contributions, please reach out via GitHub issues or contact me directly.
