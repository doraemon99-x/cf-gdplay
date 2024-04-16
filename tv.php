<?php
$url = $_GET['file'];
$filename = basename($_SERVER['REQUEST_URI'], '?' . $_SERVER['QUERY_STRING']);
$urlpath = str_replace($filename, '', $url);

$header = [
    'User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36',
    'Referrer: https://visionplus.id/'
    ];

$ch = curl_init($url);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
$anu  = curl_exec($ch);
curl_close($ch);
header('content-type: application/dash+xml');

$anu = str_replace('initialization="', "initialization=\"https://gvp.tipiku.site/tv.php?file={$urlpath}", $anu);
$anu = str_replace('media="', "media=\"https://gvp.tipiku.site/tv.php?file={$urlpath}", $anu); 
echo $anu;
?>
