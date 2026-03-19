import 'package:dio/dio.dart';
import '../models/mahasiswa_aktif_model.dart';

class MahasiswaAktifRepository {
  // Inisialisasi Dio dengan Header untuk keamanan
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://jsonplaceholder.typicode.com',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Accept': 'application/json',
      'User-Agent': 'Mozilla/5.0',
    },
  ));

  // Pastikan nama fungsi ini tepat 'getMahasiswaAktif'
  Future<List<MahasiswaAktifModel>> getMahasiswaAktif() async {
    try {
      final response = await _dio.get('/posts');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => MahasiswaAktifModel.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat data (Status: ${response.statusCode})');
      }
    } on DioException catch (e) {
      throw Exception('Kesalahan Jaringan: ${e.message}');
    }
  }
}