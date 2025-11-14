class Book:
    def __init__(self, title, author, ISBN):
        self.__title = title
        self.__author = author
        self.__ISBN = ISBN
        self.__available = True

    @property
    def title(self):
        return self.__title

    @property
    def author(self):
        return self.__author

    @property
    def ISBN(self):
        return self.__ISBN

    @property
    def available(self):
        return self.__available

    @available.setter
    def available(self, status):
        self.__available = status

    def display_info(self):
        print(f"Title: {self.__title}, Author: {self.__author}, ISBN: {self.__ISBN}, Available: {self.__available}")

class Member:
    def __init__(self, name, member_id):
        self.__name = name
        self.__member_id = member_id
        self.__borrowed_books = [] 

    # Getter for name
    @property
    def name(self):
        return self.__name

    # Setter for name 
    @name.setter
    def name(self, new_name):
        self.__name = new_name

    # Getter for member ID
    @property
    def member_id(self):
        return self.__member_id

    # Getter for borrowed books
    @property
    def borrowed_books(self):
        return self.__borrowed_books

    # Borrow a book
    def borrow_book(self, book):
        if book.available:  # check availability
            self.__borrowed_books.append(book)  # add book object to borrowed_books
            book.available = False               # mark book as not available
            print(f"{self.__name} borrowed '{book.title}'.")
        else:
            print(f"Sorry, '{book.title}' is not available.")

    # Return a book
    def return_book(self, book):
        if book in self.__borrowed_books:
            self.__borrowed_books.remove(book)  # remove book from borrowed_books
            book.available = True                # mark book as available
            print(f"{self.__name} returned '{book.title}'.")
        else:
            print(f"{self.__name} did not borrow '{book.title}'.")
class Library:
    def __init__(self):
        self.books = []  # list to store all book objects

    # Add a book
    def add_book(self, book):
        self.books.append(book)
        print(f"Book '{book.title}' added to the library.")
        book.display_info()  # show details of added book

    # Remove a book
    def remove_book(self, book):
        if book in self.books:
            self.books.remove(book)
            print(f"Book '{book.title}' removed from the library.")
        else:
            print("Book not found in the library.")

    # Lend a book
    def lend_book(self, member, book):
        if book in self.books:
            member.borrow_book(book)
        else:
            print("Book not found in the library.")

    # Accept returned book
    def accept_return(self, member, book):
        if book in self.books:
            member.return_book(book)
        else:
            print("Book not found in the library.")

    # Search for a book by title
    def search_book(self, title):
        for book in self.books:
            if book.title.lower() == title.lower():
                print(f"Book found: {book.title} by {book.author}, Available: {book.available}")
                return book
        print("Book not found.")
        return None
    
# Create library
library = Library()

# Create some members
member1 = Member("Loki", "M01")
member2 = Member("Alice", "M02")



while True:
    print("\n--- Library Menu ---")
    print("1. Add Book")
    print("2. Remove Book")
    print("3. Lend Book")
    print("4. Return Book")
    print("5. Search Book")
    print("6. Show All Books")
    print("7. Exit")
    
    choice = input("Enter your choice: ")
    
    if choice == "1":
        title = input("Enter book title: ")
        author = input("Enter author name: ")
        ISBN = input("Enter ISBN: ")
        book = Book(title, author, ISBN)
        library.add_book(book)
        
    elif choice == "2":
        title = input("Enter book title to remove: ")
        book = library.search_book(title)
        if book:
            library.remove_book(book)
        
    elif choice == "3":
        title = input("Enter book title to lend: ")
        book = library.search_book(title)
        if book:
            member_name = input("Enter member name (Loki/Alice): ")
            if member_name.lower() == "loki":
                library.lend_book(member1, book)
            elif member_name.lower() == "alice":
                library.lend_book(member2, book)
            else:
                print("Member not found.")
        
    elif choice == "4":
        title = input("Enter book title to return: ")
        book = library.search_book(title)
        if book:
            member_name = input("Enter member name (Loki/Alice): ")
            if member_name.lower() == "loki":
                library.accept_return(member1, book)
            elif member_name.lower() == "alice":
                library.accept_return(member2, book)
            else:
                print("Member not found.")
        
    elif choice == "5":
        title = input("Enter book title to search: ")
        library.search_book(title)
        
    elif choice == "6":
        print("\nAll books in library:")
        for book in library.books:
            book.display_info()
        
    elif choice == "7":
        print("Exiting...")
        break
    
    else:
        print("Invalid choice. Try again.")
