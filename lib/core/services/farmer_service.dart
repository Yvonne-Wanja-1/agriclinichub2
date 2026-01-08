import 'dart:convert';
import 'package:http/http.dart' as http;

class FarmerService {
  // Replace localhost with your machine's IP if testing on mobile device
static const String baseUrl = 'http://192.168.0.117:3000/api/farmers';


  // Get all farmers
  static Future<List<dynamic>> getFarmers() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load farmers');
    }
  }

  // Add a farmer
  static Future<bool> addFarmer(
    String name,
    String phone,
    String county,
  ) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'phone': phone, 'county': county}),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to add farmer');
    }
  }
}
