# ClassPlan App

A Flutter-based class management application for teachers. Allows managing school classes, students, grades, and calendar events — all stored locally on-device using the Isar embedded database.

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter (Dart) |
| Local DB | [Isar](https://pub.isar-community.dev/) v3.1.8 |
| State Management | [Provider](https://pub.dev/packages/provider) v6.1 |
| Calendar UI | [table_calendar](https://pub.dev/packages/table_calendar) v3.0.9 |
| Localizations | `flutter_localizations` (Polish `pl_PL`) |

---

## File Structure

```
lib/
├── main.dart                   # Entry point — app bootstrap, Provider setup
├── models/                     # Isar data models (schema definitions)
│   ├── class.dart
│   ├── event.dart
│   ├── grade.dart
│   └── student.dart
├── logic/                      # Business logic layer
│   ├── isar_service.dart       # Singleton — Isar DB initializer
│   ├── db/                     # ChangeNotifier repositories (one per model)
│   │   ├── class_database.dart
│   │   ├── event_database.dart
│   │   ├── grade_database.dart
│   │   └── student_database.dart
│   └── methods/                # Stateless utility functions
│       └── gradeTypeConversion.dart
├── pages/                      # Full-screen page widgets
│   ├── login_page.dart
│   ├── main_page.dart
│   ├── classes_page.dart
│   ├── class_details_page.dart
│   ├── student_details_page.dart
│   ├── settings_page.dart
│   └── events_subpages/        # Events feature sub-navigation
│       ├── events_main_page.dart
│       ├── events_page.dart
│       ├── event_list_page.dart
│       └── event_create_page.dart
├── widgets/                    # Reusable UI components
│   ├── drawer.dart
│   ├── event_calendar.dart
│   ├── event_grid_tile.dart
│   ├── login_widget.dart
│   ├── studentDetailsCard.dart
│   ├── student_grade_tile.dart
│   ├── alerts/                 # Modal dialogs
│   │   ├── classDetailsDialog.dart
│   │   ├── createEvent.dart
│   │   ├── createGrade.dart
│   │   └── gradeDetails.dart
│   └── appBars/                # Custom AppBar widgets
│       ├── appBar.dart
│       ├── class_details_page_appbar.dart
│       └── student_details_page_appbar.dart
└── themes/
    └── app_theme.dart          # Global theme + text style helpers
```

---

## Major Components

### `main.dart` — App Bootstrap
- Initializes `IsarService` before `runApp`.
- Registers all four `ChangeNotifier` database providers via `MultiProvider`.
- Sets locale to `pl_PL` and applies `lightMode` theme.

---

### `models/` — Data Layer

Each model is an **Isar `@collection`** class. Isar generates the corresponding `*.g.dart` schema files at build time.

| Class | Key Fields | Notes |
|---|---|---|
| `ClassObj` | `id`, `name`, `careTeacher` | Represents a school class |
| `Student` | `studentId`, `internalId`, `classIds[]`, `name`, `lastName`, `phoneNumber`, `parentPhoneNumber`, `points[]` | A student can belong to multiple classes via `classIds` |
| `Grade` | `gradeId`, `studentId`, `title`, `type (GradeType)`, `grade`, `gradeAdd`, `wasRecorded` | Linked to a student by `studentId` |
| `Event` | `id`, `title`, `description`, `date`, `reminder` | Calendar event with a reminder timestamp |

`GradeType` is an enum: `test | quiz | activity | lesson | other`

---

### `logic/` — Business Logic Layer

#### `IsarService` (Singleton)
- Opens the Isar database with all four schemas on first call.
- Subsequent calls return the existing instance via `Isar.getInstance()`.
- Used by all four database classes.

#### `*Database` classes (ChangeNotifier Repositories)
Each database class exposes full **CRUD** operations for its model and calls `notifyListeners()` to trigger UI rebuilds.

| Class | Responsibilities |
|---|---|
| `ClassDatabase` | Add / read / update / delete classes. Alphabetical sort (A→Z, Z→A). Fetch single class by ID. Reset collection. |
| `StudentDatabase` | Add / read / update / delete students filtered by `classId`. Auto-increments `internalId` per class. Alphabetical sort by first or last name. Cascades class removal from `classIds` on class deletion. Includes `checkSpelling()` — strips non-letter characters, capitalizes first letter. |
| `GradeDatabase` | Add / read / update / delete grades per student. Sort by title or by `GradeType` priority. Cascades deletion of all grades when a student is deleted. |
| `EventDatabase` | Add / read / update / delete events. Supports fetch-all and fetch-by-date queries. |

#### `methods/gradeTypeConversion.dart`
- Stateless utility with two functions:
  - `gradeTypeToString(GradeType)` → single-letter abbreviation (`T`, `K`, `A`, `P`, `I`).
  - `stringToGradeType(String)` → reverse mapping back to `GradeType` enum.

---

### `pages/` — Screens

| Page | Description |
|---|---|
| `LoginPage` | Entry screen shown on launch. Wraps `LoginWidget`. |
| `MainPage` | Dashboard grid linking to major sections (currently: Classes). Uses `UniversalAppBar` and `UniversalDrawer`. |
| `ClassesPage` | Scrollable list of all classes fetched from `ClassDatabase`. Inline "add class" FAB dialog. Supports sort via popup menu (default / A–Z / Z–A). Navigates to `ClassDetailsPage` on tap. |
| `ClassDetailsPage` | Details of a single class; lists enrolled students. |
| `StudentDetailsPage` | Details of a single student including grade list. |
| `SettingsPage` | App settings screen. |
| `events_subpages/` | Multi-level events feature: main hub → calendar view → day list → create/edit form. |

---

### `widgets/` — Reusable UI

| Widget | Description |
|---|---|
| `UniversalDrawer` | Side navigation drawer, used across main pages. |
| `UniversalAppBar` | Shared app bar with consistent styling. |
| `class_details_page_appbar` / `student_details_page_appbar` | Context-specific AppBars with action buttons (edit, delete, etc.). |
| `EventCalendar` | Calendar widget built on `table_calendar`, shows event markers per day. |
| `EventGridTile` | Tile card for displaying a single event summary. |
| `LoginWidget` | Login form UI. |
| `StudentDetailsCard` | Full student info card (name, contact, points). |
| `StudentGradeTile` | Tile showing a single grade entry for a student. |
| `alerts/classDetailsDialog` | Dialog for editing class details (name, care teacher). |
| `alerts/createEvent` | Dialog for creating a new calendar event. |
| `alerts/createGrade` | Dialog for creating a new grade, with type picker. |
| `alerts/gradeDetails` | Dialog showing full grade details with edit/delete actions. |

---

### `themes/app_theme.dart` — Theming

- Exports `lightMode` (`ThemeData`) used in `main.dart`.
- Provides a set of text style helper functions (`primaryTextStyle`, `onPrimaryBoldTextStyle`, `tertiaryBoldContainerTextStyle`, etc.) consumed directly by page and widget files instead of ad-hoc inline styles.

---

## Data Flow Overview

```
UI (Page/Widget)
    │  reads via Consumer<XDatabase> / Provider.of<XDatabase>
    ▼
XDatabase (ChangeNotifier)
    │  calls CRUD methods
    ▼
IsarService (Singleton)
    │  wraps Isar instance
    ▼
Isar (local embedded DB)
    │  persists to app documents directory
    ▼
*.g.dart (auto-generated Isar schema)
```

State changes propagate upward: after any write, the relevant `XDatabase` calls `notifyListeners()`, causing `Consumer` widgets to rebuild.
