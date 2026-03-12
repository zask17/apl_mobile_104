class MahasiswaAktifModel {
  final String nama;
  final String nim;
  final String email;
  final String jurusan;
  final bool isAktif;

  MahasiswaAktifModel({
    required this.nama,
    required this.nim,
    required this.email,
    required this.jurusan,
    this.isAktif = true,
  });

  // Mengonversi data dari format JSON ke objek model
  factory MahasiswaAktifModel.fromJson(Map<String, dynamic> json) {
    return MahasiswaAktifModel(
      nama: json['nama'] ?? '',
      nim: json['nim'] ?? '',
      email: json['email'] ?? '',
      jurusan: json['jurusan'] ?? '',
      isAktif: json['isAktif'] ?? true,
    );
  }

  // Mengonversi objek model kembali ke format JSON
  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'nim': nim,
      'email': email,
      'jurusan': jurusan,
      'isAktif': isAktif,
    };
  }
}