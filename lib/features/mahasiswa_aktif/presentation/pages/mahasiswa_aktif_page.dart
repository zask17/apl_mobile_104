import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modul4/core/widgets/widgets.dart';
import 'package:modul4/features/mahasiswa/presentation/providers/mahasiswa_provider.dart';
import 'package:modul4/features/mahasiswa/presentation/widgets/mahasiswa_widget.dart';

class MahasiswaAktifPage extends ConsumerWidget {
  const MahasiswaAktifPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Memantau provider khusus yang sudah kita beri filter onlyActive: true
    final mahasiswaAktifState = ref.watch(mahasiswaAktifNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mahasiswa Aktif'),
        // Menggunakan warna Teal agar berbeda dengan halaman utama (sesuai kreativitas)
        backgroundColor: Colors.teal,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.read(mahasiswaAktifNotifierProvider.notifier).refresh(),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: mahasiswaAktifState.when(
        loading: () => const LoadingWidget(),
        error: (error, stack) => CustomErrorWidget(
          message: 'Gagal memuat data: ${error.toString()}',
          onRetry: () => ref.read(mahasiswaAktifNotifierProvider.notifier).refresh(),
        ),
        data: (mahasiswaList) {
          // Jika list kosong (misal semua isAktif: false), tampilkan pesan
          if (mahasiswaList.isEmpty) {
            return const Center(
              child: Text('Tidak ada mahasiswa aktif saat ini.'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: mahasiswaList.length,
            itemBuilder: (context, index) {
              final mahasiswa = mahasiswaList[index];
              return ModernMahasiswaCard(
                mahasiswa: mahasiswa,
                // Gradien warna khusus tema Teal untuk Mahasiswa Aktif
                gradientColors: [Colors.teal.shade300, Colors.teal.shade600],
                onTap: () {
                  // Logika saat kartu diklik (opsional)
                },
              );
            },
          );
        },
      ),
    );
  }
}