import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas_sqf/data/repo/barang_repo.dart';
import 'package:tugas_sqf/model/barang.dart';

class BarangController extends GetxController {
  final BarangRepo repo;
  BarangController(this.repo);

  var barangList = <Barang>[].obs;

  @override
  void onInit() {
    super.onInit();
    getBarang();
  }

  Future<void> getBarang({bool showNotif = false}) async {
    try {
      barangList.value = await repo.getAllBarang();
      if (showNotif) {
        Get.snackbar("Sukses", "Data berhasil dimuat");
      }
    } catch (e) {
      Get.snackbar("Error", "Gagal memuat data: $e", backgroundColor: Colors.red);
    }
  }

  Future<void> tambahBarang(Barang barang) async {
    try {
      await repo.insert(barang);
      await getBarang();
      Get.snackbar(
        "Sukses",
        "Barang dengan nama ${barang.nama} berhasil ditambahkan",
      );
    } catch (e) {
      Get.snackbar("Error", "Gagal menambah data", backgroundColor: Colors.red);
    }
  }

  Future<void> updateBarang(Barang barang) async {
    try {
      await repo.update(barang);
      await getBarang();
      Get.snackbar(
        "Sukses",
        "Barang ${barang.nama} berhasil diperbarui",
      );
    } catch (e) {
      Get.snackbar("Error", "Gagal memperbarui data", backgroundColor: Colors.red);
    }
  }

  Future<void> hapusBarang(int id) async {
    try {
      await repo.delete(id);
      await getBarang();
      Get.snackbar(
        "Sukses",
        "Barang berhasil dihapus",
      );
    } catch (e) {
      Get.snackbar("Error", "Gagal menghapus data", backgroundColor: Colors.red);
    }
  }
}