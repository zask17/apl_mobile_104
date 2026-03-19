// lib/features/mahasiswa_aktif/data/repositories/mahasiswa_aktif_repository.dart

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../models/mahasiswa_aktif_model.dart';

class MahasiswaAktifRepository {
  // ====================== GANTI SALAH SATU SAJA ======================

  // === VERSI DIO (Rekomendasi) ===
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://jsonplaceholder.typicode.com',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  Future<List<MahasiswaAktifModel>> getMahasiswaAktifList() async {
    try {
      final response = await _dio.get('/posts');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return _mapToModel(data);
      }
      throw Exception('Gagal mengambil data');
    } on DioException catch (e) {
      throw Exception('Dio Error: ${e.message}');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  List<MahasiswaAktifModel> _mapToModel(List<dynamic> data) {
    return data.map((post) => MahasiswaAktifModel.fromJson({
      'nama': post['title'] ?? 'Mahasiswa Aktif',
      'nim': post['id'].toString().padLeft(12, '0'),
      'email': 'mahasiswa${post['id']}@vokasi.unair.ac.id',
      'jurusan': 'D4 Teknik Informatika',
      'isAktif': true,
    })).toList();
  }
}