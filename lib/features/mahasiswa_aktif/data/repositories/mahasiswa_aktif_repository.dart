import 'package:modul4/features/mahasiswa_aktif/data/models/mahasiswa_aktif_model.dart';

class MahasiswaAktifRepository {
  /// Mendapatkan daftar mahasiswa aktif (Cale, Alberu, Choi Han)
  Future<List<MahasiswaAktifModel>> getMahasiswaAktifList() async {
    // Simulasi network delay selama 1 detik
    await Future.delayed(const Duration(seconds: 1));

    // Data dummy mahasiswa aktif dengan nama khusus
    final listMahasiswa = [
      MahasiswaAktifModel(
        nama: 'Cale Henituse',
        nim: '152311513001',
        email: 'cale.henituse@vokasi.unair.ac.id',
        jurusan: 'D4 Teknik Informatika',
        isAktif: true,
      ),
      MahasiswaAktifModel(
        nama: 'Alberu Crossman',
        nim: '152311513002',
        email: 'alberu.crossman@vokasi.unair.ac.id',
        jurusan: 'D4 Teknik Informatika',
        isAktif: true,
      ),
      MahasiswaAktifModel(
        nama: 'Choi Han',
        nim: '152311513003',
        email: 'choi.han@vokasi.unair.ac.id',
        jurusan: 'D4 Teknik Informatika',
        isAktif: true,
      ),
      MahasiswaAktifModel(
        nama: 'Raon Miru',
        nim: '152311513004',
        email: 'raon.miru@vokasi.unair.ac.id',
        jurusan: 'D4 Teknik Informatika',
        isAktif: false, // Contoh data tidak aktif agar filter terlihat bekerja
      ),
    ];

    // Filter hanya mengembalikan yang statusnya isAktif: true
    return listMahasiswa.where((m) => m.isAktif).toList();
  }
}