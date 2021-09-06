# Marley-Spoon-Challenge
Marley Spoon technical challenge, made by Tulio de Oliveira Parreiras

## Execution instructions
To run the project first is need to install the dependencies through CocoaPods.
1. Open Terminal
2. Select the project directory ```cd [PROJECT_DIRECTORY]```
3. Run install command ```pod install```

## Project information
The project was build using the following practices:
- TDD;
- MVP UI Design Pattern;
- Clean Architecture;

## Improvements suggestions
Following the suggestion of 3-4 hours of development, if continuing the building application the next features would be:
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
