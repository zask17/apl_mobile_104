// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../data/models/mahasiswa_aktif_model.dart';
// import '../../data/repositories/mahasiswa_aktif_repository.dart';
//
// final mahasiswaAktifRepoProvider = Provider((ref) => MahasiswaAktifRepository());
//
// class MahasiswaAktifNotifier extends StateNotifier<AsyncValue<List<MahasiswaAktifModel>>> {
//   final MahasiswaAktifRepository _repository;
//
//   MahasiswaAktifNotifier(this._repository) : super(const AsyncValue.loading()) {
//     refresh();
//   }
//
//   Future<void> refresh() async {
//     state = const AsyncValue.loading();
//     try {
//       final data = await _repository.getMahasiswaAktif();
//       state = AsyncValue.data(data);
//     } catch (e, st) {
//       state = AsyncValue.error(e, st);
//     }
//   }
// }
//
// final mahasiswaAktifNotifierProvider = StateNotifierProvider.autoDispose<
//     MahasiswaAktifNotifier, AsyncValue<List<MahasiswaAktifModel>>>((ref) {
//   return MahasiswaAktifNotifier(ref.watch(mahasiswaAktifRepoProvider));
// });