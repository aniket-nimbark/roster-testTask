import 'package:dio/dio.dart';

class ApiService{
  static final Dio _dio = Dio();

   Future getUsers(url) async {

    final response = await _dio.get(url);
    print(response.data["results"]);
    print("Fdsfkjhsdfkjdsjk");
    return response.data;
  }
}