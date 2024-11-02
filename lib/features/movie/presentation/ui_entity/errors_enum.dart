enum ErrorType {
  networkError,
  mapError,
  noLocationInfoError,
  locationPermissionError,
  unknownError;

  // Method to return the title for each error type
  String getTitle() {
    switch (this) {
      case ErrorType.networkError:
        return 'Network Error';
      case ErrorType.mapError:
        return 'Map Error';
      case ErrorType.noLocationInfoError:
        return 'Location Information Unavailable';
      case ErrorType.locationPermissionError:
        return 'Location Access Required';
      case ErrorType.unknownError:
        return 'Unknown Error';
    }
  }

  // Method to return the description for each error type
  String getDescription() {
    switch (this) {
      case ErrorType.networkError:
        return 'Unable to connect to the server or check your internet connection.';
      case ErrorType.mapError:
        return 'An error occurred while loading the map.';
      case ErrorType.noLocationInfoError:
        return 'Location information is not available at this time.';
      case ErrorType.locationPermissionError:
        return 'Please enable location permissions in settings to access location-based features.';
      case ErrorType.unknownError:
        return 'Something went wrong. Please try again later.';
    }
  }
}
