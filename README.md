<p align="center">
  <img src="https://github.com/tushal13/quetter/assets/113960162/7b5ba370-646c-40ec-b961-f2b60468df64" alt="Quetter" />
</p>

<h1 align="center">Quetter</h1>


<p align="center">
  <strong>A versatile Flutter app featuring motivational quotes, wallpapers, and Google AdMob integration</strong>
</p>

## Features

### Authentication Page

- **User Authentication**: Register or sign in using email/password or Google Sign-In for a secure authentication process.

### Quote Page

- **Inspiring Quotes**: Curated collection of motivational and thought-provoking quotes to uplift and inspire users.
- **Category Exploration**: Explore different quote categories, save favorites, and share wisdom with friends.

### Wallpaper Page

- **Diverse Wallpapers**: Utilizes the PixaBay API to offer a wide range of wallpapers in various categories.
- **Color Analysis**: Enhances visual experience through color analysis, providing dynamic and aesthetically pleasing wallpapers.
- **User Customization**: Allows users to personalize their profile with custom wallpapers.

### Downloaded Quotes Page

- **Local Storage**: Manages locally stored quotes using an SQLite database.
- **Efficient Management**: Add, retrieve, and display favorite quotes for a personalized collection.

### Profile Page

- **Personalized Experience**: Customize wallpapers based on preferences.
- **History Tracking**: Track recently viewed wallpapers and manage account information.

### Google AdMob Integration

- **In-App Monetization**: Implement Google AdMob for effective monetization.
- **Rewarded Ads**: Allow users to earn rewards by watching ads.
- **Banner Ads**: Display non-intrusive banner ads for additional revenue.

## Technologies Used

- **Flutter**: Google's UI toolkit for natively compiled applications.
- **Firebase Authentication**: Securely authenticate and manage user profiles.
- **SQLite Database**: Local storage for efficient quote management.
- **PixaBay API**: Integration for diverse and dynamic wallpapers.
- **Google AdMob**: Monetize the app with effective in-app advertisements.
- [Other dependencies]

## Directory Structure

📦 Qutter                                                                                                                                         
 ┣ 📂 lib                                                                                                                                                        
 ┃ ┣ 📂 controller                                                                                                                                                
 ┃ ┃ ┣ 📜 db_controller.dart                                                                                                                                        
 ┃ ┃ ┣ 📜 pixa_controller.dart                                                                                                                                
 ┃ ┃ ┣ 📜 quet_controller.dart                                                                                                                                
 ┃ ┃ ┗ 📜 user_controller.dart                                                                                                                                                                
 ┃ ┣ 📂 helper                                                                                                                                                       
 ┃ ┃ ┣ 📜 ad_helper.dart                                                                                                                                                                      
 ┃ ┃ ┣ 📜 db_helper.dart                                                                        
 ┃ ┃ ┣ 📜 fb_auth_helper.dart                                                                  
 ┃ ┃ ┣ 📜 fb_store_helper.dart                                                                 
 ┃ ┃ ┣ 📜 fbs_helper.dart                                                                      
 ┃ ┃ ┣ 📜 pixa_helper.dart                                                                     
 ┃ ┃ ┗ 📜 quet_helper.dart                                                                                                                                                           
 ┃ ┣ 📂 views                                                                                                                                
 ┃ ┃ ┣ 📂 component                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 background_tile.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 category_tile.dart                                                                                                                                
 ┃ ┃ ┃ ┗ 📜 quote_tile.dart    
 ┃ ┃ ┣ 📂 modal                                                                                                                                                        
 ┃ ┃ ┣ 📜 quate_modal.dart                                                                                                                                
 ┃ ┃ ┣ 📜 topic_modal.dart                                                                                                                                
 ┃ ┃ ┣ 📜 user_modal.dart                                                                                                                                
 ┃ ┃ ┗ 📜 yquate_modal.dart                                                                 
 ┃ ┣ 📂 utility                                                                                
 ┃ ┃ ┣ 📜 preferred_lists.dart   
 ┃ ┃ ┗ 📜 topics.dart                                                                      
 ┃ ┃ ┣ 📂 screens                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 add_page.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 background_page.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 dwonload_page.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 favorite_page.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 home_page.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 intro_page1.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 intro_page2.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 intro_page3.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 intro_page4.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 past_page.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 prefrence_page.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 qoute_priview.dart                                                                                                                                
 ┃ ┃ ┃ ┣ 📜 setting_page.dart
 ┃ ┃ ┃ ┣ 📜 splesh_screen.dart 
 ┃ ┃ ┃ ┗ 📜 your_page.dart                                                                                                                                
 ┃ ┣ 📜 firebase_options.dart                                                                                                                                
 ┃ ┣ 📜 main.dart                                                                               
 ┗ 📜 .gitignore
 
## MVC Architecture Overview

The app follows the MVC (Model-View-Controller) architectural pattern, promoting a well-structured and modular codebase. Below are the key components of the MVC pattern observed in the Qutter project:

### Controllers (lib/controller)

- **Responsibility**: Manages application logic and acts as an intermediary between the Model and the View.
- **Key Controllers**:
  - `db_controller.dart`: Handles database-related operations and interactions.
  - `pixa_controller.dart`: Manages PixaBay API interactions for wallpapers.
  - `quet_controller.dart`: Controls quote-related functionalities.
  - `user_controller.dart`: Handles user-related operations.

### Helpers (lib/helper)

- **Responsibility**: Provides utility and helper functions across the app.
- **Key Helpers**:
  - `ad_helper.dart`: Assists with ad-related functionalities, including AdMob integration.
  - `db_helper.dart`: Facilitates operations related to database management.
  - `fb_auth_helper.dart`: Handles Firebase authentication operations.
  - `fb_store_helper.dart`: Assists in handling interactions with Firestore.
  - `fbs_helper.dart`: Utility functions for Firebase services.
  - `pixa_helper.dart`: Supports interactions with the PixaBay API.
  - `quet_helper.dart`: Helper functions for managing quotes.

### Views (lib/views)

- **Responsibility**: Represents the visual elements of the app.
- **Key Subdirectories**:
  - `component`: Custom widgets and components used across the app.
    - `background_tile.dart`: Custom widget for displaying background options.
    - `category_tile.dart`: Custom widget for displaying quote categories.
    - `quote_tile.dart`: Custom widget for displaying individual quotes.
  - `modal`: Modal classes defining the structure of data objects.
    - `quate_modal.dart`: Represents the structure of a quote.
    - `topic_modal.dart`: Represents the structure of a topic.
    - `user_modal.dart`: Describes the attributes and properties of a user.
    - `yquate_modal.dart`: Represents a specialized quote structure.
  - `utility`: Utility classes providing additional functionalities.
    - `preferred_lists.dart`: Handles preferred lists.
    - `topics.dart`: Utility functions related to topics.
  - `screens`: Individual screens of the app.
    - `add_page.dart`: Screen for adding new quotes.
    - `background_page.dart`: Screen for managing background options.
    - `download_page.dart`: Screen for managing downloaded content.
    - `favorite_page.dart`: Screen for managing favorite quotes.
    - `home_page.dart`: Main screen displaying quotes and categories.
    - `intro_page1.dart` to `intro_page4.dart`: Introduction screens.
    - `past_page.dart`: Screen for viewing past quotes.
    - `preference_page.dart`: Screen for managing user preferences.
    - `quote_preview.dart`: Screen for previewing a quote.
    - `setting_page.dart`: Screen for app settings.
    - `your_page.dart`: User-specific screen.

### Other Key Files

- `firebase_options.dart`: Configuration file for Firebase options.
- `main.dart`: The main entry point of the application.

### Git Ignore

- `.gitignore`: Ignored files and directories for version control.

This organized structure adheres to the MVC pattern, promoting maintainability and scalability of the codebase.

 ## Dependencies

### [Flutter](https://flutter.dev/)
Google's UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.

### [Provider Package](https://pub.dev/packages/provider)
State management for efficient communication between different components of the app.

### [SQFlite](https://pub.dev/packages/sqflite)
SQLite plugin for Flutter. Used for local database storage for persistent data management.

### [Path](https://pub.dev/packages/path)
Provides common operations for working with file and directory paths. Used in conjunction with `path_provider`.

### [Path Provider](https://pub.dev/packages/path_provider)
Provides a platform-agnostic way to find commonly used locations on the filesystem.

### [Screenshot](https://pub.dev/packages/screenshot)
A Flutter package for capturing screenshots of widgets. Potential use for sharing quotes.

### [Animated Text Kit](https://pub.dev/packages/animated_text_kit)
A collection of Flutter widgets for animated text. Enhances the visual appeal of text elements.

### [HTTP Package](https://pub.dev/packages/http)
Facilitates communication with external APIs. Could be used for fetching quotes or other data.

### [Logger](https://pub.dev/packages/logger)
A powerful logging package for detailed debugging and error tracking.

### [Awesome Dialog](https://pub.dev/packages/awesome_dialog)
A Flutter package for customizable and flexible dialogs. Could be used for displaying messages or alerts.

### [Page Transition](https://pub.dev/packages/page_transition)
Beautiful page transition animations for Flutter apps. Enhances the user experience when navigating between screens.

### [Palette Generator](https://pub.dev/packages/palette_generator)
A Flutter package to generate a color palette from an image. Could be useful for dynamic theming based on background images.

### [Firebase Core](https://pub.dev/packages/firebase_core)
Flutter plugin for Firebase Core, enabling Firebase services in the app.

### [Firebase Auth](https://pub.dev/packages/firebase_auth)
Authentication services provided by Firebase. Allows users to sign in with Google and contribute quotes.

### [Cloud Firestore](https://pub.dev/packages/cloud_firestore)
A NoSQL document database for storing and syncing data in real-time. Used for storing user data and quotes.

### [Firebase Storage](https://pub.dev/packages/firebase_storage)
Provides support for uploading and downloading files to/from Firebase Cloud Storage.

### [Flutter Local Notifications](https://pub.dev/packages/flutter_local_notifications)
A package for displaying local notifications in the app.

### [FluentUI System Icons](https://pub.dev/packages/fluentui_system_icons)
Icons from the Fluent System for use in the app.

### [Google Mobile Ads](https://pub.dev/packages/google_mobile_ads)
A package for integrating Google Mobile Ads, supporting app monetization.

### [Google Sign In](https://pub.dev/packages/google_sign_in)
Google Sign-In integration for user authentication.

### [Carousel Slider](https://pub.dev/packages/carousel_slider)
A carousel slider widget for Flutter.

### [Share Extend](https://pub.dev/packages/share_extend)
A Flutter plugin for sharing content with other applications.

### [Flutter TTS](https://pub.dev/packages/flutter_tts)
A Flutter plugin for text-to-speech.

### [Fluttertoast](https://pub.dev/packages/fluttertoast)
A Flutter package for displaying toast messages.

### [Flutter Launcher Icons](https://pub.dev/packages/flutter_launcher_icons)
A package for updating Flutter launcher icons.



## Getting Started

1. **Clone the repository:**
    ```bash
    git clone https://github.com/tushal013/quetter
    cd your-flutter-app
    ```

2. **Install dependencies:**
    ```bash
    flutter pub get
    ```

3. **Run the app:**
    ```bash
    flutter run
    ```

## Firebase Setup

1. Create a Firebase project on [Firebase Console](https://console.firebase.google.com/).
2. Add your Android and iOS app to the project.
3. Copy the Firebase configuration files into your app.
4. Enable Firebase Authentication, Firestore, and Cloud Firestore.

## Google AdMob Setup

1. Create an AdMob account on [Google AdMob](https://admob.google.com/).
2. Register your app and get AdMob Ad Unit IDs.
3. Implement AdMob IDs in the `ad_helper.dart` file.

## Contributing

Contributions are welcome! Feel free to open issues, suggest improvements, or submit pull requests following our guidelines.

## License

Quetter is licensed under the MIT License, promoting an open and collaborative development environment.
mix i talso
