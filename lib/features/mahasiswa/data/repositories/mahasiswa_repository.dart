import 'package:modul4/features/mahasiswa/data/models/mahasiswa_model.dart';

class MahasiswaRepository {
  Future<List<MahasiswaModel>> getMahasiswaList() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      MahasiswaModel(
        nama: 'Ahmad Fauzi',
        nim: '210001',
        email: 'ahmad.fauzi@example.com',
        jurusan: 'Teknik Informatika',
      ),
      MahasiswaModel(
        nama: 'Siti Aminah',
        nim: '210002',
        email: 'siti.aminah@example.com',
        jurusan: 'Sistem Informasi',
      ),
      MahasiswaModel(
        nama: 'Budi Santoso',
        nim: '210003',
        email: 'budi.santoso@example.com',
        jurusan: 'Teknik Informatika',
      ),
    ];
  }

  Future<List<MahasiswaModel>> getMahasiswaAktifList() async {
    final list = await getMahasiswaList();
    return list.where((m) => m.isAktif).toList();
  }
}
