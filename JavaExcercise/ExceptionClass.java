

import java.util.Scanner;

// Base exception for all custom exceptions
class ApplicationException extends Exception {
    public ApplicationException(String message) {
        super(message);
    }

    public ApplicationException(String message, Throwable cause) {
        super(message, cause);
    }
}

// Exception for invalid inputs
class InvalidInputException extends ApplicationException {
    public InvalidInputException(String message) {
        super(message);
    }

    public InvalidInputException(String message, Throwable cause) {
        super(message, cause);
    }
}

// Exception when a resource is not found
class ResourceNotFoundException extends ApplicationException {
    public ResourceNotFoundException(String message) {
        super(message);
    }

    public ResourceNotFoundException(String message, Throwable cause) {
        super(message, cause);
    }
}

// Exception for database issues
class DatabaseConnectionException extends ApplicationException {
    public DatabaseConnectionException(String message) {
        super(message);
    }

    public DatabaseConnectionException(String message, Throwable cause) {
        super(message, cause);
    }
}

// Main class (file should be saved as ExceptionClass.java)
public class ExceptionClass {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.print("Enter input (type 'exit' to quit): ");
        String input = sc.nextLine();

        while (!input.equalsIgnoreCase("exit")) {
            try {
                processUserInput(input);
            } catch (InvalidInputException e) {
                System.err.println("Error: " + e.getMessage());
            } catch (ResourceNotFoundException e) {
                System.err.println("Resource missing: " + e.getMessage());
            } catch (DatabaseConnectionException e) {
                System.err.println("Database issue: " + e.getMessage());
            } catch (ApplicationException e) {
                System.err.println("General application error: " + e.getMessage());
            }

            System.out.print("\nEnter input (type 'exit' to quit): ");
            input = sc.nextLine();
        }

        System.out.println("Program ended.");
        sc.close();
    }

    static void processUserInput(String input) throws ApplicationException {
        if (input == null || input.isEmpty()) {
            throw new InvalidInputException("Input cannot be null or empty");
        }

        if (input.equalsIgnoreCase("notfound")) {
            throw new ResourceNotFoundException("Requested resource not found");
        }

        if (input.equalsIgnoreCase("dbfail")) {
            throw new DatabaseConnectionException("Failed to connect to the database");
        }

        System.out.println("Input processed successfully: " + input);
    }
}
