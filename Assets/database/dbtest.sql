/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 100316
 Source Host           : localhost:3306
 Source Schema         : dbtest

 Target Server Type    : MySQL
 Target Server Version : 100316
 File Encoding         : 65001

 Date: 15/11/2019 03:44:48
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for analisa
-- ----------------------------
DROP TABLE IF EXISTS `analisa`;
CREATE TABLE `analisa`  (
  `ahs_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kpek_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ahs_nama` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ahs_harga` double(255, 0) NULL DEFAULT NULL,
  PRIMARY KEY (`ahs_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for anggaran
-- ----------------------------
DROP TABLE IF EXISTS `anggaran`;
CREATE TABLE `anggaran`  (
  `ang_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pr_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ahs_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ang_volume` double(255, 0) NULL DEFAULT NULL,
  `sat_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ang_total` double(255, 0) NULL DEFAULT NULL,
  PRIMARY KEY (`ang_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for detail_ahs
-- ----------------------------
DROP TABLE IF EXISTS `detail_ahs`;
CREATE TABLE `detail_ahs`  (
  `hit_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ahs_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pkrjbhn_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `hit_index` double(255, 0) NULL DEFAULT NULL,
  `hit_total` double(255, 0) NULL DEFAULT NULL,
  PRIMARY KEY (`hit_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for kategori_pekerjaan
-- ----------------------------
DROP TABLE IF EXISTS `kategori_pekerjaan`;
CREATE TABLE `kategori_pekerjaan`  (
  `kpek_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `kpek_prior` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `kpek_nama` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`kpek_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for pekerja_bahan
-- ----------------------------
DROP TABLE IF EXISTS `pekerja_bahan`;
CREATE TABLE `pekerja_bahan`  (
  `pkrjbhn_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pkrjbhn_nama` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pkrjbhn_harga` double(255, 0) NULL DEFAULT NULL,
  `sat_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pkrjbhn_jenis` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pkrjbhn_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pekerja_bahan
-- ----------------------------
INSERT INTO `pekerja_bahan` VALUES ('00001', 'Tukang kayu', 90000, '3', 'Pekerja');
INSERT INTO `pekerja_bahan` VALUES ('00002', 'Kepala Tukang Kayu', 95000, '3', 'Pekerja');
INSERT INTO `pekerja_bahan` VALUES ('00003', 'Tukang batu', 90000, '3', 'Pekerja');
INSERT INTO `pekerja_bahan` VALUES ('00004', 'Kepala tukang batu', 95000, '3', 'Pekerja');
INSERT INTO `pekerja_bahan` VALUES ('00005', 'Tukang besi', 90000, '3', 'Pekerja');
INSERT INTO `pekerja_bahan` VALUES ('00006', 'Kepala tukang besi', 95000, '3', 'Pekerja');
INSERT INTO `pekerja_bahan` VALUES ('00007', 'Tukang las', 90000, '3', 'Pekerja');
INSERT INTO `pekerja_bahan` VALUES ('00008', 'Kepala tukang las', 95000, '3', 'Pekerja');
INSERT INTO `pekerja_bahan` VALUES ('00009', 'Tukang cat', 90000, '3', 'Pekerja');
INSERT INTO `pekerja_bahan` VALUES ('00010', 'Kepala tukang cat', 95000, '3', 'Pekerja');
INSERT INTO `pekerja_bahan` VALUES ('00011', 'Tukang listrik', 90000, '3', 'Pekerja');
INSERT INTO `pekerja_bahan` VALUES ('00012', 'Pekerja', 85000, '3', 'Pekerja');
INSERT INTO `pekerja_bahan` VALUES ('00013', 'Mandor', 93000, '3', 'Pekerja');
INSERT INTO `pekerja_bahan` VALUES ('00014', 'Pengawas', 130000, '3', 'Pekerja');
INSERT INTO `pekerja_bahan` VALUES ('00015', 'Cat Tembok Catylac', 19000, '1', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00016', 'Cat dasar undercoat / alkali resisiting primer', 45500, '1', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00017', 'Cat Tembok Luar ICI weathershield', 75000, '1', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00018', 'Plamur Fuji', 19500, '1', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00019', 'Kloset jongkok porselin type CE7 standar', 205000, '9', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00020', 'Wastafel warna (KIA)', 310000, '13', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00021', 'Kran air diameter 1/2\" Besi', 20000, '9', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00022', 'Seal tape', 1750, '9', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00023', 'Floordrain', 35000, '9', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00024', 'Ember Air 0,3 5', 200000, '9', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00025', 'Keramik Lantai 40/40 UNPOLISH , ex \"Niro Granite seri Yura\"', 700000, '6', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00026', 'Tegel keramik 30/30 POLISH Setara \"MULIA\"', 48000, '6', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00027', 'Tegel keramik 20/20 UNPOLISH Setara \"MULIA\"', 42000, '6', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00028', 'Keramik dinding 20/30 Setara \"MULIA\"', 49500, '6', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00029', 'Plint keramik 10 x 30 Setara \"MULIA\"', 2400, '9', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00030', 'Stepnosing 8/30', 19000, '7', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00031', 'Kayu bengkirai balok', 9000000, '5', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00032', 'Kayu bengkirai papan', 11000000, '5', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00033', 'Kayu meranti', 4000000, '5', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00034', 'Kayu Multyplek 9mm', 95000, '8', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00035', 'Besi beton polos', 9300, '1', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00036', 'Besi beton ulir', 9800, '1', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00037', 'Besi strip', 18000, '1', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00038', 'Besi baja profil', 13500, '1', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00039', 'Kawat beton / bindrat', 15500, '1', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00040', 'Seng BJLS 0,20 lembaran 90 cm lebar', 25500, '7', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00041', 'Pipa galvanis dia. 2\" tebal 3,2 mm', 63000, '7', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00042', 'Pipa galvanis dia. 3\" tebal 3,2 mm', 67000, '7', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00043', 'Pipa galvanis dia. 4\" tebal 3,2 mm', 83500, '7', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00044', 'Pipa hollow 2 x 4 cm tebal 1.2 mm', 19950, '7', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00045', 'Pipa stainless 1\" tebal 1,5 mm', 31000, '7', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00046', 'Pipa stainless 2\"  tebal 1,5 mm', 59500, '7', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00047', 'Pipa hollow 4 x 4 cm tebal 1.2 mm', 19900, '7', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00048', 'Roster 20/20', 3000, '9', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00049', 'Gypsum board', 55000, '8', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00050', 'Kalsiboard ( 122 x 244 x 0,35 ) cm', 53500, '8', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00051', 'Kasa gypsum', 8500, '14', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00052', 'Tepung Gypsum', 4000, '1', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00053', 'Alkasit', 17000, '1', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00054', 'Kawat penggantung rangka hollow', 1000, '7', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00055', 'Pintu lipat besi', 500000, '6', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00056', 'Paku reng 55 x 3,1 mm', 13875, '1', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00057', 'Paku usuk 80 x 3,8 mm', 13500, '1', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00058', 'Paku plepet 40 x 2,1 mm', 15500, '1', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00059', 'Paku biasa 2\" - 5\"', 16000, '1', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00060', 'Paku skrup', 30000, '1', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00061', 'Paku skrup anti karat atap metal/polykarbonat', 1250, '1', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00062', 'Kalsiplank polos tebal 8mm', 22500, '7', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00063', 'Atap polykarbonat', 250000, '6', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00064', 'Wire Mesh M4 ?4 -100X100 mm ', 70000, '6', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00065', 'Engsel pintu', 24167, '9', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00066', 'Handle pintu', 85000, '9', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00067', 'Engsel jendela', 14000, '9', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00068', 'Kunci tanam', 35000, '9', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00069', 'Batu belah hitam', 110000, '5', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00070', 'Pasir urug darat', 60000, '5', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00071', 'Pasir urug', 45000, '5', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00072', 'Pasir pasang ( krasak )', 80000, '5', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00073', 'Split pecah 2x3 cm', 170000, '5', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00074', 'Batu merah  ( 5x11x23 )', 650, '9', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00075', 'Portland Cement (PC) Holcim', 63450, '21', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00076', 'Semen warna', 9500, '1', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00077', 'Air', 38, '2', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00078', 'Batu andesit', 250000, '6', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00079', 'Kaca bening 5 mm', 75000, '6', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00080', 'Genteng beton besar natural 1m 9 9', 4000, '9', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00081', 'Genteng bubungan beton', 5250, '9', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00082', 'Pipa PVC AW dia. 3/4\" Sekualitas Wavin', 13000, '11', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00083', 'Pipa PVC AW dia. 3\" Sekualitas Wavin', 65000, '11', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00084', 'Pipa PVC AW dia. 4\" Sekualitas Wavin', 80000, '11', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00085', 'Sewa Scaffolding', 20000, '9', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00086', 'Sewa alat las', 50000, '9', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00087', 'Solar', 9400, '2', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00088', 'Minyak pelumas', 24000, '2', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00089', 'Kawat las listrik', 24500, '1', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00090', 'Pasang instalasi titik lampu 220 V', 225000, '9', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00091', 'Pasang instalasi stop kontak 220 V', 175000, '9', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00092', 'Pasang saklar tunggal', 23000, '9', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00093', 'Pasang saklar double', 23000, '9', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00094', 'Pasang stop kontak dinding', 19500, '9', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00095', 'Pengadaan dan pemasangan lampu SL 18 Watt + Armaturnya', 350000, '9', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00096', 'Pengadaan dan pemasangan lampu RM  2 X 18 Watt + Armaturnya', 690000, '9', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00097', 'Dolken ?-8-10/4m', 15000, '9', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00098', 'Koral Beton 2/3', 200000, '5', 'Bahan');
INSERT INTO `pekerja_bahan` VALUES ('00099', 'Melamin', 70000, '2', 'Bahan');

-- ----------------------------
-- Table structure for proyek
-- ----------------------------
DROP TABLE IF EXISTS `proyek`;
CREATE TABLE `proyek`  (
  `pr_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pr_nama` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pr_luasbangunan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pr_luastanah` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pr_lokasi` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pr_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for satuan
-- ----------------------------
DROP TABLE IF EXISTS `satuan`;
CREATE TABLE `satuan`  (
  `sat_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `sat_nama` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `sat_kode` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sat_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tbl_admob
-- ----------------------------
DROP TABLE IF EXISTS `tbl_admob`;
CREATE TABLE `tbl_admob`  (
  `id_admob` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nama_aplikasi` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_unit` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `jenis_admob` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_admob`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tbl_error
-- ----------------------------
DROP TABLE IF EXISTS `tbl_error`;
CREATE TABLE `tbl_error`  (
  `tanggal` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `EMessage` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `CMessage` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `LokasiForm` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tbl_hargaonline
-- ----------------------------
DROP TABLE IF EXISTS `tbl_hargaonline`;
CREATE TABLE `tbl_hargaonline`  (
  `id_hargaonline` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_provinsi` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pkrjbhn_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `harga` double(255, 0) UNSIGNED NULL DEFAULT 0,
  PRIMARY KEY (`id_hargaonline`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_hargaonline
-- ----------------------------
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000001', 'P0001', '00001', 95000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000002', 'P0001', '00002', 110000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000003', 'P0001', '00003', 100000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000004', 'P0001', '00004', 100000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000005', 'P0001', '00005', 100000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000006', 'P0001', '00006', 109000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000007', 'P0001', '00007', 100000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000008', 'P0001', '00008', 109000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000009', 'P0001', '00009', 60000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000010', 'P0001', '00010', 109000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000012', 'P0001', '00012', 79000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000013', 'P0001', '00013', 106000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000018', 'P0001', '00018', 11000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000022', 'P0001', '00022', 1548870);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000100', 'P0002', '00001', 90000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000115', 'P0002', '00016', 17100);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000116', 'P0002', '00017', 20500);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000118', 'P0002', '00019', 244900);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000119', 'P0002', '00020', 572000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000120', 'P0002', '00021', 29800);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000122', 'P0002', '00023', 16300);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000124', 'P0002', '00025', 6100);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000126', 'P0002', '00027', 2700);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000130', 'P0002', '00031', 26000500);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000131', 'P0002', '00032', 26195500);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000132', 'P0002', '00033', 5678300);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000133', 'P0002', '00034', 169300);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000134', 'P0002', '00035', 15700);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000135', 'P0002', '00036', 15900);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000138', 'P0002', '00039', 18300);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000141', 'P0002', '00042', 45000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000142', 'P0002', '00043', 60000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000158', 'P0002', '00059', 16300);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000159', 'P0002', '00060', 500);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000162', 'P0002', '00063', 6500);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000164', 'P0002', '00065', 16500);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000166', 'P0002', '00067', 12200);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000168', 'P0002', '00069', 165900);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000169', 'P0002', '00070', 70400);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000170', 'P0002', '00071', 70400);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000171', 'P0002', '00072', 94500);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000172', 'P0002', '00073', 283500);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000175', 'P0002', '00076', 70000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000176', 'P0002', '00077', 50);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000178', 'P0002', '00079', 157800);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000181', 'P0002', '00082', 15000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000182', 'P0002', '00083', 45000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000183', 'P0002', '00084', 60000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000187', 'P0002', '00088', 6900);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000191', 'P0002', '00092', 15800);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000192', 'P0002', '00093', 17100);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000000397', 'P0005', '00001', 150000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000001387', 'P0015', '00001', 80000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000001684', 'P0018', '00001', 127000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000001685', 'P0018', '00002', 135000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000001686', 'P0018', '00003', 127000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000001687', 'P0018', '00004', 135000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000001688', 'P0018', '00005', 127000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000001689', 'P0018', '00006', 135000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000001690', 'P0018', '00007', 127000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000001691', 'P0018', '00008', 135000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000001692', 'P0018', '00009', 127000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000001693', 'P0018', '00010', 135000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000001694', 'P0018', '00011', 127000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000001695', 'P0018', '00012', 78000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000001696', 'P0018', '00013', 135000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000001697', 'P0018', '00014', 150000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000001882', 'P0020', '00001', 115000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000001883', 'P0020', '00002', 138000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000001884', 'P0020', '00003', 115000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000001885', 'P0020', '00004', 138);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000001886', 'P0020', '00005', 115000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000001887', 'P0020', '00006', 138000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000001888', 'P0020', '00007', 100000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000001889', 'P0020', '00008', 90000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000001890', 'P0020', '00009', 25000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000001891', 'P0020', '00010', 35000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000001893', 'P0020', '00012', 115000);
INSERT INTO `tbl_hargaonline` VALUES ('HO00000002282', 'P0024', '00005', NULL);

-- ----------------------------
-- Table structure for tbl_informasi
-- ----------------------------
DROP TABLE IF EXISTS `tbl_informasi`;
CREATE TABLE `tbl_informasi`  (
  `keterangan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `berita` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `link` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tbl_loguser
-- ----------------------------
DROP TABLE IF EXISTS `tbl_loguser`;
CREATE TABLE `tbl_loguser`  (
  `id_log` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `username` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `last_online` datetime(0) NULL DEFAULT NULL,
  `keterangan` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tgl_daftar` datetime(0) NULL DEFAULT NULL,
  `versionapps` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tbl_provinsi
-- ----------------------------
DROP TABLE IF EXISTS `tbl_provinsi`;
CREATE TABLE `tbl_provinsi`  (
  `id_provinsi` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nm_provinsi` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tbl_provinsi
-- ----------------------------
INSERT INTO `tbl_provinsi` VALUES ('P0001', 'Aceh');
INSERT INTO `tbl_provinsi` VALUES ('P0002', 'Sumatera Utara');
INSERT INTO `tbl_provinsi` VALUES ('P0003', 'Sumatera Barat');
INSERT INTO `tbl_provinsi` VALUES ('P0004', 'Riau');
INSERT INTO `tbl_provinsi` VALUES ('P0005', 'Kepulauan Riau');
INSERT INTO `tbl_provinsi` VALUES ('P0006', 'Jambi');
INSERT INTO `tbl_provinsi` VALUES ('P0007', 'Bengkulu');
INSERT INTO `tbl_provinsi` VALUES ('P0008', 'Sumatera Selatan');
INSERT INTO `tbl_provinsi` VALUES ('P0009', 'Kepulauan Bangka Belitung');
INSERT INTO `tbl_provinsi` VALUES ('P0010', 'Lampung');
INSERT INTO `tbl_provinsi` VALUES ('P0011', 'Banten');
INSERT INTO `tbl_provinsi` VALUES ('P0012', 'Jawa Barat');
INSERT INTO `tbl_provinsi` VALUES ('P0013', 'DKI Jakarta');
INSERT INTO `tbl_provinsi` VALUES ('P0014', 'Jawa Tengah');
INSERT INTO `tbl_provinsi` VALUES ('P0015', 'DI Yogyakarta');
INSERT INTO `tbl_provinsi` VALUES ('P0016', 'Jawa Timur');
INSERT INTO `tbl_provinsi` VALUES ('P0017', 'Bali');
INSERT INTO `tbl_provinsi` VALUES ('P0018', 'Nusa Tenggara Barat');
INSERT INTO `tbl_provinsi` VALUES ('P0019', 'Nusa Tenggara Timur');
INSERT INTO `tbl_provinsi` VALUES ('P0020', 'Kalimantan Utara');
INSERT INTO `tbl_provinsi` VALUES ('P0021', 'Kalimantan Barat');
INSERT INTO `tbl_provinsi` VALUES ('P0022', 'Kalimantan Tengah');
INSERT INTO `tbl_provinsi` VALUES ('P0023', 'Kalimantan Selatan');
INSERT INTO `tbl_provinsi` VALUES ('P0024', 'Kalimantan Timur');
INSERT INTO `tbl_provinsi` VALUES ('P0025', 'Gorontalo');
INSERT INTO `tbl_provinsi` VALUES ('P0026', 'Sulawesi Utara');
INSERT INTO `tbl_provinsi` VALUES ('P0027', 'Sulawesi Barat');
INSERT INTO `tbl_provinsi` VALUES ('P0028', 'Sulawesi Tengah');
INSERT INTO `tbl_provinsi` VALUES ('P0029', 'Sulawesi Selatan');
INSERT INTO `tbl_provinsi` VALUES ('P0030', 'Sulawesi Tenggara');
INSERT INTO `tbl_provinsi` VALUES ('P0031', 'Maluku Utara');
INSERT INTO `tbl_provinsi` VALUES ('P0032', 'Maluku');
INSERT INTO `tbl_provinsi` VALUES ('P0033', 'Papua Barat');
INSERT INTO `tbl_provinsi` VALUES ('P0034', 'Papua');

-- ----------------------------
-- Table structure for tbl_settingvalue
-- ----------------------------
DROP TABLE IF EXISTS `tbl_settingvalue`;
CREATE TABLE `tbl_settingvalue`  (
  `namaSetting` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `v_text1` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `v_text2` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `v_text3` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `v_number1` int(11) NULL DEFAULT NULL,
  `v_number2` int(11) NULL DEFAULT NULL,
  `v_number3` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`namaSetting`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tbl_tutorial
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tutorial`;
CREATE TABLE `tbl_tutorial`  (
  `id_tutorial` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nm_tutorial` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `status_tutorial` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `link_tutorial` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_tutorial`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tbl_user
-- ----------------------------
DROP TABLE IF EXISTS `tbl_user`;
CREATE TABLE `tbl_user`  (
  `id_user` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `username` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `level_user` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_user`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for template_pekerja_bahan
-- ----------------------------
DROP TABLE IF EXISTS `template_pekerja_bahan`;
CREATE TABLE `template_pekerja_bahan`  (
  `pkrjbhn_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `pkrjbhn_nama` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pkrjbhn_harga` double(255, 0) NULL DEFAULT NULL,
  `sat_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `pkrjbhn_jenis` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pkrjbhn_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
