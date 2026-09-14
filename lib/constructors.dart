// CONSTRUCTORS - Book and Library Examples

// 1. Basic Constructor
class Book {
  String title;
  String author;

  // Basic constructor
  Book(this.title, this.author);

  void displayInfo() {
    print('Title: $title');
    print('Author: $author');
  }
}

// 2. Constructor with more parameters
class BookDetails {
  String title;
  String author;
  int pages;
  double price;

  // Constructor with multiple parameters
  BookDetails(this.title, this.author, this.pages, this.price);

  void showDetails() {
    print('Book: $title by $author');
    print('Pages: $pages, Price: \$${price.toStringAsFixed(2)}');
  }
}

// 3. Named Constructor
class Library {
  String name;
  String location;
  int totalBooks;

  // Default constructor
  Library(this.name, this.location, this.totalBooks);

  // Named constructor for new library
  Library.newLibrary(this.name, this.location) : totalBooks = 0;

  // Named constructor for big library
  Library.bigLibrary(this.name, this.location) : totalBooks = 10000;

  void displayLibraryInfo() {
    print('Library: $name');
    print('Location: $location');
    print('Total Books: $totalBooks');
  }
}

// 4. Constructor with optional parameters
class Author {
  String name;
  String nationality;
  int? birthYear;

  // Constructor with optional parameter
  Author(this.name, this.nationality, [this.birthYear]);

  void showAuthorInfo() {
    print('Author: $name from $nationality');
    if (birthYear != null) {
      print('Born: $birthYear');
    }
  }
}

void main() {
  print('=== BOOK LIBRARY CONSTRUCTORS ===\n');

  // 1. Basic Constructor
  print('1. BASIC CONSTRUCTOR:');
  Book book1 = Book('Harry Potter', 'J.K. Rowling');
  book1.displayInfo();

  // 2. Constructor with more parameters
  print('\n2. DETAILED CONSTRUCTOR:');
  BookDetails book2 = BookDetails('1984', 'George Orwell', 328, 12.99);
  book2.showDetails();

  // 3. Named Constructors
  print('\n3. NAMED CONSTRUCTORS:');
  Library lib1 = Library('City Library', 'Downtown', 5000);
  Library lib2 = Library.newLibrary('New Branch', 'Suburbs');
  Library lib3 = Library.bigLibrary('Central Library', 'Main Street');

  lib1.displayLibraryInfo();
  print('---');
  lib2.displayLibraryInfo();
  print('---');
  lib3.displayLibraryInfo();

  // 4. Optional parameters
  print('\n4. OPTIONAL PARAMETERS:');
  Author author1 = Author('Shakespeare', 'English');
  Author author2 = Author('Mark Twain', 'American', 1835);

  author1.showAuthorInfo();
  print('---');
  author2.showAuthorInfo();
}