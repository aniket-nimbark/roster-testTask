import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roster/services/apiservice.dart';
import 'package:roster/user_model.dart';

// final usersProvider = FutureProvider.family<List<User>, String>((ref, url) async {
// // final usersProvider = FutureProvider<List<User>>((ref) async {
//   Dio dio = Dio();
//   final response = await dio.get(url);
//   print("fdsljfhdslkjlk");
//
//   print(response.data["results"]);
//   final List<User> users = (response.data['results'] as List).map((userData) => User.fromJson(userData)).toList();
//
//   return users;
// });


final isLoadingProvider = StateProvider((ref) => false);

final getUserDataProvider= StateNotifierProvider<GetUserData,List<User>>((ref) =>GetUserData());



class GetUserData extends StateNotifier<List<User>> {
  GetUserData():super([]);
  var next = "";
  var isloadmore = false;
  Future<List<User>> fetchUsers({String? searchQuery="", int page = 1}) async {

var url="https://api.konquer.club/api/v2/users";
    try{
      final data =await ApiService().getUsers(url);
      next =data["next"];
      print("Fdskjfhdjks");
      print(data['results']);
      final List<User> users = (data['results'] as List).map((userData) => User.fromJson(userData)).toList();
      print(users);
state = users;
    }catch(e){
print(e.toString());
rethrow;
    }
return  state;
  }

  Future<List<User>> nextUsers({String? searchQuery="", int page = 1}) async {
    isloadmore = true;
print("${next}?name=${searchQuery}");
    try{
      final data =await ApiService().getUsers("${next}");
      next =data["next"];
      print("Fdskjfhdjks");
      final List<User> users = (data['results'] as List).map((userData) => User.fromJson(userData)).toList();
      state = [...state,...users];
    }catch(e){

      rethrow;
    }
  isloadmore = false;
    return  state;
  }

}