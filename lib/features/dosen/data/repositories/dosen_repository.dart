import 'package:dio/dio.dart';
import 'package:apl_mobile_104/features/dosen/data/models/dosen_model.dart';

class DosenRepository {
  final Dio _dio = Dio();

  /// Mendapatkan daftar dosen menggunakan Dio
  Future<List<DosenModel>> getDosenList() async {
    try {
      // Melakukan permintaan GET ke URL API
      final response = await _dio.get(
        'https://jsonplaceholder.typicode.com/users',
        options: Options(
          headers: {'Accept': 'application/json'},
        ),
      );

      // Dio secara otomatis melakukan jsonDecode, jadi kita bisa langsung akses datanya
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        // Debug: Tampilkan data di console
        print('Data dari Dio: $data');

        return data.map((json) => DosenModel.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat data dosen: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Penanganan error khusus Dio (misal: timeout, koneksi terputus)
      print('Dio Error: ${e.message}');
      throw Exception('Terjadi kesalahan jaringan: ${e.message}');
    } catch (e) {
      print('General Error: $e');
      throw Exception('Gagal memuat data: $e');
    }
  }
}