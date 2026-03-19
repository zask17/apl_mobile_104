import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apl_mobile_104/core/widgets/widgets.dart';
import 'package:apl_mobile_104/core/constants/constants.dart';
import '../providers/mahasiswa_aktif_provider.dart';
import '../widgets/mahasiswa_aktif_widget.dart';

class MahasiswaAktifPage extends ConsumerWidget {
  const MahasiswaAktifPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mahasiswaAktifNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mahasiswa Aktif'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.read(mahasiswaAktifNotifierProvider.notifier).refresh(),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) {
          final errorMsg = err.toString().replaceAll('Exception: ', '');
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline_rounded, size: 80, color: Colors.redAccent),
                  const SizedBox(height: 16),
                  Text(
                    'Gagal memuat data',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.redAccent),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    errorMsg,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.refresh),
                    label: const Text('Coba Lagi'),
                    onPressed: () => ref.read(mahasiswaAktifNotifierProvider.notifier).refresh(),
                  ),
                ],
              ),
            ),
          );
        },
        data: (list) => RefreshIndicator(
          onRefresh: () => ref.read(mahasiswaAktifNotifierProvider.notifier).refresh(),
          child: list.isEmpty
              ? const Center(child: Text('Tidak ada data saat ini'))
              : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final item = list[index];
              final colors = AppConstants.dashboardGradients[
              index % AppConstants.dashboardGradients.length];

              return ModernMahasiswaAktifCard(
                mahasiswa: item,
                gradientColors: colors,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Post ID: ${item.id} • User ${item.userId}')),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
//
// class MahasiswaAktifPage extends ConsumerWidget {
//   const MahasiswaAktifPage({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(mahasiswaAktifNotifierProvider);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Mahasiswa Aktif'),
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh_rounded),
//             onPressed: () => ref.read(mahasiswaAktifNotifierProvider.notifier).refresh(),
//           ),
//         ],
//       ),
//       body: state.when(
//         loading: () => const LoadingWidget(),
//         error: (err, stack) => CustomErrorWidget(
//           message: err.toString(),
//           onRetry: () => ref.read(mahasiswaAktifNotifierProvider.notifier).refresh(),
//         ),
//         data: (list) => RefreshIndicator(
//           onRefresh: () => ref.read(mahasiswaAktifNotifierProvider.notifier).refresh(),
//           child: ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: list.length,
//             itemBuilder: (context, index) {
//               final item = list[index];
//               final colors = AppConstants.dashboardGradients[
//               index % AppConstants.dashboardGradients.length];
//
//               // GUNAKAN WIDGET MODERN DI SINI
//               return ModernMahasiswaAktifCard(
//                 mahasiswa: item,
//                 gradientColors: colors,
//                 onTap: () {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Post ID: ${item.id}')),
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }