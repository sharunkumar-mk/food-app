import 'package:flutter/foundation.dart';

class ResponseState {
  final dynamic response;
  final bool? isLoading;
  final bool? isError;
  final String? errorMessage;

  ResponseState(
      {this.response, this.isLoading, this.errorMessage, this.isError});

  ResponseState.initial()
      : response = [],
        isLoading = false,
        errorMessage = '',
        isError = false;

  ResponseState copyWith({
    dynamic response,
    bool? isLoading,
    bool? isError,
    String? errorMessage,
  }) {
    return ResponseState(
        response: response ?? this.response,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        isError: isError ?? this.isError);
  }

  @override
  String toString() =>
      'ResponseState(response: $response, isLoading: $isLoading, errorMessage: $errorMessage, isError: $isError)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResponseState &&
        listEquals(other.response, response) &&
        other.isLoading == isLoading &&
        other.errorMessage == errorMessage &&
        other.isError == isError;
  }

  @override
  int get hashCode =>
      response.hashCode ^
      isLoading.hashCode ^
      errorMessage.hashCode ^
      isError.hashCode;
}
