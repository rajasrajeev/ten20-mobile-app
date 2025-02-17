import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ten20/utils/constants.dart';

class ApiService {
  Future<dynamic> login(String username, String password) async {
    try {
      final response = await http.post(Uri.parse('$baseUrl/auth/login'),
          body: {"username": username, "password": password});

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<dynamic> register(
      String name, String email, String ph, String pw) async {
    try {
      final response = await http.post(Uri.parse('$baseUrl/Auth/register'),
          body: {
            "first_name": name,
            "email": email,
            "phone": ph,
            "password": pw
          });

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<dynamic> get_main_services() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/Services/get_main'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<dynamic> get_sub_services(id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/Services/get_sub/$id'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<dynamic> get_sub_services_s(id, search) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/Services/get_sub/$id/$search'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<dynamic> get_assistants(id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/Assistants/get/$id'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  Future<List<Map<String, dynamic>>> get_time_slots(date) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/Slot/get_slots/$date'),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
