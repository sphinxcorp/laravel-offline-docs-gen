#!/usr/bin/env php
<?php

if(!defined('DS')){
	define('DS', DIRECTORY_SEPARATOR);
}

define('BUILD_DIR', __DIR__ . DS .'build');
define('DOCS_DIR', __DIR__ . DS .'docs');

$file = $argv[1];

$input = DOCS_DIR . DS . $file;
$output = BUILD_DIR . DS . $file;

if($file == 'documentation.md'){
	$content = file_get_contents($input);
	$content = preg_replace('#/docs/#','#',$content) . PHP_EOL;
	file_put_contents($output, $content);
}
else {
	$base_anchor = basename($file,'.md');
	$fin = fopen($input,'r');
	$content = "";
	if($fin) {
		$line_counter = 1;
		$prev_anchor = NULL;
		while ($line = fgets($fin)) {
			if ($line_counter == 1){
				$content .= str_replace(array("\n","\r"),'',$line) . " {#" . $base_anchor.  "}" . PHP_EOL;
			}
			else {
				if (preg_match('#<a name="([^"]+)"></a>#',$line, $matches)){
					$prev_anchor = "{$base_anchor}-{$matches[1]}";
				}
				else {
					if(!empty($prev_anchor)){
						$content .= str_replace(array("\n","\r"),'',$line) . " {#" . $prev_anchor.  "}" . PHP_EOL;
						$prev_anchor = NULL;
					}
					else {
						$line = preg_replace_callback('#\[([^\]]+)\]\(([^\)]+)\)#',function($matches) use($base_anchor){
							$anchor_text = $matches[1];
							$link = $matches[2];
							if(substr($link,0,1)=='#'){
								$link = "#{$base_anchor}-" . substr($link,1);
							}
							else if(preg_match('#^/docs/#',$link)){
								$link = '#' . str_replace(array('/docs/','#'),array('','-'), $link);
							}
							return "[$anchor_text]({$link})";
						}, $line);
						$content .= $line;
					}
				}
			}
			$line_counter++;
		}
		file_put_contents($output,$content);
	}
}
