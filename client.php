<?php

if( !isset($_SERVER["HTTP_REFERER"]) || empty( $_SERVER["HTTP_REFERER"] ) )
{
$agent    = $_SERVER['HTTP_USER_AGENT'];
$ip       = $_SERVER['REMOTE_ADDR'];
$uri      = $_SERVER["REQUEST_URI"];
$host     =  $_SERVER["HTTP_HOST"];

$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, "http://daryl.2bu.ro/page/create");
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_POST, true);

$data = array(
    'page[ip]' => $ip,
    'page[host]' => $host,
    'page[agent]' => $agent,
    'page[uri]' => $uri
);

curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
$output = curl_exec($ch);
$info = curl_getinfo($ch);
curl_close($ch);

}

?>