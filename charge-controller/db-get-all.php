<?php
require 'php_include/py_exec_helper.php';

$command = 'cd '. getcwd() .' && python3 db-get-all.py  2>&1';

$fn_return = exec_json_py_cmd($command);
echo_return_exec_json_py_cmd($fn_return);