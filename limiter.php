#!/usr/bin/php
<?php
require_once(__DIR__."/conn.php"); //mysql connection. initiate by yourself without this require

$log=file_get_contents("/var/log/v2ray/access.log");
$lines=explode("\n",$log);
$ips=array();
foreach($lines as $line)
{
	$d=explode(" ",trim($line));
	if(count($d)==6)
	{
		preg_match("#[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+#",$d[2],$ip);
		$ip=$ip[0];
		preg_match("#email:([0-9]+)@#",$d[5],$uid);
		if(isset($uid[1]))
		{
			$uid=$uid[1];
			#echo "uid $uid, ip $ip\n";
			if(!isset($ips[$uid]) || !in_array($ip,$ips[$uid]))
			$ips[$uid][]=$ip;
		}
	}
}

foreach($ips as $uid => $uips)
{
	echo "uid $uid: ".count($uips)." ips\n";
	if(count($uips)>3)
	{
		echo "banning $uid!\n";
		mysql_query("update users set active=0 where id=".$uid." limit 1") or die(mysql_error());
	}
}

shell_exec("echo > /var/log/v2ray/access.log");
