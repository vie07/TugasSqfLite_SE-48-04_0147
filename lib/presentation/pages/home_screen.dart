import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas_sqf/model/barang.dart';
import 'package:tugas_sqf/presentation/controller/barang_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showFormDialog(BuildContext context, BarangController ctr, {Barang? barang}) {
    final namaController = TextEditingController(text: barang?.nama ?? '');
    final stokController = TextEditingController(
      text: barang != null ? barang.stok.toString() : '',
    );
    final isEdit = barang != null;

    Get.dialog(
      AlertDialog(
        title: Text(isEdit ? "Edit Barang" : "Tambah Barang"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                labelText: "Nama Barang",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: stokController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Stok",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              final nama = namaController.text.trim();
              final stok = int.tryParse(stokController.text.trim()) ?? 0;

              if (nama.isEmpty) {
                Get.snackbar("Peringatan", "Nama barang tidak boleh kosong");
                return;
              }

              if (isEdit) {
                ctr.updateBarang(
                  barang.copyWith(nama: nama, stok: stok),
                );
              } else {
                ctr.tambahBarang(
                  Barang(nama: nama, stok: stok),
                );
              }
              Get.back();
            },
            child: Text(isEdit ? "Update" : "Simpan"),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirm(BarangController ctr, Barang barang) {
    Get.dialog(
      AlertDialog(
        title: const Text("Hapus Barang"),
        content: Text("Yakin ingin menghapus '${barang.nama}'?"),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              if (barang.id != null) {
                ctr.hapusBarang(barang.id!);
              }
              Get.back();
            },
            child: const Text("Hapus", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ctr = Get.find<BarangController>();
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFormDialog(context, ctr),
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "LIST BARANG",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Obx(() {
                if (ctr.barangList.isEmpty) {
                  return const Center(child: Text("belum ada data"));
                }

                return ListView.builder(
                  itemCount: ctr.barangList.length,
                  itemBuilder: (context, index) {
                    final barang = ctr.barangList[index];
                    return Card(
                      child: ListTile(
                        title: Text(barang.nama),
                        subtitle: Text("Stok Barang: ${barang.stok}"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _showFormDialog(context, ctr, barang: barang),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _showDeleteConfirm(ctr, barang),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}