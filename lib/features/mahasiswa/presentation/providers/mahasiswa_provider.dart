import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modul4/features/mahasiswa/data/models/mahasiswa_model.dart';
import 'package:modul4/features/mahasiswa/data/repositories/mahasiswa_repository.dart';

final mahasiswaRepositoryProvider = Provider<MahasiswaRepository>((ref) {
  return MahasiswaRepository();
});

class MahasiswaNotifier extends StateNotifier<AsyncValue<List<MahasiswaModel>>> {
  final MahasiswaRepository _repository;
  final bool onlyActive; // Tambahkan flag filter

  MahasiswaNotifier(this._repository, {this.onlyActive = false}) : super(const AsyncValue.loading()) {
    loadMahasiswaList();
  }

  Future<void> loadMahasiswaList() async {
    state = const AsyncValue.loading();
    try {
      // Ambil data dari repository
      final data = await _repository.getMahasiswaList();

      // Jika onlyActive true, filter data hanya yang aktif
      if (onlyActive) {
        state = AsyncValue.data(data.where((m) => m.isAktif).toList());
      } else {
        state = AsyncValue.data(data);
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refresh() async {
    await loadMahasiswaList();
  }
}

// Provider untuk menampilkan SEMUA mahasiswa
final mahasiswaNotifierProvider =
StateNotifierProvider.autoDispose<MahasiswaNotifier, AsyncValue<List<MahasiswaModel>>>((ref) {
  final repository = ref.watch(mahasiswaRepositoryProvider);
  return MahasiswaNotifier(repository, onlyActive: false);
});

// Provider khusus untuk menampilkan MAHASISWA AKTIF saja
final mahasiswaAktifNotifierProvider =
StateNotifierProvider.autoDispose<MahasiswaNotifier, AsyncValue<List<MahasiswaModel>>>((ref) {
  final repository = ref.watch(mahasiswaRepositoryProvider);
  return MahasiswaNotifier(repository, onlyActive: true); // Flag aktif diaktifkan
});