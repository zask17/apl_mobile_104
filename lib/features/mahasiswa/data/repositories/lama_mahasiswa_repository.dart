// import 'package:apl_mobile_104/features/mahasiswa/data/models/mahasiswa_model.dart';
//
// class MahasiswaRepository {
//   /// Mendapatkan daftar seluruh mahasiswa
//   Future<List<MahasiswaModel>> getMahasiswaList() async {
//     // Simulasi delay network [cite: 907]
//     await Future.delayed(const Duration(milliseconds: 800));
//
//     return [
//       // Mahasiswa Aktif
//       MahasiswaModel(
//         nama: 'Cale Henituse',
//         nim: '152311513001',
//         email: 'cale.henituse@vokasi.unair.ac.id',
//         jurusan: 'D4 Teknik Informatika',
//         isAktif: true,
//       ),
//       MahasiswaModel(
//         nama: 'Alberu Crossman',
//         nim: '152311513002',
//         email: 'alberu.crossman@vokasi.unair.ac.id',
//         jurusan: 'D4 Teknik Informatika',
//         isAktif: true,
//       ),
//       MahasiswaModel(
//         nama: 'Choi Han',
//         nim: '152311513003',
//         email: 'choi.han@vokasi.unair.ac.id',
//         jurusan: 'D4 Teknik Informatika',
//         isAktif: true,
//       ),
//       // Mahasiswa Tidak Aktif
//       MahasiswaModel(
//         nama: 'Raon Miru',
//         nim: '152311513004',
//         email: 'raon.miru@vokasi.unair.ac.id',
//         jurusan: 'D4 Teknik Informatika',
//         isAktif: false,
//       ),
//       MahasiswaModel(
//         nama: 'Ahmad Fauzi',
//         nim: '152311513005',
//         email: 'ahmad.fauzi@example.com',
//         jurusan: 'Sistem Informasi',
//         isAktif: false,
//       ),
//       MahasiswaModel(
//         nama: 'Siti Aminah',
//         nim: '152311513006',
//         email: 'siti.aminah@example.com',
//         jurusan: 'Teknik Informatika',
//         isAktif: false,
//       ),
//     ];
//   }
// }