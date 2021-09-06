# Marley-Spoon-Challenge

Marley Spoon technical challenge, made by Tulio de Oliveira Parreiras

## Execution instructions

To run the project, follow the steps:

1. Clone the repo;
2. Open Terminal;
3. Select the project directory ```cd [PROJECT_DIRECTORY]```;
4. Run install command ```pod install```;

## Project information

The project was build using the TDD technique following the Clean Architecture (Onion) for the project and the MVP UI Design Pattern for the UI. It was used the SOLID principles, POP (Protocol Oriented Programming), and Clean Code practices.

## Improvements suggestions

Following the suggestion of 3-4 hours of development I stoped the project implementation with open space for new features and improvements such as:

- Create UI Tests;
- Secure the sensitive data (ContentFul ids);
- Add persistence;
- Improve Design;
- Make presentation layers UI agnostic (they shouldn't import UIKit) making them reusable across platforms;
- Extract UI agnostic objects into a separate macOS framework, to make Unit tests faster;
- Handle network failure cases;
- Localize static texts (controllers titles);
- Write unit tests for presentation layers;
- Implement Snapshot tests;
- Integrate with CI/CD tools;
- Create WatchOS target;
- Move to reactive architecture;
- Create SwiftUI implementation;
