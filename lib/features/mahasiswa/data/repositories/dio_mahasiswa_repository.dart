import 'package:dio/dio.dart';
import '../models/mahasiswa_model.dart';
class MahasiswaRepository {
  // Tambahkan header User-Agent untuk menghindari error 403
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://jsonplaceholder.typicode.com',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Accept': 'application/json',
      // Header ini sangat penting agar server mengenali request dari aplikasi mobile
      'User-Agent': 'PostmanRuntime/7.37.0',
    },
  ));
  Future<List<MahasiswaModel>> getMahasiswaList() async {
    try {
      final response = await _dio.get('/comments');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => MahasiswaModel.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat data: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Penanganan error lebih detail untuk debugging
      if (e.response != null) {
        throw Exception('Server Error: ${e.response?.statusCode} - ${e.response?.statusMessage}');
      } else {
        throw Exception('Kesalahan Jaringan: ${e.message}');
      }
    }
  }
}