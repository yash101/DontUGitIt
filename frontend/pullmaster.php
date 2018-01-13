<?php

// This script just pulls all the fresh changes from GitHub.

echo(shell_exec("git checkout origin master"));
echo(shell_exec("git pull"));

?>
