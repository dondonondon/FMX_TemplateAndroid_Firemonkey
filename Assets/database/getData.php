<?php
    $koneksi=@mysqli_connect("localhost","id11465695_dondon","dondon270994");
	$database=mysqli_select_db($koneksi,"id11465695_dondon");
	
	//https://kucobatukbertahan.000webhostapp.com/API/getData.php?key=hUIY&act=getHargaOnline
	$respon = array(); 
	
	$keyAkses = 'hUIY';
	
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
		}
	} else{
		$respon[] = array('result' => 'null');
	}
?>