<?php

echo serialize(
		'$_GET = '.var_export($_GET, true)."\n"
	. 	'$_POST = '.var_export($_POST, true)
);

?>
