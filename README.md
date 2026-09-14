# Product Listing Flutter App

A Flutter application demonstrating dynamic product listing with ListView.builder and search/filter functionality.

## Features

### ✅ Requirements Implemented
- **Dynamic Product Listing**: Uses `ListView.builder` for efficient rendering of product list
- **Data Model Class**: `Product` class with id, name, category, price, imageUrl, description
- **Search Functionality**: Real-time search with `setState` for reactive UI updates
- **Filter Functionality**: Category-based filtering (All, Electronics, Laptops, Shoes)

### 📱 User Interface
- **Search Bar**: Real-time product search with clear button
- **Category Filter**: Dropdown for filtering by product category
- **Product Cards**: Clean Material Design cards showing:
  - Product image (with loading and error states)
  - Product name and description
  - Category tag with colored background
  - Price with green highlighting
- **Product Details**: Tap any product to view detailed information in popup
- **Empty State**: Helpful message when no products match search/filter criteria
- **Results Counter**: Shows number of products found

### 🏗️ Technical Implementation
- **State Management**: Uses `setState` for reactive UI updates
- **Data Filtering**: Combines search text and category filtering
- **Error Handling**: Graceful image loading with fallbacks
- **Responsive Design**: Works on different screen sizes
- **Material Design**: Follows Flutter's Material Design principles

## Sample Data
The app includes 8+ sample products across different categories:
- **Electronics**: iPhone 15 Pro, Samsung Galaxy S24, Sony WH-1000XM5, Apple Watch Series 9
- **Laptops**: MacBook Air M3, Dell XPS 13
- **Shoes**: Nike Air Max, Adidas Ultraboost

## Key Files
- `lib/assignment.dart` - Main application with product listing implementation
- `lib/main.dart` - App entry point configured to show the assignment

## How to Run
1. Ensure Flutter is installed on your system
2. Clone this repository
3. Navigate to the project directory
4. Run `flutter pub get` to install dependencies
5. Run `flutter run` to start the app

## State Management Flow
1. **Initial State**: All products displayed
2. **Search Input**: Text changes trigger `_onSearchChanged()`
3. **Filter Products**: `_filterProducts()` method applies search and category filters
4. **Update UI**: `setState()` triggers rebuild with filtered results
5. **Dynamic Updates**: UI reflects changes in real-time

## Code Structure
- **Product Model**: Clean data class with all required properties
- **State Variables**: `filteredProducts`, `selectedCategory`, `searchController`
- **Filter Logic**: Combines text search and category filtering
- **UI Components**: Modular `ProductCard` widget for reusability
- **Error Handling**: Network image loading with fallback states

This implementation demonstrates best practices for Flutter development including proper state management, clean code architecture, and responsive UI design.