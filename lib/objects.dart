// OBJECTS - Book and Library Examples

// Simple Book class
class Book {
  String title;
  String author;
  int pages;
  bool isAvailable;

  Book(this.title, this.author, this.pages) : isAvailable = true;

  void borrowBook() {
    if (isAvailable) {
      isAvailable = false;
      print('Book "$title" has been borrowed.');
    } else {
      print('Book "$title" is not available.');
    }
  }

  void returnBook() {
    isAvailable = true;
    print('Book "$title" has been returned.');
  }

  void displayBook() {
    print('Title: $title');
    print('Author: $author');
    print('Pages: $pages');
    print('Available: ${isAvailable ? "Yes" : "No"}');
  }
}

// Library class that manages books
class Library {
  String libraryName;
  List<Book> books;

  Library(this.libraryName) : books = [];

  void addBook(Book book) {
    books.add(book);
    print('Book "${book.title}" added to $libraryName.');
  }

  void displayAllBooks() {
    print('\n=== Books in $libraryName ===');
    if (books.isEmpty) {
      print('No books available.');
    } else {
      for (int i = 0; i < books.length; i++) {
        print('\nBook ${i + 1}:');
        books[i].displayBook();
      }
    }
  }

  void displayAvailableBooks() {
    print('\n=== Available Books ===');
    bool hasAvailable = false;
    for (Book book in books) {
      if (book.isAvailable) {
        book.displayBook();
        print('---');
        hasAvailable = true;
      }
    }
    if (!hasAvailable) {
      print('No books are currently available.');
    }
  }

  int getTotalBooks() {
    return books.length;
  }
}

// Author class
class Author {
  String name;
  String country;
  List<Book> booksWritten;

  Author(this.name, this.country) : booksWritten = [];

  void addBookWritten(Book book) {
    booksWritten.add(book);
  }

  void displayAuthorInfo() {
    print('Author: $name from $country');
    print('Books written: ${booksWritten.length}');
  }
}

void main() {
  print('=== BOOK LIBRARY OBJECTS ===\n');

  // 1. Creating simple objects
  print('1. CREATING BOOK OBJECTS:');
  Book book1 = Book('Harry Potter', 'J.K. Rowling', 223);
  Book book2 = Book('1984', 'George Orwell', 328);
  Book book3 = Book('The Hobbit', 'J.R.R. Tolkien', 310);

  book1.displayBook();
  print('---');
  book2.displayBook();

  // 2. Creating library object
  print('\n2. CREATING LIBRARY OBJECT:');
  Library cityLibrary = Library('City Central Library');

  // 3. Adding books to library
  print('\n3. ADDING BOOKS TO LIBRARY:');
  cityLibrary.addBook(book1);
  cityLibrary.addBook(book2);
  cityLibrary.addBook(book3);

  // 4. Display all books
  cityLibrary.displayAllBooks();

  // 5. Borrowing and returning books
  print('\n5. BORROWING BOOKS:');
  book1.borrowBook();
  book2.borrowBook();

  // 6. Display available books
  cityLibrary.displayAvailableBooks();

  // 7. Return a book
  print('\n7. RETURNING BOOK:');
  book1.returnBook();

  // 8. Display available books again
  cityLibrary.displayAvailableBooks();

  // 9. Author objects
  print('\n9. AUTHOR OBJECTS:');
  Author author1 = Author('J.K. Rowling', 'UK');
  Author author2 = Author('George Orwell', 'UK');

  author1.addBookWritten(book1);
  author2.addBookWritten(book2);

  author1.displayAuthorInfo();
  author2.displayAuthorInfo();

  // 10. Library statistics
  print('\n10. LIBRARY STATISTICS:');
  print('Total books in library: ${cityLibrary.getTotalBooks()}');
}