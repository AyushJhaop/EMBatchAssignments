// Assignment 1: Dart Basics Script
// Write a Dart console program that uses variables, loops, functions, and OOP (class with inheritance) to model a simple library system.

import 'dart:io';
import 'dart:math';

void main() {
  print('=== DART BASICS LIBRARY SYSTEM ===\n');
  
  // Create library instance
  Library cityLibrary = Library('City Central Library', 'Downtown Ave 123');
  
  // Demonstrate variables and basic operations
  print('📚 Library Information:');
  print('Name: ${cityLibrary.name}');
  print('Address: ${cityLibrary.address}');
  print('Books: ${cityLibrary.getTotalBooks()}');
  print('Members: ${cityLibrary.getTotalMembers()}\n');
  
  // Add different types of books using inheritance
  print('📖 Adding Books to Library:');
  cityLibrary.addBook(PhysicalBook('The Dart Programming Language', 'Gilad Bracha', 400, 'A1'));
  cityLibrary.addBook(EBook('Flutter Complete Guide', 'Andrea Bizzotto', 650, 15.2));
  cityLibrary.addBook(AudioBook('Clean Code', 'Robert Martin', 464, 8.5));
  cityLibrary.addBook(PhysicalBook('Design Patterns', 'Gang of Four', 395, 'B2'));
  
  // Add members
  print('\n👥 Adding Members:');
  cityLibrary.addMember(Student('Alice Johnson', 'alice@email.com', 'S001', 'Computer Science'));
  cityLibrary.addMember(Teacher('Dr. Smith', 'smith@email.com', 'T001', 'Mathematics'));
  cityLibrary.addMember(Student('Bob Wilson', 'bob@email.com', 'S002', 'Physics'));
  
  // Demonstrate loops and functions
  print('\n🔄 Library Operations:');
  cityLibrary.displayAllBooks();
  
  print('\n👨‍🎓 Library Members:');
  cityLibrary.displayAllMembers();
  
  // Demonstrate borrowing system
  print('\n📋 Book Borrowing Operations:');
  cityLibrary.borrowBook('alice@email.com', 'The Dart Programming Language');
  cityLibrary.borrowBook('smith@email.com', 'Clean Code');
  cityLibrary.borrowBook('bob@email.com', 'Flutter Complete Guide');
  
  // Show borrowed books
  print('\n📊 Current Status:');
  cityLibrary.showBorrowedBooks();
  
  // Return books
  print('\n↩️ Returning Books:');
  cityLibrary.returnBook('alice@email.com', 'The Dart Programming Language');
  
  // Final statistics using loops and calculations
  print('\n📈 Library Statistics:');
  cityLibrary.generateStatistics();
  
  // Interactive console demo (commented out for automated testing)
  // runInteractiveLibrary(cityLibrary);
}

// Base class for demonstration of OOP
abstract class LibraryItem {
  String title;
  String author;
  int pages;
  bool isAvailable;
  DateTime? borrowedDate;
  String? borrowedBy;
  
  LibraryItem(this.title, this.author, this.pages) : isAvailable = true;
  
  // Abstract method to be implemented by subclasses
  void displayInfo();
  
  // Common methods
  bool borrow(String memberEmail) {
    if (isAvailable) {
      isAvailable = false;
      borrowedDate = DateTime.now();
      borrowedBy = memberEmail;
      return true;
    }
    return false;
  }
  
  void returnItem() {
    isAvailable = true;
    borrowedDate = null;
    borrowedBy = null;
  }
}

// Inheritance: PhysicalBook extends LibraryItem
class PhysicalBook extends LibraryItem {
  String shelfLocation;
  
  PhysicalBook(String title, String author, int pages, this.shelfLocation) 
      : super(title, author, pages);
  
  @override
  void displayInfo() {
    print('📖 Physical Book: $title by $author');
    print('   Pages: $pages | Shelf: $shelfLocation | Available: ${isAvailable ? "Yes" : "No"}');
  }
}

// Inheritance: EBook extends LibraryItem
class EBook extends LibraryItem {
  double fileSizeMB;
  
  EBook(String title, String author, int pages, this.fileSizeMB) 
      : super(title, author, pages);
  
  @override
  void displayInfo() {
    print('💻 E-Book: $title by $author');
    print('   Pages: $pages | Size: ${fileSizeMB}MB | Available: ${isAvailable ? "Yes" : "No"}');
  }
}

// Inheritance: AudioBook extends LibraryItem
class AudioBook extends LibraryItem {
  double durationHours;
  
  AudioBook(String title, String author, int pages, this.durationHours) 
      : super(title, author, pages);
  
  @override
  void displayInfo() {
    print('🎧 Audio Book: $title by $author');
    print('   Pages: $pages | Duration: ${durationHours}h | Available: ${isAvailable ? "Yes" : "No"}');
  }
}

// Base class for library members
abstract class LibraryMember {
  String name;
  String email;
  String memberId;
  List<String> borrowedBooks;
  DateTime joinDate;
  
  LibraryMember(this.name, this.email, this.memberId) 
      : borrowedBooks = [], joinDate = DateTime.now();
  
  void displayMemberInfo();
  
  int getMaxBooks();
  
  bool canBorrowMore() {
    return borrowedBooks.length < getMaxBooks();
  }
  
  void borrowBook(String bookTitle) {
    if (canBorrowMore()) {
      borrowedBooks.add(bookTitle);
    }
  }
  
  void returnBook(String bookTitle) {
    borrowedBooks.remove(bookTitle);
  }
}

// Inheritance: Student extends LibraryMember
class Student extends LibraryMember {
  String major;
  
  Student(String name, String email, String memberId, this.major) 
      : super(name, email, memberId);
  
  @override
  void displayMemberInfo() {
    print('👨‍🎓 Student: $name ($email)');
    print('   ID: $memberId | Major: $major | Books: ${borrowedBooks.length}/${getMaxBooks()}');
  }
  
  @override
  int getMaxBooks() => 5; // Students can borrow up to 5 books
}

// Inheritance: Teacher extends LibraryMember
class Teacher extends LibraryMember {
  String department;
  
  Teacher(String name, String email, String memberId, this.department) 
      : super(name, email, memberId);
  
  @override
  void displayMemberInfo() {
    print('👨‍🏫 Teacher: $name ($email)');
    print('   ID: $memberId | Department: $department | Books: ${borrowedBooks.length}/${getMaxBooks()}');
  }
  
  @override
  int getMaxBooks() => 10; // Teachers can borrow up to 10 books
}

// Main Library class demonstrating composition and aggregation
class Library {
  String name;
  String address;
  List<LibraryItem> books;
  List<LibraryMember> members;
  Map<String, List<String>> borrowHistory;
  
  Library(this.name, this.address) 
      : books = [], members = [], borrowHistory = {};
  
  // Functions demonstrating various programming concepts
  void addBook(LibraryItem book) {
    books.add(book);
    print('✅ Added: ${book.title}');
  }
  
  void addMember(LibraryMember member) {
    members.add(member);
    print('✅ Added member: ${member.name}');
  }
  
  // Function using loops
  void displayAllBooks() {
    print('Books in $name:');
    if (books.isEmpty) {
      print('  No books available');
      return;
    }
    
    for (int i = 0; i < books.length; i++) {
      print('${i + 1}. ', end: '');
      books[i].displayInfo();
    }
  }
  
  // Function using loops and conditionals
  void displayAllMembers() {
    if (members.isEmpty) {
      print('No members registered');
      return;
    }
    
    int studentCount = 0;
    int teacherCount = 0;
    
    for (var member in members) {
      member.displayMemberInfo();
      
      // Using instanceof/type checking
      if (member is Student) {
        studentCount++;
      } else if (member is Teacher) {
        teacherCount++;
      }
    }
    
    print('\nMember Summary: $studentCount students, $teacherCount teachers');
  }
  
  // Function demonstrating search and boolean logic
  LibraryMember? findMemberByEmail(String email) {
    for (var member in members) {
      if (member.email.toLowerCase() == email.toLowerCase()) {
        return member;
      }
    }
    return null;
  }
  
  // Function demonstrating search with multiple conditions
  LibraryItem? findAvailableBook(String title) {
    for (var book in books) {
      if (book.title.toLowerCase().contains(title.toLowerCase()) && book.isAvailable) {
        return book;
      }
    }
    return null;
  }
  
  // Complex function demonstrating multiple concepts
  bool borrowBook(String memberEmail, String bookTitle) {
    var member = findMemberByEmail(memberEmail);
    if (member == null) {
      print('❌ Member not found: $memberEmail');
      return false;
    }
    
    if (!member.canBorrowMore()) {
      print('❌ ${member.name} has reached borrowing limit (${member.getMaxBooks()} books)');
      return false;
    }
    
    var book = findAvailableBook(bookTitle);
    if (book == null) {
      print('❌ Book not available: $bookTitle');
      return false;
    }
    
    // Perform the borrowing
    if (book.borrow(memberEmail)) {
      member.borrowBook(book.title);
      
      // Update borrow history
      borrowHistory.putIfAbsent(memberEmail, () => []);
      borrowHistory[memberEmail]!.add(book.title);
      
      print('✅ ${member.name} borrowed "${book.title}"');
      return true;
    }
    
    return false;
  }
  
  // Function for returning books
  bool returnBook(String memberEmail, String bookTitle) {
    var member = findMemberByEmail(memberEmail);
    if (member == null) {
      print('❌ Member not found: $memberEmail');
      return false;
    }
    
    // Find the book in member's borrowed list
    if (!member.borrowedBooks.contains(bookTitle)) {
      print('❌ ${member.name} has not borrowed "$bookTitle"');
      return false;
    }
    
    // Find the actual book object
    LibraryItem? book;
    for (var b in books) {
      if (b.title == bookTitle && !b.isAvailable) {
        book = b;
        break;
      }
    }
    
    if (book != null) {
      book.returnItem();
      member.returnBook(bookTitle);
      print('✅ ${member.name} returned "$bookTitle"');
      return true;
    }
    
    return false;
  }
  
  // Function using loops and calculations
  void generateStatistics() {
    int totalBooks = books.length;
    int availableBooks = 0;
    int borrowedBooks = 0;
    
    // Loop to count available books
    for (var book in books) {
      if (book.isAvailable) {
        availableBooks++;
      } else {
        borrowedBooks++;
      }
    }
    
    // Calculate percentages
    double availabilityRate = totalBooks > 0 ? (availableBooks / totalBooks) * 100 : 0;
    
    print('Total Books: $totalBooks');
    print('Available: $availableBooks (${availabilityRate.toStringAsFixed(1)}%)');
    print('Borrowed: $borrowedBooks');
    print('Total Members: ${members.length}');
    
    // Show most active borrowers
    if (borrowHistory.isNotEmpty) {
      print('\n📊 Most Active Borrowers:');
      var sortedBorrowers = borrowHistory.entries.toList();
      sortedBorrowers.sort((a, b) => b.value.length.compareTo(a.value.length));
      
      for (int i = 0; i < min(3, sortedBorrowers.length); i++) {
        var entry = sortedBorrowers[i];
        var member = findMemberByEmail(entry.key);
        print('${i + 1}. ${member?.name ?? 'Unknown'}: ${entry.value.length} books borrowed');
      }
    }
  }
  
  // Function to show currently borrowed books
  void showBorrowedBooks() {
    print('Currently Borrowed Books:');
    bool hasBorrowedBooks = false;
    
    for (var book in books) {
      if (!book.isAvailable) {
        var member = findMemberByEmail(book.borrowedBy!);
        var daysBorrowed = DateTime.now().difference(book.borrowedDate!).inDays;
        print('📚 "${book.title}" - Borrowed by ${member?.name ?? 'Unknown'} ($daysBorrowed days ago)');
        hasBorrowedBooks = true;
      }
    }
    
    if (!hasBorrowedBooks) {
      print('  No books are currently borrowed');
    }
  }
  
  // Getter functions
  int getTotalBooks() => books.length;
  int getTotalMembers() => members.length;
  int getAvailableBooks() => books.where((book) => book.isAvailable).length;
  int getBorrowedBooks() => books.where((book) => !book.isAvailable).length;
}

// Function demonstrating user input and control structures
void runInteractiveLibrary(Library library) {
  print('\n🎯 Interactive Library System');
  print('Commands: add-member, borrow, return, status, quit');
  
  while (true) {
    stdout.write('\nEnter command: ');
    String? input = stdin.readLineSync();
    
    if (input == null || input.toLowerCase() == 'quit') {
      print('Goodbye!');
      break;
    }
    
    var parts = input.split(' ');
    var command = parts[0].toLowerCase();
    
    switch (command) {
      case 'add-member':
        if (parts.length >= 4) {
          String name = parts[1];
          String email = parts[2];
          String type = parts[3];
          String id = 'AUTO${library.getTotalMembers() + 1}';
          
          if (type.toLowerCase() == 'student') {
            library.addMember(Student(name, email, id, 'General'));
          } else if (type.toLowerCase() == 'teacher') {
            library.addMember(Teacher(name, email, id, 'General'));
          } else {
            print('Invalid member type. Use: student or teacher');
          }
        } else {
          print('Usage: add-member <name> <email> <student/teacher>');
        }
        break;
        
      case 'borrow':
        if (parts.length >= 3) {
          String email = parts[1];
          String bookTitle = parts.sublist(2).join(' ');
          library.borrowBook(email, bookTitle);
        } else {
          print('Usage: borrow <email> <book title>');
        }
        break;
        
      case 'return':
        if (parts.length >= 3) {
          String email = parts[1];
          String bookTitle = parts.sublist(2).join(' ');
          library.returnBook(email, bookTitle);
        } else {
          print('Usage: return <email> <book title>');
        }
        break;
        
      case 'status':
        library.generateStatistics();
        library.showBorrowedBooks();
        break;
        
      default:
        print('Unknown command: $command');
        break;
    }
  }
}