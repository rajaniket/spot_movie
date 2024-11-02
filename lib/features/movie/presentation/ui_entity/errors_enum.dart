enum ErrorType {
  noLocationInfoError,
  unknownError;

  // Method to return the title for each error type
  String getTitle() {
    switch (this) {
      case ErrorType.noLocationInfoError:
        return 'Location Information Unavailable';
      case ErrorType.unknownError:
        return 'Something went wrong';
    }
  }

  // Method to return the description for each error type
  String getDescription() {
    switch (this) {
      case ErrorType.noLocationInfoError:
        return 'Location information is not available at this time.';
      case ErrorType.unknownError:
        return 'Please try again later.';
    }
  }
}
