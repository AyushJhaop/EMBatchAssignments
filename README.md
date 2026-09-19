# Flutter Assignments Collection

A comprehensive Flutter application containing multiple assignments demonstrating various Flutter concepts including UI components, navigation, API integration, state management, and data persistence.

## 📱 Assignment Overview

### 1. **Product Listing Assignment** (`assignment.dart`)
**Requirement**: Build a dynamic product listing using ListView.builder with a data model class; implement search/filter functionality using setState

**Features Implemented:**
- ✅ Dynamic ListView.builder for efficient product rendering
- ✅ Product data model class with comprehensive properties
- ✅ Real-time search functionality with setState
- ✅ Category-based filtering (Electronics, Laptops, Shoes, All)
- ✅ Product cards with images, descriptions, prices, and category tags
- ✅ Empty state handling and results counter
- ✅ Product detail popup on tap
- ✅ Responsive Material Design UI

### 2. **Navigation & Form Assignment** (`navigation_assignment.dart`)
**Requirement**: Build a 3-screen app (Home, Form, Detail) using named routes; implement a registration form with validation (email, password, required fields)

**Features Implemented:**
- ✅ 3-screen architecture with named routes (`/`, `/form`, `/detail`)
- ✅ Comprehensive registration form with multiple field types
- ✅ Advanced form validation:
  - Email format validation with regex
  - Password strength validation (8+ chars, uppercase, lowercase, number)
  - Phone number validation
  - Required field validation
  - Confirm password matching
- ✅ User data model and navigation with data passing
- ✅ Success screen with user details display
- ✅ Professional UI with gradients and Material Design

### 3. **REST API Assignment** (`api_assignment.dart`)
**Requirement**: Fetch data from a public REST API (e.g., JSONPlaceholder), display it with FutureBuilder, and cache the last result using SharedPreferences

**Features Implemented:**
- ✅ JSONPlaceholder API integration (Posts & Users endpoints)
- ✅ FutureBuilder implementation for async data handling
- ✅ SharedPreferences caching with intelligent cache strategy:
  - 5-minute cache expiry
  - Offline fallback support
  - Cache management and clearing
- ✅ Tabbed interface for Posts and Users
- ✅ Error handling with retry functionality
- ✅ Pull-to-refresh implementation
- ✅ Loading states and empty state handling
- ✅ Detailed post and user view with expansion tiles

### 4. **Todo List Assignment** (`todo_assignment.dart`)
**Requirement**: Build a fully functional Todo list using StatefulWidget and setState; support add, delete, and mark-complete operations

**Features Implemented:**
- ✅ Complete todo CRUD operations using setState
- ✅ Add new todos with title and description
- ✅ Mark todos as complete/incomplete
- ✅ Delete todos with confirmation dialog
- ✅ Edit existing todos
- ✅ Filter todos by status (All, Active, Completed)
- ✅ Statistics dashboard showing total, active, and completed counts
- ✅ Todo model with timestamps and completion tracking
- ✅ Professional UI with cards, animations, and Material Design
- ✅ Empty states for different filter types

## 🎯 Technical Implementation

### **State Management**
- Proper use of `StatefulWidget` and `setState` for reactive UI updates
- Local state management with controllers and form validation
- Efficient list filtering and data manipulation

### **API Integration**
- HTTP requests with error handling
- Async/await pattern with FutureBuilder
- Data caching with SharedPreferences
- Offline support and cache invalidation

### **Navigation**
- Named routes implementation
- Data passing between screens
- Navigation stack management
- Route-based architecture

### **Form Validation**
- Multiple validation types (email, password, phone, required)
- Real-time validation feedback
- Custom validators with regex patterns
- Form state management

### **UI/UX Design**
- Material Design 3 components
- Responsive layouts for different screen sizes
- Loading states and error handling
- Empty states with helpful messages
- Gradient backgrounds and professional styling

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.13.0 or higher)
- Dart SDK
- Android Studio / VS Code
- Android/iOS device or emulator

### Installation
```bash
# Clone the repository
git clone https://github.com/AyushJhaop/EMBatchAssignments.git

# Navigate to project directory
cd EMBatchAssignments

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  http: ^1.1.0                    # For REST API calls
  shared_preferences: ^2.2.2      # For data caching
```

## 📁 Project Structure
```
lib/
├── main.dart                    # Assignment launcher/selector
├── assignment.dart              # Product listing with search/filter
├── navigation_assignment.dart   # 3-screen app with navigation & forms
├── api_assignment.dart          # REST API with FutureBuilder & caching
├── todo_assignment.dart         # Todo list with full CRUD operations
├── constructors.dart           # Constructor examples (bonus content)
├── objects.dart                # Object examples (bonus content)
├── methods.dart                # Method examples (bonus content)
└── [other supporting files...]
```

## 🎨 Features Highlight

### **Assignment Launcher**
The main app provides a beautiful launcher interface to navigate between all assignments:
- Visual cards for each assignment
- Clear descriptions and icons
- Easy navigation to individual assignments

### **Product Listing**
- 8+ sample products across multiple categories
- Real-time search as you type
- Category dropdown filtering
- Product detail modals
- Professional product cards with images

### **Navigation & Forms**
- Multi-step user registration flow
- Comprehensive form validation
- Success page with user data display
- Named route navigation
- Professional form design

### **API Integration**
- Live data from JSONPlaceholder API
- Intelligent caching system
- Offline support
- Tabbed interface for different data types
- Pull-to-refresh functionality

### **Todo Management**
- Complete task lifecycle management
- Visual statistics dashboard
- Multiple view filters
- Task editing and deletion
- Professional task cards with timestamps

## 🔧 Development Notes

### **Performance Optimizations**
- ListView.builder for efficient list rendering
- Proper widget disposal to prevent memory leaks
- Optimized image loading with error handling
- Efficient state updates with minimal rebuilds

### **Code Quality**
- Clean architecture with separate concerns
- Reusable widgets and components
- Comprehensive error handling
- Consistent naming conventions
- Detailed code comments

### **Best Practices**
- Proper Flutter widget lifecycle management
- Material Design guidelines adherence
- Accessibility considerations
- Responsive design principles
- Security considerations for form inputs

## 🚦 Running Individual Assignments

Each assignment can be run independently by modifying the `main.dart` file to directly launch the specific assignment:

```dart
// For Product Listing
home: const ProductListingPage(),

// For Navigation Assignment  
home: const NavigationApp(),

// For API Assignment
home: const ApiApp(),

// For Todo Assignment
home: const TodoApp(),
```

## 📊 Assignment Completion Status

| Assignment | Status | Features | Bonus |
|------------|--------|----------|-------|
| Product Listing | ✅ Complete | ListView.builder, Search, Filter, setState | Professional UI, Product details |
| Navigation & Forms | ✅ Complete | Named routes, Form validation, 3 screens | Advanced validation, Success screen |
| REST API & Caching | ✅ Complete | FutureBuilder, SharedPreferences, API calls | Offline support, Tabbed UI |
| Todo List | ✅ Complete | CRUD operations, setState, Filtering | Statistics, Edit functionality |

## 🏆 Additional Features

- **Assignment Launcher**: Beautiful home screen to select assignments
- **Comprehensive Documentation**: Detailed README and code comments
- **Professional UI**: Material Design 3 with gradients and animations
- **Error Handling**: Comprehensive error states and user feedback
- **Responsive Design**: Works on different screen sizes
- **Code Examples**: Additional constructor, object, and method examples

---

**Repository**: https://github.com/AyushJhaop/EMBatchAssignments.git  
**Branch**: main  
**Flutter Version**: 3.13.0+  
**Last Updated**: August 2026