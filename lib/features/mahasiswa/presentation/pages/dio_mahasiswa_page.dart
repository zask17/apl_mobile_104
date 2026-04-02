// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:apl_mobile_104/core/widgets/widgets.dart';
// import 'package:apl_mobile_104/core/constants/constants.dart';
// import '../providers/mahasiswa_provider.dart';
// import '../widgets/mahasiswa_widget.dart';
//
// class MahasiswaPage extends ConsumerWidget {
//   const MahasiswaPage({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final mahasiswaState = ref.watch(mahasiswaNotifierProvider);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Data Mahasiswa'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh_rounded),
//             onPressed: () => ref.read(mahasiswaNotifierProvider.notifier).refresh(),
//           ),
//         ],
//       ),
//       body: mahasiswaState.when(
//         loading: () => const LoadingWidget(),
//         error: (error, stack) => CustomErrorWidget(
//           message: 'Gagal memuat data: ${error.toString()}',
//           onRetry: () => ref.read(mahasiswaNotifierProvider.notifier).refresh(),
//         ),
//         data: (mahasiswaList) {
//           return RefreshIndicator(
//             onRefresh: () async => ref.read(mahasiswaNotifierProvider.notifier).refresh(),
//             child: ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: mahasiswaList.length,
//               itemBuilder: (context, index) {
//                 final colors = AppConstants.dashboardGradients[
//                 index % AppConstants.dashboardGradients.length];
//
//                 return ModernMahasiswaCard(
//                   mahasiswa: mahasiswaList[index],
//                   gradientColors: colors,
//                   onTap: () {},
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }