import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:apl_mobile_104/features/dosen/data/models/dosen_model.dart';

class DosenRepository {
  /// Mengambil daftar dosen dari API eksternal
  Future<List<DosenModel>> getDosenList() async {
      // Melakukan permintaan GET ke URL API
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users'),
        headers: {'Accept': 'application/json'},
      );

      // Cek apakah permintaan berhasil (status code 200)
      if (response.statusCode == 200) {
        // Decode body response dari string ke List JSON
        final List<dynamic> data = jsonDecode(response.body);
        print(data);

        // Ubah setiap Map di dalam list menjadi objek DosenModel
        return data.map((json) => DosenModel.fromJson(json)).toList();
      } else {
        // Jika status code bukan 200, lempar error
        print('Error: ${response.statusCode} - ${response.body}');
        throw Exception('Gagal memuat data: ${response.statusCode}');
      }
  }
}