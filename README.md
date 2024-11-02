# SimpleDo: Task Management App

Developers documentation containing setup processes and rules to work in the project.

<!-- TOC -->

* [CarX](#carx)
    * [Getting Started](#getting-started)
        * [Generate models serialization files using build runner:](#generate-models-serialization-files-using-build-runner-)
        * [Generate Easy localization files:](#generate-easy-localization-files-)
    * [Notice!!](#notice--)
* [Conventions](#conventions)
* [Important notes](#important-notes)
* [Folders structure](#folders-structure)

<!-- TOC -->

## Getting Started

- First we want to make sure that we have generated all the necessary code for translation files,
  models files, and service files

### Generate models serialization files using build runner:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Generate Easy localization files:

```bash
dart run easy_localization:generate --source-dir ./assets/i18n/;dart run easy_localization:generate --source-dir ./assets/i18n -f keys -o locale_keys.g.dart
```

### Run the app in debug mode (The app has two flavors by default: production/dev):

```bash
flutter run --flavor production -t lib/main.dart
```

### Build an apk:

```bash
flutter build apk --flavor production -t lib/main.dart
```

## Notice!!

* If this the first time you run the project make sure you get the `pubspec.yaml` dependency and
  sync the gradle project
* You do this through the following steps:

    1. turn on your vpn
    2. open android studio and run
       ```bash
       flutter pub get
       ```
    3. on your project and go to the file `/android/build.gradle`
    4. you notice that in the top right side there is a button
       said `Open for Editing in Android Studio`
    5. press on that button then select `New Window`
    6. wait until the gradle sync successfully (you can see the progress by open the `build` window
       in the bottom)

  ---

# Conventions

- **icons** : Icons must be in `assets/icons/` folder , also the icon must be in svg format and
  named like `ic_icon_name.svg`.
- **icons usage**: All Icons must defined in `src/themes/app_icons.dart` class like
  ```dart
    abstract class AppIcons {
      // example :
      static String home = 'ic_home.svg'.iconAssetPath;
    }
  ```
- **images** : Like icons, images must be in `assets/images/` folder and named
  like `im_image_name.png`.
- **images usage**: All Images must defined in `src/themes/app_images.dart` class like

```dart
    abstract class AppImages {
    // example :
    static String home = 'im_home.png'.imageAssetPath;
    }
```

- **naming** : Normally, for variables, functions, classes, files and folders we will use flutter
  naming convention.
- **responsive** : See [Flutter ScreenUtil](https://pub.dev/packages/flutter_screenutil).
- **navigation** : See [Go Router](https://pub.dev/packages/go_router).

> note: notice that you can use an extension called `imageAssetPath` on `String` to make it image or
> icon path.
> example:  `image : 'ic_icon_name.svg'.imageAssetPath` == `'assets/images/ic_icon_name.svg'`
---

# Localization and Internationalization :

- you can set new locale and get the current locale for the app by using the class `AppLanguages` as
  a static methods.
- the class also have static getters to check if the locale arabic or english or arabic jordan.
  ex: `AppLanguages.isArabic`
- you can also use the extensions on
  context `context.isArabic`,`context.isEnglish`.

---

# Folder structure

- **app** : This folder is the main folder that divides files according to clean architecture.
- **generated** : This folder is for localization generated files.
- **src** : In this folder, we perform all the common operations and use all the tools that we will
  need within the project.
- **components** : In this folder but all the common ui components that we may use in several
  screens.
- **core** : This folder contains the core processes and base architecture classes.
- **architecture** : This folder contains the base classes we want to inherit from.
- **data_sources** : This folder contains the local (local DB) and remote (backend) files.
- **services** : Here we will write our API services to generate them.
- **di** : ***Dependency Injection*** folder where we inject our services and initialize our app.
- **enums** : a folder that contains the enums we use all over the project.
- **error** : a folder that contains the exceptions and failure files.
- **routing** : a folder contains the files that handel the app routing and navigation.
- **themes** : a folder that contains our theme files and app colors
- **utils** : This folder contains any utility that we may use in the project, such as extensions,
  constants, and any helper files.

---

# Testing
Only few basic simple test cases could be made on time.
- **Auth** : LoginUseCase - AppUserModel Serilization

---