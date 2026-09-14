
class Book {
  String title;
  String author;
  int pages;
  bool isAvailable;

  
  Book(this.title, this.author, this.pages) : isAvailable = true;

  
  Book.borrowed(this.title, this.author, this.pages) : isAvailable = false;


  void displayInfo() {
    print('Title: $title');
    print('Author: $author');
    print('Pages: $pages');
    print('Available: ${isAvailable ? "Yes" : "No"}');
    print('-------------------');
  }

  bool borrowBook() {
    if (isAvailable) {
      isAvailable = false;
      print('Book "$title" has been borrowed successfully!');
      return true;
    } else {
      print('Sorry, book "$title" is not available.');
      return false;
    }
  }

  void returnBook() {
    if (!isAvailable) {
      isAvailable = true;
      print('Book "$title" has been returned successfully!');
    } else {
      print('Book "$title" was not borrowed.');
    }
  }
}


class Library {
  List<Book> books = [];
  String libraryName;

  // Constructor
  Library(this.libraryName);

  // Methods
  void addBook(Book book) {
    books.add(book);
    print('Book "${book.title}" added to $libraryName library.');
  }

  void displayAllBooks() {
    print('\n=== $libraryName Library Books ===');
    if (books.isEmpty) {
      print('No books in the library.');
    } else {
      for (int i = 0; i < books.length; i++) {
        print('Book ${i + 1}:');
        books[i].displayInfo();
      }
    }
  }

  void displayAvailableBooks() {
    print('\n=== Available Books in $libraryName ===');
    List<Book> availableBooks = books.where((book) => book.isAvailable).toList();
    
    if (availableBooks.isEmpty) {
      print('No books are currently available.');
    } else {
      for (int i = 0; i < availableBooks.length; i++) {
        print('Available Book ${i + 1}:');
        availableBooks[i].displayInfo();
      }
    }
  }

  Book? findBookByTitle(String title) {
    for (Book book in books) {
      if (book.title.toLowerCase() == title.toLowerCase()) {
        return book;
      }
    }
    return null;
  }

  int getTotalBooks() {
    return books.length;
  }

  int getAvailableCount() {
    return books.where((book) => book.isAvailable).length;
  }
}

// Example usage and main function
void main() {
  // Creating objects using constructor
  Book book1 = Book('The Dart Programming Language', 'Gilad Bracha', 400);
  Book book2 = Book('Flutter Complete Reference', 'Alberto Miola', 850);
  Book book3 = Book('Clean Code', 'Robert Martin', 464);
  
  // Creating a book that's already borrowed using named constructor
  Book book4 = Book.borrowed('Design Patterns', 'Gang of Four', 395);

  // Creating library object
  Library myLibrary = Library('City Central');

  // Adding books to library
  myLibrary.addBook(book1);
  myLibrary.addBook(book2);
  myLibrary.addBook(book3);
  myLibrary.addBook(book4);

  // Display all books
  myLibrary.displayAllBooks();

  // Display available books
  myLibrary.displayAvailableBooks();

  // Borrowing a book
  print('\n=== Borrowing Books ===');
  book1.borrowBook();
  book2.borrowBook();

  // Try to borrow an already borrowed book
  book4.borrowBook();

  // Display available books after borrowing
  myLibrary.displayAvailableBooks();

  // Return a book
  print('\n=== Returning Books ===');
  book1.returnBook();

  // Search for a book
  print('\n=== Searching for Books ===');
  Book? foundBook = myLibrary.findBookByTitle('Clean Code');
  if (foundBook != null) {
    print('Found book:');
    foundBook.displayInfo();
  } else {
    print('Book not found.');
  }

  // Library statistics
  print('\n=== Library Statistics ===');
  print('Total books: ${myLibrary.getTotalBooks()}');
  print('Available books: ${myLibrary.getAvailableCount()}');
  print('Borrowed books: ${myLibrary.getTotalBooks() - myLibrary.getAvailableCount()}');
}