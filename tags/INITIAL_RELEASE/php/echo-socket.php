<?php

$address = '127.0.0.1';
$port = 12345;

if (false === ($sock = socket_create(AF_INET, SOCK_STREAM, SOL_TCP)))
{
   echo 'CREATE: '.socket_strerror(socket_last_error($sock))."\n";
}
if (false === ($ret = socket_bind($sock, $address, $port)))
{
   echo 'BIND: '.socket_strerror(socket_last_error($sock))."\n";
}
echo "Bound to $address:$port\n";
if (false === ($ret = socket_listen($sock, 1)))
{
   echo 'LISTEN: '.socket_strerror(socket_last_error($sock))."\n";
}
echo "Listening...\n";
while (true)
{
	if (false === ($s = socket_accept($sock)))
	{
		echo 'ACCEPT: '.socket_strerror(socket_last_error($sock))."\n";
		break;
	}
	usleep(50);
	$peer_addr = $peer_port = 'N/A';
	socket_getpeername($s, $peer_addr, $peer_port);
	echo "Incoming connection from $peer_addr:$peer_port\n";
	$messages = array();
	do	{
		$read = array($s);
		$write = array($s);
		$except = null;
		$n = socket_select($read, $write, $except, 0);
		if ($n === false)
		{
			echo 'SELECT: '.socket_strerror(socket_last_error($s))."\n";
			echo "Closing $peer_addr:$peer_port\n";
			socket_close($s);
		} 
		else if ($n <= 0) {
			continue;
		}
		// var_dump($read, $write);
		if (count($read))
		{
			echo "READ...\n";
			if (false === ($buf = socket_read($s, 2048)) || empty($buf))
			{
				echo 'READ: '.socket_strerror(socket_last_error($s))."\n";
				echo "Closing $peer_addr:$peer_port\n";
				socket_close($s);
				break;
			}
			echo $buf."\n";
			$messages[] = $buf;
		}
		if (count($write) && count($messages))
		{
			echo "ECHO...\n";
			if (false === ($buf = socket_write($s, array_pop($messages))))
			{
				echo 'WRITE: '.socket_strerror(socket_last_error($s))."\n";
				echo "Closing $peer_addr:$peer_port\n";
				socket_close($s);
				break;
			}
		}
		// echo $buf;
	} while (true);
}
socket_close($sock);

?>
