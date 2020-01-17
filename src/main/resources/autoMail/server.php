<?php
header("Content-type: text/html;charset=utf-8");
header("Access-Control-Allow-Origin: ".$_SERVER['SERVER_NAME']);
include "db_config.php";
require 'session.php';
Session::start();
@$type      = $_REQUEST['type'];
$os         = PHP_OS;
$clientInfo = $_SERVER['HTTP_USER_AGENT'];
@$ip        = $_SERVER["REMOTE_ADDR"];
@$time      = time();
$returnJson = array();
if (@$_REQUEST['info']) {
	foreach (@$_REQUEST['info'] as $key => $value) {
		if ($key == 'name') {
			@$name = $value;
		} else if ($key == 'birth') {
			@$birth = $value;
		} else if ($key == 'mobile') {
			@$mobile = $value;
		} else if ($key == 'mail') {
			@$mail = $value;
		} else if ($key == 'p') {
			@$p = $value;
		} else if ($key == 'pid') {
			@$pid = $value;
		} else if ($key == 'c') {
			@$city = $value;
		} else if ($key == 'cid') {
			@$cid = $value;
		} else if ($key == 'r') {
			@$region = $value;
		} else if ($key == 'rid') {
			@$rid = $value;
		} else if ($key == 'code') {
			@$code = $value;
		}
	}
}

function loadCode($mobile, $code) {
	require 'app_config.php';
	require_once ('SUBMAILAutoload.php');
	require_once ('messagesend.php');
	$content = '【小小运动馆】尊敬的客户，您的验证码为'.$code.'，请您在5分钟内填写，如非本人操作，请忽略本消息';
	$submail = new MESSAGEsend($message_configs);
	$submail->setTo($mobile);
	$submail->SetContent($content);
	$xsend = $submail->send();
	return $xsend;
}
function encode_json($str) {
	return urldecode(json_encode(url_encode($str)));
}
function url_encode($str) {
	if (is_array($str)) {
		foreach ($str as $key => $value) {
			$str[urlencode($key)] = url_encode($value);
		}
	} else {
		$str = urlencode($str);
	}
	return $str;
}
function getJson($url) {
	$curl = curl_init();
	curl_setopt($curl, CURLOPT_URL, $url);
	curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, FALSE);
	curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, FALSE);

	curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);//不输出
	$output = curl_exec($curl);
	curl_close($curl);
	return json_decode($output, true);
}
function send_post($url, $post_data) {
	$postdata = http_build_query($post_data);
	$options  = array(
		'http'     => array(
			'method'  => 'POST',
			'header'  => 'Content-type:application/x-www-form-urlencoded',
			'content' => $postdata,
			'timeout' => 15*60// 超时时间（单位:s）
		)
	);
	$context = stream_context_create($options);
	$result  = file_get_contents($url, false, $context);

	return $result;
}
try {
	$returnJson['success'] = true;
	$pdo->beginTransaction();
	switch ($type) {
		case 'loadCode':
			@$mobile        = $_REQUEST['mobile'];
			$checkMobileSql = "SELECT * FROM member WHERE mobile='$mobile'";
			$checkResult    = $pdo->query($checkMobileSql);
			$row            = $checkResult->fetch(PDO::FETCH_ASSOC);
			if ($row) {
				$returnJson['success'] = false;
				$returnJson['msg']     = '此手机号码已经使用';
			} else if (!$mobile) {
				$returnJson['success'] = false;
				$returnJson['msg']     = '请输入手机号码';
			} else {
				$randomCode = rand(10000, 99999);
				$loadCode   = loadCode($mobile, $randomCode);
				Session::set("$mobile", $randomCode, 60*5);//验证码有效期30分钟
				// $loadCode   = true;
				if ($loadCode['status'] == 'success') {
					$returnJson['success'] = true;
					$returnJson['msg']     = '验证码发送成功';
					$returnJson['code']    = $randomCode;
					$returnJson['secode']  = Session::get("$mobile");
				} else {
					$returnJson['success'] = false;
					$returnJson['msg']     = $loadCode;
					$returnJson['code']    = $randomCode;
				}
			}
			break;
		case 'loadplist0':
			@$linkId     = $_REQUEST['linkId'];
			$loadPSql    = "SELECT distinct p,pid FROM linkregion WHERE linkId='$linkId'";
			$loadPResult = $pdo->query($loadPSql);
			$data        = array();
			while ($row = $loadPResult->fetch(PDO::FETCH_ASSOC)) {
				$data[] = array(
					'id'      => $row['pid'],
					'cH_Name' => $row['p'],
				);
			}
			$returnJson['msg']  = $linkId;
			$returnJson['data'] = $data;
			break;
		case 'loadplist':
			$url  = "http://interface.thelittlegym.com.cn/api/getPro";
			$data = getJson($url);
			if ($data['code'] == 0) {
				$returnJson['data'] = $data['data'];
			} else {
				$returnJson['success'] = false;
				$returnJson['msg']     = $data['msg'];
			}
			break;
		case 'loadclist':
			$pid = $_REQUEST['pid'];
			$url = "http://interface.thelittlegym.com.cn/api/getCity/{$pid}";
		$data = getJson($url);
		if ($data['code'] == 0) {
			$returnJson['data'] = $data['data'];
		} else {
			$returnJson['success'] = false;
			$returnJson['msg']     = $data['msg'];
		}
		break;
		case 'loadclist0':
		$pid         = $_REQUEST['pid'];
		$linkId      = $_REQUEST['linkId'];
		$loadPSql    = "SELECT distinct c,cid FROM linkregion WHERE linkId='$linkId' and pid='$pid'";
		$loadPResult = $pdo->query($loadPSql);
		$data        = array();
		while ($row = $loadPResult->fetch(PDO::FETCH_ASSOC)) {
			$data[] = array(
				'id'      => $row['cid'],
				'cH_Name' => $row['c'],
			);
		}
		$returnJson['msg']  = $linkId;
		$returnJson['data'] = $data;
		break;
		case 'loadrlist':
		@$pid = $_REQUEST['pid'];
		$url  = "http://interface.thelittlegym.com.cn/api/getGym/{$pid}";
		$data = getJson($url);
		if ($data['code'] == 0) {
			$returnJson['data'] = $data['data'];
		} else {
			$returnJson['success'] = false;
			$returnJson['msg']     = $data['msg'];
		}
		break;
		case 'loadrlist0':
		@$pid        = $_REQUEST['pid'];
		@$linkId     = $_REQUEST['linkId'];
		$loadPSql    = "SELECT distinct r,rid FROM linkregion WHERE linkId='$linkId' and cid='$pid'";
		$loadPResult = $pdo->query($loadPSql);
		$data        = array();
		while ($row = $loadPResult->fetch(PDO::FETCH_ASSOC)) {
			$data[] = array(
				'id'      => $row['rid'],
				'cH_Name' => $row['r'],
			);
		}
		$returnJson['msg']  = $linkId;
		$returnJson['data'] = $data;
		break;
		case 'saveinfo':
		// $code        = $_REQUEST['code'];
		@$linkId     = $_REQUEST['linkId'];
		$checkSql    = "SELECT mobile FROM member WHERE mobile='$mobile'";
		$checkResult = $pdo->query($checkSql);
		$checkRow    = $checkResult->fetch(PDO::FETCH_ASSOC);
		$sessionCode = Session::get("$mobile");
		//!$sessionCode
		if ($checkRow) {
			$returnJson['success'] = false;
			$returnJson['msg']     = '当前手机号码已经提交过，请不要重复提交';
		} else if (!$sessionCode) {
			$returnJson['success']     = false;
			$returnJson['msg']         = '验证码已过期，请重新获取';
			$returnJson['sessionCode'] = $sessionCode;
			$returnJson['mobile']      = $mobile;
			//$sessionCode != $code
		} else if ($sessionCode != $code) {
			$returnJson['success'] = false;
			$returnJson['msg']     = '验证码输入错误';
		} else {
			$insertSql = "INSERT INTO member (linkId,name,birth,mobile,mail,p,pid,city,cid,region,rid,time)VALUES('$linkId','$name','$birth','$mobile','$mail','$p','$pid','$city','$cid','$region','$rid','$time')";
			$pdo->exec($insertSql);
			$url  = "http://interface.thelittlegym.com.cn/api/createIntro";
			$data = array(
				"Center"       => $rid,
				"city"         => $cid,
				"Province"     => $pid,
				"BabyName"     => $name,
				"BabyBrithday" => $birth,
				"Email"        => $mail,
				"ParentPhone"  => $mobile,
			);
			$result = send_post($url, $data);
			if (@$result['code'] == 0) {
				$returnJson['msg'] = $result['msg'];
			} else {
				$returnJson['success'] = false;
				$returnJson['msg']     = $result['msg'];
			}
		}
		break;
	}
	$pdo->commit();
} catch (PDOException $e) {
	$pdo->rollBack();
	$returnJson['success'] = false;
	$returnJson['msg']     = '操作不合法';
}

echo encode_json($returnJson);
?>