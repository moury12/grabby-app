class ApiResponse<T> {
  final int statusCode;
  final bool success;
  final String message;
  final T? data;

  ApiResponse({
    required this.statusCode,
    required this.success,
    required this.message,
    this.data,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T? Function(dynamic)? fromJsonT,
  ) {
    return ApiResponse<T>(
      statusCode: json['statusCode'] as int,
      success: json['success'] as bool,
      message: json['message'] as String,
      data: fromJsonT != null
          ? fromJsonT(json)
          : null,
    );
  }

  Map<String, dynamic> toJson(Object? Function(T?)? toJsonT) {
    return {
      'statusCode': statusCode,
      'success': success,
      'message': message,
      'data': toJsonT != null ? toJsonT(data) : data,
    };
  }

  @override
  String toString() =>
      'ApiResponse(statusCode: $statusCode, success: $success, message: $message, data: $data)';
}
