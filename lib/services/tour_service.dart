import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_msi/models/tour_model.dart';

class TourService {
  static const baseUrl = "http://localhost:3000/wisata";

  Future<List<TourMenu>> fetchTourModel() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      final body = response.body;
      final result = jsonDecode(body);
      List<TourMenu> tours = List<TourMenu>.from(
          result['data'].map((tour) => TourMenu.fromJson(tour)));
      return tours;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
