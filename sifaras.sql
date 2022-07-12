-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 12, 2022 at 08:35 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sifaras`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `id_user` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(225) NOT NULL,
  `email` varchar(225) NOT NULL,
  `nama_lengkap` varchar(225) NOT NULL,
  `jenis_kelamin` enum('laki-laki','perempuan') NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `log_datetime` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`id_user`, `username`, `password`, `email`, `nama_lengkap`, `jenis_kelamin`, `tanggal_lahir`, `log_datetime`) VALUES
(1, 'dani', '123', 'dani@yahooo.com', ' dani', 'laki-laki', '2022-06-30', '2022-06-30'),
(5, 'aji', '123', 'aji@bp2ip.com', ' aji', 'laki-laki', '2022-06-30', '2022-06-30'),
(6, 'sali', '123', 'sal@kk.com', ' saliani', 'perempuan', '2022-06-30', '2022-06-30'),
(8, 'tesa', '123', 'tes@g.co', ' tesa Sihara', 'perempuan', '2022-06-30', '2022-06-30'),
(11, 'danang', '123', 'coba@gmail.com', 'danang', 'laki-laki', '2022-06-30', '2022-06-30'),
(12, 'juswan', '123', 'cust@gmal.com', 'juswan', 'laki-laki', '2022-06-30', '2022-06-30'),
(15, 'badru', '123', 'baru@gmail.com', 'badruzaman', 'laki-laki', '2022-06-30', '2022-06-30'),
(16, 'budi', '123', 'ok@gmail.com', 'budiana', 'laki-laki', '2022-06-30', '2022-06-30');

-- --------------------------------------------------------

--
-- Table structure for table `daftar_berobat`
--

CREATE TABLE `daftar_berobat` (
  `id_daftar` int(10) NOT NULL,
  `tanggal` date NOT NULL,
  `id_pasien` int(10) NOT NULL,
  `id_poli` int(10) NOT NULL,
  `id_dokter` int(10) NOT NULL,
  `no_antrian` int(10) NOT NULL,
  `keluhan` varchar(255) NOT NULL,
  `diagnosa` varchar(50) NOT NULL,
  `obat` varchar(50) NOT NULL,
  `pemeriksaan` varchar(50) NOT NULL,
  `tindakan` varchar(30) NOT NULL,
  `status` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `daftar_berobat`
--

INSERT INTO `daftar_berobat` (`id_daftar`, `tanggal`, `id_pasien`, `id_poli`, `id_dokter`, `no_antrian`, `keluhan`, `diagnosa`, `obat`, `pemeriksaan`, `tindakan`, `status`) VALUES
(1, '2022-07-11', 5, 1, 1, 2, 'gigi [Lemas, Pilek] mencret', 'flu', 'panadol', '[Pilek]', '[Pemberian Obat]', 'dokter'),
(91, '2022-07-11', 1, 1, 1, 1, 'demam', 'kurn mnum', 'vitamin', '[Lemas]', '[Pemberian Obat]', ''),
(92, '2022-07-11', 5, 1, 1, 2, 'gigi [Lemas, Pilek] mencret', 'flu', 'panadol', '[Pilek]', '[Pemberian Obat]', 'dokter'),
(93, '2022-07-11', 1, 2, 14, 1, '[Lemas, Pilek] mencret', '', '', '', '', 'dokter');

-- --------------------------------------------------------

--
-- Table structure for table `dokter`
--

CREATE TABLE `dokter` (
  `id_user` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `status` int(11) NOT NULL,
  `nama_lengkap` varchar(100) NOT NULL,
  `jenis_kelamin` enum('laki-laki','perempuan') NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `id_jabatan` int(11) NOT NULL,
  `tanggal_gabung` date NOT NULL,
  `alamat` varchar(100) NOT NULL,
  `log_datetime` datetime NOT NULL DEFAULT current_timestamp(),
  `id_poli` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dokter`
--

INSERT INTO `dokter` (`id_user`, `username`, `password`, `email`, `status`, `nama_lengkap`, `jenis_kelamin`, `tanggal_lahir`, `id_jabatan`, `tanggal_gabung`, `alamat`, `log_datetime`, `id_poli`) VALUES
(1, 'azis', '123', '', 1, 'azis', 'laki-laki', '2022-07-10', 3, '2021-01-01', '', '2022-03-26 23:19:30', 1),
(2, 'maman', '123', '', 2, 'maman', 'laki-laki', '2022-07-05', 5, '2022-02-02', '', '2022-03-26 23:19:30', 5),
(10, 'prayoga', '123', 'prayoga@gmail.com', 3, 'prayoga', 'laki-laki', '2022-06-01', 6, '2022-06-17', 'letnan', '2022-06-17 20:56:19', 6),
(13, 'adi', '123', 'adi@bp2ip.com', 0, 'adi', 'laki-laki', '2022-06-30', 5, '2022-06-30', 'jakarta', '2022-06-30 15:13:59', 5),
(14, 'ok', '123', 'agus@gmail.com', 0, 'agus', 'laki-laki', '2022-06-30', 2, '0000-00-00', 'jantun', '2022-06-30 20:44:31', 2),
(15, 'wati', '123', 'tes@ky.com', 0, 'wati', 'perempuan', '2022-06-30', 2, '0000-00-00', 'ya', '2022-06-30 20:46:27', 2),
(19, 'putra', '123', 'port@gmail.com', 0, 'putra', 'laki-laki', '2022-06-30', 6, '0000-00-00', 'port', '2022-06-30 23:01:43', 6);

-- --------------------------------------------------------

--
-- Table structure for table `ijin_cuti`
--

CREATE TABLE `ijin_cuti` (
  `id_ijin` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `jenis_ijin` varchar(50) NOT NULL,
  `tanggal_awal` date NOT NULL,
  `tanggal_akhir` date NOT NULL,
  `alasan` varchar(255) NOT NULL,
  `persetujuan` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ijin_cuti`
--

INSERT INTO `ijin_cuti` (`id_ijin`, `id_user`, `jenis_ijin`, `tanggal_awal`, `tanggal_akhir`, `alasan`, `persetujuan`) VALUES
(1, 1, 'Cuti', '2022-06-10', '2022-06-13', 'keperluan keluarga', 2),
(2, 2, 'Ijin', '2022-06-07', '2022-06-09', 'mengantar anak', 1),
(3, 10, 'Cuti', '2022-05-11', '2022-05-19', 'pulang kampung', 0),
(5, 2, 'Ijin', '2022-06-28', '2022-06-28', 'mengantar anak', 2),
(6, 2, 'Sakit', '2022-06-28', '2022-07-01', 'mencret', 1),
(7, 1, 'Sakit', '2022-06-29', '2022-06-30', 'diare dan demam', 0),
(8, 1, 'Cuti', '2022-06-29', '2022-08-03', 'Liburan', 0),
(9, 1, 'Sakit', '2022-06-29', '2022-06-29', 'sakit', 1);

-- --------------------------------------------------------

--
-- Table structure for table `jabatan`
--

CREATE TABLE `jabatan` (
  `id_jabatan` int(11) NOT NULL,
  `nama_jabatan` varchar(60) NOT NULL,
  `log_datetime` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `jabatan`
--

INSERT INTO `jabatan` (`id_jabatan`, `nama_jabatan`, `log_datetime`) VALUES
(1, 'Mata', '2022-06-30 17:16:31'),
(2, 'THT', '2022-06-30 17:16:45'),
(3, 'Jantung', '2022-06-30 17:17:00'),
(5, 'Paru', '2022-06-30 17:17:11'),
(6, 'Umum', '2022-06-30 17:18:08');

-- --------------------------------------------------------

--
-- Table structure for table `log_absen`
--

CREATE TABLE `log_absen` (
  `id_absen` int(11) NOT NULL,
  `id_karyawan` int(11) NOT NULL,
  `date` date NOT NULL,
  `jam_masuk` time NOT NULL,
  `jam_pulang` time NOT NULL,
  `Keterangan` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `log_absen`
--

INSERT INTO `log_absen` (`id_absen`, `id_karyawan`, `date`, `jam_masuk`, `jam_pulang`, `Keterangan`) VALUES
(45, 1, '2022-05-25', '00:00:00', '03:27:56', 'Cuti'),
(46, 2, '2022-05-25', '00:00:00', '03:44:55', 'Cuti'),
(48, 1, '2022-05-26', '00:00:00', '20:34:29', 'Absen'),
(49, 2, '2022-05-26', '20:21:06', '20:23:19', 'Cuti'),
(50, 1, '2022-06-11', '09:04:21', '00:00:00', 'Absen'),
(51, 1, '2022-06-11', '09:04:21', '00:00:00', 'Absen'),
(52, 1, '2022-06-12', '08:50:49', '17:46:47', 'Absen'),
(53, 2, '2022-06-12', '00:00:00', '15:01:55', 'Absen'),
(54, 1, '2022-06-17', '00:00:00', '21:02:31', 'Absen'),
(55, 10, '2022-06-17', '00:00:00', '20:56:39', 'Absen'),
(56, 2, '2022-06-17', '00:00:00', '21:02:08', 'Absen'),
(57, 1, '2022-06-18', '09:45:21', '00:00:00', 'Absen'),
(58, 2, '2022-06-28', '00:00:00', '21:13:35', 'Sakit'),
(195, 1, '2022-06-29', '06:20:32', '21:07:16', 'Absen'),
(196, 2, '2022-06-29', '00:00:00', '00:00:00', 'Sakit'),
(197, 2, '2022-06-30', '00:00:00', '00:00:00', 'Sakit'),
(198, 2, '2022-07-01', '00:00:00', '00:00:00', 'Sakit');

-- --------------------------------------------------------

--
-- Table structure for table `poli`
--

CREATE TABLE `poli` (
  `id_poli` int(11) NOT NULL,
  `nama_poli` varchar(60) NOT NULL,
  `log_datetime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `poli`
--

INSERT INTO `poli` (`id_poli`, `nama_poli`, `log_datetime`) VALUES
(1, 'Umum', '2022-06-30 18:10:23'),
(2, 'Anak', '2022-06-30 22:18:34'),
(3, 'Bedah', '2022-06-30 22:19:18'),
(4, 'Jantung', '2022-06-30 22:19:51'),
(5, 'Penyakit dalam', '2022-06-30 22:20:01'),
(6, 'Penyakit Kulit', '2022-06-30 22:20:24'),
(7, 'Paru', '2022-06-30 22:20:32'),
(8, 'mata', '2022-06-30 22:20:48'),
(9, 'THT', '2022-06-30 22:20:59');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id_user` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `status` int(11) NOT NULL,
  `nama_lengkap` varchar(100) NOT NULL,
  `jenis_kelamin` enum('laki-laki','perempuan') NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `id_jabatan` int(11) NOT NULL,
  `tanggal_gabung` date NOT NULL,
  `alamat` varchar(100) NOT NULL,
  `log_datetime` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `username`, `password`, `email`, `status`, `nama_lengkap`, `jenis_kelamin`, `tanggal_lahir`, `id_jabatan`, `tanggal_gabung`, `alamat`, `log_datetime`) VALUES
(1, 'hamdani', 'admin', 'ok', 1, 'Hamdani2', 'laki-laki', '2000-02-02', 1, '2021-01-01', 'jakarta', '2022-03-26 23:19:30'),
(2, 'riyan', 'karyawan', 'ok', 2, 'Riyan', 'laki-laki', '2001-01-01', 20, '2022-02-02', 'tangerang', '2022-03-26 23:19:30');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id_user`);

--
-- Indexes for table `daftar_berobat`
--
ALTER TABLE `daftar_berobat`
  ADD PRIMARY KEY (`id_daftar`);

--
-- Indexes for table `dokter`
--
ALTER TABLE `dokter`
  ADD PRIMARY KEY (`id_user`);

--
-- Indexes for table `ijin_cuti`
--
ALTER TABLE `ijin_cuti`
  ADD PRIMARY KEY (`id_ijin`);

--
-- Indexes for table `jabatan`
--
ALTER TABLE `jabatan`
  ADD PRIMARY KEY (`id_jabatan`);

--
-- Indexes for table `log_absen`
--
ALTER TABLE `log_absen`
  ADD PRIMARY KEY (`id_absen`);

--
-- Indexes for table `poli`
--
ALTER TABLE `poli`
  ADD PRIMARY KEY (`id_poli`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `daftar_berobat`
--
ALTER TABLE `daftar_berobat`
  MODIFY `id_daftar` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT for table `dokter`
--
ALTER TABLE `dokter`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `ijin_cuti`
--
ALTER TABLE `ijin_cuti`
  MODIFY `id_ijin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `jabatan`
--
ALTER TABLE `jabatan`
  MODIFY `id_jabatan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `log_absen`
--
ALTER TABLE `log_absen`
  MODIFY `id_absen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=199;

--
-- AUTO_INCREMENT for table `poli`
--
ALTER TABLE `poli`
  MODIFY `id_poli` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
