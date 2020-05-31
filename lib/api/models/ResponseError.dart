class ResponseError {
  String statusMessage;
  bool success;
  int statusCode;

  ResponseError({this.statusMessage, this.success, this.statusCode});

  ResponseError.fromJson(Map<String, dynamic> json) {
    statusMessage = json['status_message'];
    success = json['success'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_message'] = this.statusMessage;
    data['success'] = this.success;
    data['status_code'] = this.statusCode;
    return data;
  }
}