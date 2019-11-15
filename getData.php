<?php
    $koneksi=@mysqli_connect("localhost","id11465695_dondon","dondon270994");
	$database=mysqli_select_db($koneksi,"id11465695_dondon");
	
	//https://www.blangkon.net/_loader_json/WebService/Emas/API/getData.php?key=hUIY!*DH!Ey928HD892H89@Y79@&act=getSelisih
	
	//https://kucobatukbertahan.000webhostapp.com/API/getData.php?key=hUIY!*DH!Ey928HD892H89@Y79@&act=getHargaOnline
	$respon = array(); 
	
	$keyAkses = 'hUIY!*DH!Ey928HD892H89@Y79@';
	
	$key = $_GET['key'];
	$act = $_GET['act'];

	$tg = date(' l, d M Y H:i:s');
	$tgl = date('Y-m-d H:i:s', strtotime('+7 hours',strtotime($tg)));
	
	if ($key == $keyAkses){
		$index = 0;
        if ($act =='login'){ //".$list1['id_region']."
            $username = $_GET['username'];
            $password = $_GET['password'];
            
			$qry = mysqli_query($koneksi,"SELECT * FROM tbl_user WHERE username = '".$username."'");
			if (mysqli_num_rows($qry) > 0){
                $qry = mysqli_query($koneksi,"SELECT * FROM tbl_user WHERE password = '".$password."'");
                if (mysqli_num_rows($qry) > 0){
                    $list = mysqli_fetch_array($qry);

                    $respon[$index]['result'] = "USERNAME DITEMUKAN";
                    $respon[$index]['level'] = $list['level_user'];
                } else {
                    $respon[$index]['result'] = "PASSWORD SALAH";
                }
			} else {
                $respon[$index]['result'] = "USERNAME TIDAK DITEMUKAN";
			}
			echo json_encode($respon,JSON_PRETTY_PRINT);
		} elseif ($act=='register'){
			$username = $_GET['username'];
			$password = $_GET['password'];
			$email = $_GET['email'];
            $leveluser = $_GET['leveluser'];
            
			$qry = mysqli_query($koneksi,"SELECT * FROM tbl_user WHERE username = '".$username."'");
			if (mysqli_num_rows($qry) > 0){
				$respon[$index]['result'] = "USERNAME DIGUNAKAN";
			} else {
				$query = mysqli_query($koneksi, "SELECT * FROM tbl_user ORDER BY id_user DESC LIMIT 1");

				$id = mysqli_fetch_array($query)[0];
				$idnew1 = substr($id, 2);
				$idnew2 = $idnew1 + 1000000001;
				$idfix = substr($idnew2, 1);
				try {	
					mysqli_autocommit($koneksi, FALSE); 

					$qry = mysqli_query($koneksi,"INSERT INTO tbl_user (id_user, username, password, email, level_user) VALUES ('".$idfix."','".$username."','".$password."','".$email."','".$leveluser."')");	
					$qry = mysqli_query($koneksi,"INSERT INTO tbl_loguser (id_log, username, last_online, keterangan, tgl_daftar) VALUES('".$idfix."','".$username."','".$tgl."','Register','".$tgl."')");	

					mysqli_commit($koneksi);

					$respon[$index]['result'] = "SUKSES DAFTAR";
				} catch (Exception $e) {
					$respon[$index]['result'] = "GAGAL DAFTAR";
					mysqli_rollback($koneksi);
				}
			}
			echo json_encode($respon,JSON_PRETTY_PRINT);
		} elseif ($act=='getTutorial'){
			$query = mysqli_query($koneksi, 
				"SELECT COUNT(status_tutorial) as total FROM tbl_tutorial WHERE status_tutorial = 'Y'");

			$tot = mysqli_fetch_array($query)[0];
			$respon[$index]['result'] = $tot;
			echo json_encode($respon,JSON_PRETTY_PRINT);
		} elseif ($act=='sendError'){
			$EMessage = $_GET['EMessage'];
			$CMessage = $_GET['CMessage'];
			$lokasiF = $_GET['lokasiF'];
			try {	
				mysqli_autocommit($koneksi, FALSE); 

				$qry = mysqli_query($koneksi,
					"INSERT INTO tbl_error (tanggal, EMessage, CMessage, LokasiForm) VALUES('".$tgl."','".$EMessage."','".$CMessage."','".$lokasiF."')");

				mysqli_commit($koneksi);

				$respon[$index]['result'] = "SUKSES DAFTAR";
			} catch (Exception $e) {
				$respon[$index]['result'] = "GAGAL DAFTAR";
				mysqli_rollback($koneksi);
			}
			echo json_encode($respon,JSON_PRETTY_PRINT);
		} elseif ($act=='getBahan'){
			$query = mysqli_query($koneksi, 
				"SELECT p.id_provinsi, p.nm_provinsi, Count(ho.id_hargaonline) as TotData FROM tbl_hargaOnline ho 
				LEFT JOIN tbl_provinsi p ON p.id_provinsi = ho.id_provinsi 
				WHERE ho.harga NOT IN (0) 
				GROUP BY p.id_provinsi 
				ORDER BY p.nm_provinsi ASC");
			while ($list = mysqli_fetch_array($query)) {
				$respon[$index]['id_provinsi'] = $list['id_provinsi'];
				$respon[$index]['nm_provinsi'] = $list['nm_provinsi'];
				$respon[$index]['TotData'] = $list['TotData'];

				$index++;
			}
			echo json_encode($respon,JSON_PRETTY_PRINT);
		} elseif ($act=='getDetailBahan'){
			$provinsi = $_GET['provinsi'];

			$query = mysqli_query($koneksi, 
				"SELECT pb.pkrjbhn_id, sat.sat_id, pr.nm_provinsi, pb.pkrjbhn_nama, ho.harga, pb.pkrjbhn_jenis
				FROM tbl_hargaOnline ho 
				LEFT JOIN tbl_provinsi pr ON pr.id_provinsi = ho.id_provinsi
				LEFT JOIN pekerja_bahan pb ON pb.pkrjbhn_id = ho.pkrjbhn_id
				LEFT JOIN satuan sat ON sat.sat_id = pb.sat_id
				WHERE pr.id_provinsi = '".$provinsi."'
				AND ho.harga NOT IN (0)");
			while ($list = mysqli_fetch_array($query)) {
				$respon[$index]['pkrjbhn_nama'] = $list['pkrjbhn_nama'];
				$respon[$index]['harga'] = $list['harga'];
				$respon[$index]['stat'] = '0';
				$respon[$index]['pkrjbhn_id'] = $list['pkrjbhn_id'];
				$respon[$index]['pkrjbhn_jenis'] = $list['pkrjbhn_jenis'];
				$respon[$index]['sat_id'] = $list['sat_id'];

				$index++;
			}
			echo json_encode($respon,JSON_PRETTY_PRINT);
		} elseif ($act=='getListTutorial'){
			$query = mysqli_query($koneksi, 
				"SELECT * FROM tbl_tutorial WHERE status_tutorial = 'Y'");
			while ($list = mysqli_fetch_array($query)) {
				$respon[$index]['nm_tutorial'] = $list['nm_tutorial'];
				$respon[$index]['link_tutorial'] = $list['link_tutorial'];

				$index++;
			}
			echo json_encode($respon,JSON_PRETTY_PRINT);
		} elseif ($act=='getIDAds'){
			$query = mysqli_query($koneksi, 
				"SELECT * FROM tbl_admob WHERE nama_aplikasi = 'RAB'");
			while ($list = mysqli_fetch_array($query)) {
				$respon[$index]['id_unit'] = $list['id_unit'];
				$respon[$index]['jenis_admob'] = $list['jenis_admob'];
				$respon[$index]['maxAds'] = 30;

				$index++;
			}
			echo json_encode($respon,JSON_PRETTY_PRINT);
		} elseif ($act=='getHargaOnline'){
			$query = mysqli_query($koneksi, 
				"SELECT * FROM tbl_hargaonline WHERE harga <> 0");
			while ($list = mysqli_fetch_array($query)) {
				$respon[$index]['id_hargaonline'] = $list['id_hargaonline'];
				$respon[$index]['harga'] = $list['harga'];

				$index++;
			}
			echo json_encode($respon,JSON_PRETTY_PRINT);
		}
	} else{
		$respon[] = array('result' => 'null');
	}
?>