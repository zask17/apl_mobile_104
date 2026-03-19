import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../models/mahasiswa_aktif_model.dart';

class MahasiswaAktifRepository {
  Future<List<MahasiswaAktifModel>> getMahasiswaAktif() async {
    try {
      final uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
      // Header diperkuat untuk menghindari blokir (Error 403)
      final response = await http.get(
        uri,
        headers: {
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36',
          'Accept': 'application/json',
          'Accept-Language': 'en-US,en;q=0.9',
        },
      ).timeout(const Duration(seconds: 15));

      // Debug: Cek status code di Debug Console
      debugPrint('Status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => MahasiswaAktifModel.fromJson(json)).toList();
      } else {
        // Mengambil cuplikan pesan error dari body response
        final errorSnippet = response.body.length > 100
            ? response.body.substring(0, 100)
            : response.body;
        debugPrint('Error body: $errorSnippet');
        throw 'Gagal memuat data (Error: ${response.statusCode})';
      }
    } catch (e) {
      debugPrint('Exception detail: $e');

      // Penanganan pesan error yang lebih ramah pengguna
      if (e.toString().contains('SocketException')) {
        throw 'Koneksi gagal. Pastikan Internet Emulator/HP aktif.';
      } else if (e.toString().contains('TimeoutException')) {
        throw 'Waktu tunggu habis. Jaringan mungkin sedang sangat lambat.';
      }

      throw 'Terjadi kesalahan: $e';
    }
  }
}

// Helper untuk print di Flutter agar tidak mengganggu performa production
void debugPrint(String message) {
  print('[DEBUG] $message');
}

// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/mahasiswa_aktif_model.dart';
//
// class MahasiswaAktifRepository {
//   Future<List<MahasiswaAktifModel>> getMahasiswaAktif() async {
//     try {
//       // Pastikan URL benar dan bisa diakses
//       final response = await http.get(
//         Uri.parse('https://jsonplaceholder.typicode.com/posts'),
//       ).timeout(const Duration(seconds: 10)); // Tambahkan timeout
//
//       if (response.statusCode == 200) {
//         final List<dynamic> data = jsonDecode(response.body);
//         return data.map((json) => MahasiswaAktifModel.fromJson(json)).toList();
//       } else {
//         // Berikan info status code jika gagal
//         throw 'Gagal memuat data (Status: ${response.statusCode})';
//       }
//     } catch (e) {
//       // Tangani error koneksi atau lainnya
//       throw 'Tidak dapat terhubung ke server. Silakan periksa koneksi internet Anda.';
//     }
//   }
// }