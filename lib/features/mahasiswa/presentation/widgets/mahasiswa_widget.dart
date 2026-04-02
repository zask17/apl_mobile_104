import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/mahasiswa_provider.dart';
import '../../data/models/mahasiswa_model.dart';

class SavedMahasiswaSection extends ConsumerWidget {
  final AsyncValue<List<Map<String, String>>> savedUsers;
  const SavedMahasiswaSection({super.key, required this.savedUsers});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.storage_rounded, size: 16),
              const SizedBox(width: 6),
              const Text('Data Tersimpan di Local Storage',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const Spacer(),
              savedUsers.maybeWhen(
                data: (users) => users.isNotEmpty
                    ? TextButton(
                  onPressed: () async {
                    await ref.read(mahasiswaNotifierProvider.notifier).clearSavedMahasiswa();
                    ref.invalidate(savedMahasiswaProvider);
                  },
                  child: const Text('Hapus Semua',
                      style: TextStyle(color: Colors.red, fontSize: 12)),
                )
                    : const SizedBox.shrink(),
                orElse: () => const SizedBox.shrink(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          savedUsers.when(
            loading: () => const LinearProgressIndicator(),
            error: (err, stack) => const Text('Gagal membaca data'),
            data: (users) {
              if (users.isEmpty) return const Text('Belum ada data mahasiswa tersimpan',
                  style: TextStyle(fontSize: 12, color: Colors.grey));
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    dense: true,
                    title: Text(users[index]['username'] ?? '',
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                    subtitle: Text('ID: ${users[index]['user_id']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.close, size: 16, color: Colors.red),
                      onPressed: () async {
                        await ref.read(mahasiswaNotifierProvider.notifier)
                            .removeSavedMahasiswa(users[index]['user_id']!);
                        ref.invalidate(savedMahasiswaProvider);
                      },
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class MahasiswaListWithSave extends ConsumerWidget {
  final List<MahasiswaModel> mahasiswaList;
  final VoidCallback onRefresh;
  const MahasiswaListWithSave({super.key, required this.mahasiswaList, required this.onRefresh});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: ListView.builder(
        itemCount: mahasiswaList.length,
        itemBuilder: (context, index) {
          final mhs = mahasiswaList[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: CircleAvatar(child: Text('${mhs.id}')),
              title: Text(mhs.name, maxLines: 1, overflow: TextOverflow.ellipsis),
              subtitle: Text('${mhs.email}\n${mhs.body}',
                  maxLines: 2, overflow: TextOverflow.ellipsis),
              isThreeLine: true,
              trailing: IconButton(
                icon: const Icon(Icons.save),
                onPressed: () async {
                  await ref.read(mahasiswaNotifierProvider.notifier).saveSelectedMahasiswa(mhs);
                  ref.invalidate(savedMahasiswaProvider);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Mahasiswa ${mhs.id} disimpan')));
                },
              ),
            ),
          );
        },
      ),
    );
  }
}