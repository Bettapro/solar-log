<?php

function exec_json_py_cmd($command){
	$cmd_return = shell_exec($command);

	$brace_pos = strpos($cmd_return, '{');
	if($brace_pos !== FALSE){
		$json_response = json_decode(substr($cmd_return, $brace_pos));
		if(json_last_error() == JSON_ERROR_NONE){
			return  [TRUE, $json_response, $cmd_return];
		}
	}
	return [FALSE, NULL, $cmd_return];
}

function echo_return_exec_json_py_cmd(&$fn_return){
	if($fn_return[0]){
		header('Content-Type: application/json');
		echo(json_encode($fn_return[1]));
	}
	else{
		header('Content-Type: application/json');
		http_response_code(500);
		echo(json_encode([
			'py_return' => $fn_return[2]
		]));
	}
}
