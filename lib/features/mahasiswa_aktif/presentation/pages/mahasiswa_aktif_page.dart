import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modul4/core/widgets/widgets.dart';
import 'package:modul4/features/mahasiswa/presentation/providers/mahasiswa_provider.dart';
import 'package:modul4/features/mahasiswa/presentation/widgets/mahasiswa_widget.dart';

class MahasiswaAktifPage extends ConsumerWidget {
  const MahasiswaAktifPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mahasiswaState = ref.watch(mahasiswaNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mahasiswa Aktif'),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: mahasiswaState.when(
        loading: () => const LoadingWidget(),
        error: (error, stack) => CustomErrorWidget(
          message: 'Gagal memuat data',
          onRetry: () => ref.read(mahasiswaNotifierProvider.notifier).refresh(),
        ),
        data: (mahasiswaList) {
          // Filter hanya yang aktif secara langsung di UI
          final aktifList = mahasiswaList.where((m) => m.isAktif).toList();

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: aktifList.length,
            itemBuilder: (context, index) {
              return ModernMahasiswaCard(
                mahasiswa: aktifList[index],
                gradientColors: [Colors.teal.shade300, Colors.teal.shade600],
              );
            },
          );
        },
      ),
    );
  }
}