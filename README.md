# GenGen

### Description
GenGen is an iOS app demonstrating a modern, scalable, and testable architecture built using SOLID principles, clean architecture, and protocol-oriented programming. This project is designed to showcase best practices in iOS development, with modular components, reusable patterns, and a clear separation of concerns. GenGen allows users to generate, manage, and interact with custom content in a structured, efficient way, leveraging dynamic data sources.

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

3. Configure Environment: Update any necessary configurations in the `Configuration` folder.

4. Build and Run:
   - Ensure a valid iOS simulator or device is connected.
   - Build and run the app in Xcode (⌘ + R).

---

### Project Structure

The project is organized into distinct folders to support modularity, scalability, and maintainability. Each folder and component adheres to a specific responsibility, following the principles of Clean Architecture and SOLID:

- **Configuration**: Contains environment configurations and initial project settings for a streamlined and adaptable app configuration.
- **GenGen**: The core module encapsulating all app logic, data, and UI components, organized as follows:
  - **App**: Entry point and environment setup with key components like `AppRouter`, `AppDelegate`, `Environment`, `AppConfig`, `AppTheme`, `Texts`, and `AppDependencies`.
  - **CustomViews**: Reusable and custom UI elements, enhancing modularity and ease of UI customization.
  - **Extensions**: Swift extensions used throughout the app, adhering to DRY principles and enhancing standard functionality.
  - **GGData**: Contains data models, utilities, and CoreData integration.
  - **Modules**: Encapsulates individual feature modules with a focus on modularization and separation of concerns.
      - **Loading**: Manages initial app loading and preloading data states.
      - **Main**: Sets up the main interface and primary navigation structure.
      - **Onboarding**: Manages the user onboarding experience.
      - **Generator**: Core feature for generating and customizing content.
      - **Library**: Manages user libraries and provides organizational tools.
      - **Book**: Handles book-related features and content management.
      - **Rules**: Provides content rules and restrictions management.
      - **RuleCreator**: Allows dynamic rule creation and management.
      - **Favorites**: Stores and manages user favorites.

- **UseCases**: Business logic and application-specific rules organized as single-responsibility use cases, supporting testability, readability, and maintainability.
- **Utility**: Shared utilities and helper functions that support the overall functionality of the app.

---

### Key Features & Principles

- **SOLID Principles**: The project adheres to SOLID principles to ensure high cohesion, low coupling, and maintainable code:
  - **Single Responsibility**: Each module and use case addresses one specific responsibility.
  - **Open/Closed Principle**: Extensible without modifying existing code.
  - **Liskov Substitution**: Interfaces allow components to be interchanged without impacting functionality.
  - **Interface Segregation**: Protocols are lean and specific, providing only the necessary contract.
  - **Dependency Inversion**: Modules depend on abstractions (protocols), enhancing testability and modularity.

- **Protocol-Oriented Programming (POP)**: Protocols define the relationships between components, making it easy to swap, test, and extend parts of the app without modifying the core logic.

- **APIE Architecture**: 
  - **Abstraction**: Use cases, protocols, and data repositories encapsulate business logic and data access.
  - **Polymorphism**: Protocols and generic classes allow seamless extension of features and modules.
  - **Inheritance & Encapsulation**: Common functionality encapsulated into reusable, inheritable base classes and utilities.

### Modules Overview

Each module in the project is designed as a standalone feature encapsulating its own presentation, business logic, and data requirements.

- **Loading Module**: Handles initial loading and data prepopulation.
- **Main Module**: Defines the main UI and navigation, housing the primary tab bar and navigation controllers.
- **Generator Module**: Core of the app, allowing users to generate content based on predefined rules and dynamic data sources.
- **Library Module**: Manages the content library, where users can view and organize generated items.
- **Book Module**: Handles book-specific content, ensuring modularity and encapsulation of book-related functionality.
- **Rules & RuleCreator Modules**: Provide robust rule management and custom rule creation, leveraging protocol-oriented programming.
- **Favorites Module**: Allows users to save and access favorite items, demonstrating data persistence and CoreData integration.

### Testing

The project is structured to facilitate testing, particularly unit tests for individual modules and use cases. Mocks and stubs for services and protocols are provided, allowing extensive testing across modules without relying on external dependencies.

---

### Requirements

- **iOS**: Version 16.2 and above.(I will be migrating it to SwiftUI)
- **Xcode**: Version 14.0 or higher.
- **Swift**: Version 5.6 or higher.

---

### Contributing

Contributions welcome from the open-source community to enhance functionality, improve modularity, and expand test coverage. Please follow the standard pull request process.

---

### License

This project is licensed under the MIT License. See the `LICENSE` file for more details.

---

### Contact

For questions, suggestions, or contributions, please reach out via GitHub issues or contact us directly.

--- 

This README provides a clear and professional overview that showcases your focus on SOLID principles, clean architecture, and protocol-oriented programming. It also offers insights into project structure, guiding other developers to easily navigate and understand the codebase.
