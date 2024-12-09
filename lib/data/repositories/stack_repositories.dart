import 'dart:convert';
import 'package:cred_assignment/core/utils/constatnts.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:cred_assignment/domain/entities/stack_items.dart';

class StackRepository {
  Future<List<StackItem>> fetchStackItems() async {
    final response = await http.get(Uri.parse(APIConstants.baseUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (kDebugMode) {
        print('Response: ${response.body}');
      }
      final List<dynamic> items = jsonResponse['items'];
      return items.map((item) => StackItem.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load stack items');
    }
  }
}
