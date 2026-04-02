import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/dosen_provider.dart';
import '../../data/models/dosen_model.dart';

class SavedUserSection extends ConsumerWidget {
  final AsyncValue<List<Map<String, String>>> savedUsers;
  const SavedUserSection({super.key, required this.savedUsers});

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
              const Text('Data Tersimpan di Local Storage', style: TextStyle(fontWeight: FontWeight.bold)),
              const Spacer(),
              savedUsers.maybeWhen(
                data: (users) => users.isNotEmpty
                    ? TextButton(
                  onPressed: () async {
                    await ref.read(dosenNotifierProvider.notifier).clearSavedUsers();
                    ref.invalidate(savedUsersProvider);
                  },
                  child: const Text('Hapus Semua', style: TextStyle(color: Colors.red, fontSize: 12)),
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
              if (users.isEmpty) return const Text('Belum ada data tersimpan', style: TextStyle(fontSize: 12, color: Colors.grey));
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    dense: true,
                    title: Text(user['username'] ?? ''),
                    subtitle: Text('ID: ${user['user_id']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.close, size: 16, color: Colors.red),
                      onPressed: () async {
                        await ref.read(dosenNotifierProvider.notifier).removeSavedUser(user['user_id']!);
                        ref.invalidate(savedUsersProvider);
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

class DosenListWithSave extends ConsumerWidget {
  final List<DosenModel> dosenList;
  final VoidCallback onRefresh;
  const DosenListWithSave({super.key, required this.dosenList, required this.onRefresh});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: ListView.builder(
        itemCount: dosenList.length,
        itemBuilder: (context, index) {
          final dosen = dosenList[index];
          return Card(
            child: ListTile(
              title: Text(dosen.name),
              subtitle: Text(dosen.email),
              trailing: IconButton(
                icon: const Icon(Icons.save),
                onPressed: () async {
                  await ref.read(dosenNotifierProvider.notifier).saveSelectedDosen(dosen);
                  ref.invalidate(savedUsersProvider);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${dosen.username} disimpan')),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}