// METHODS - Book and Library Examples

// Book class with different types of methods
class Book {
  String title;
  String author;
  int pages;
  bool isAvailable;
  double price;

  Book(this.title, this.author, this.pages, this.price) : isAvailable = true;

  // 1. Simple method
  void displayInfo() {
    print('Title: $title');
    print('Author: $author');
    print('Pages: $pages');
    print('Price: \$${price.toStringAsFixed(2)}');
    print('Available: ${isAvailable ? "Yes" : "No"}');
  }

  // 2. Method that returns a value
  bool borrowBook() {
    if (isAvailable) {
      isAvailable = false;
      print('Book "$title" has been borrowed.');
      return true;
    } else {
      print('Book "$title" is not available.');
      return false;
    }
  }

  // 3. Void method (no return)
  void returnBook() {
    isAvailable = true;
    print('Book "$title" has been returned.');
  }

  // 4. Method with parameters
  void updatePrice(double newPrice) {
    price = newPrice;
    print('Price updated to \$${price.toStringAsFixed(2)}');
  }

  // 5. Method with optional parameters
  void displayShortInfo([bool showPrice = false]) {
    print('$title by $author');
    if (showPrice) {
      print('Price: \$${price.toStringAsFixed(2)}');
    }
  }

  // 6. Getter method
  String get bookInfo => '$title by $author';

  // 7. Setter method
  set bookTitle(String newTitle) {
    title = newTitle;
    print('Title changed to: $newTitle');
  }
}

// Library class with various methods
class Library {
  String name;
  List<Book> books;

  Library(this.name) : books = [];

  // 8. Method that adds objects to list
  void addBook(Book book) {
    books.add(book);
    print('Book "${book.title}" added to library.');
  }

  // 9. Method that searches and returns object
  Book? findBook(String title) {
    for (Book book in books) {
      if (book.title.toLowerCase() == title.toLowerCase()) {
        return book;
      }
    }
    return null;
  }

  // 10. Method with named parameters
  void displayBooks({bool availableOnly = false, bool showPrices = false}) {
    print('\n=== Books in $name Library ===');
    
    for (Book book in books) {
      if (availableOnly && !book.isAvailable) {
        continue; // Skip unavailable books
      }
      
      book.displayShortInfo(showPrices);
      print('Available: ${book.isAvailable ? "Yes" : "No"}');
      print('---');
    }
  }

  // 11. Static method
  static Library createNewLibrary(String libraryName) {
    print('Creating new library: $libraryName');
    return Library(libraryName);
  }

  // 12. Method that returns count
  int getTotalBooks() {
    return books.length;
  }

  int getAvailableBooks() {
    int count = 0;
    for (Book book in books) {
      if (book.isAvailable) {
        count++;
      }
    }
    return count;
  }
}

// Author class with simple methods
class Author {
  String name;
  String country;

  Author(this.name, this.country);

  // Simple method
  void introduce() {
    print('Hello, I am $name from $country');
  }

  // Method with return value
  String getAuthorInfo() {
    return '$name ($country)';
  }
}

void main() {
  print('=== BOOK LIBRARY METHODS ===\n');

  // 1. Creating objects and using simple methods
  print('1. SIMPLE METHODS:');
  Book book1 = Book('Harry Potter', 'J.K. Rowling', 223, 12.99);
  book1.displayInfo();

  // 2. Methods with return values
  print('\n2. METHODS WITH RETURN VALUES:');
  bool borrowed = book1.borrowBook();
  print('Borrowing successful: $borrowed');

  // 3. Void methods
  print('\n3. VOID METHODS:');
  book1.returnBook();

  // 4. Methods with parameters
  print('\n4. METHODS WITH PARAMETERS:');
  book1.updatePrice(15.99);

  // 5. Methods with optional parameters
  print('\n5. OPTIONAL PARAMETERS:');
  book1.displayShortInfo(); // Without price
  book1.displayShortInfo(true); // With price

  // 6. Getter methods
  print('\n6. GETTER METHODS:');
  print('Book info: ${book1.bookInfo}');

  // 7. Setter methods
  print('\n7. SETTER METHODS:');
  book1.bookTitle = 'Harry Potter and the Philosopher\'s Stone';

  // 8. Library methods
  print('\n8. LIBRARY METHODS:');
  Library cityLibrary = Library('City Central');
  
  Book book2 = Book('1984', 'George Orwell', 328, 13.99);
  Book book3 = Book('The Hobbit', 'J.R.R. Tolkien', 310, 14.99);

  cityLibrary.addBook(book1);
  cityLibrary.addBook(book2);
  cityLibrary.addBook(book3);

  // 9. Search methods
  print('\n9. SEARCH METHODS:');
  Book? found = cityLibrary.findBook('1984');
  if (found != null) {
    print('Found book: ${found.bookInfo}');
  } else {
    print('Book not found');
  }

  // 10. Methods with named parameters
  print('\n10. NAMED PARAMETERS:');
  cityLibrary.displayBooks(availableOnly: false, showPrices: true);

  // 11. Static methods
  print('\n11. STATIC METHODS:');
  Library branchLibrary = Library.createNewLibrary('Branch Library');

  // 12. Count methods
  print('\n12. COUNT METHODS:');
  print('Total books: ${cityLibrary.getTotalBooks()}');
  print('Available books: ${cityLibrary.getAvailableBooks()}');

  // 13. Author methods
  print('\n13. AUTHOR METHODS:');
  Author author = Author('J.K. Rowling', 'United Kingdom');
  author.introduce();
  print('Author info: ${author.getAuthorInfo()}');
}