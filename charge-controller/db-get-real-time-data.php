<?php
require 'php_include/py_exec_helper.php';

$command = 'cd '. getcwd() .' && python3 db-get-real-time-data.py  2>&1';

$fn_return = exec_json_py_cmd($command);
echo_return_exec_json_py_cmd($fn_return);