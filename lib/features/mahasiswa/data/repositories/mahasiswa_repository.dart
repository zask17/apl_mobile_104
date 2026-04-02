import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../models/mahasiswa_model.dart';

class MahasiswaRepository {
  final DioClient _dioClient;

  MahasiswaRepository({DioClient? dioClient})
      : _dioClient = dioClient ?? DioClient();

  Future<List<MahasiswaModel>> getMahasiswaList() async {
    try {
      final response = await _dioClient.dio.get('/comments');
      final List<dynamic> data = response.data;
      // Mengambil 10 data pertama agar tidak terlalu panjang
      return data.take(10).map((json) => MahasiswaModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception(
          'Gagal memuat data mahasiswa: ${e.response?.statusCode ?? ""} ${e.message}');
    }
  }
}
