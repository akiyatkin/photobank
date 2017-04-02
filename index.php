<?php
use infrajs\ans\Ans;
use infrajs\path\Path;
use infrajs\load\Load;
use infrajs\rubrics\Rubrics;
use infrajs\access\Access;

/*
	Обязательный параметр src = ~directions/ или ~materials/ возвращает список галарей из указанной папки
*/

$ans = array();

$gdir = Ans::GET('src');
if (!Path::isNest('~', $gdir)) return Ans::err($ans, 'Фотогалереи не найдены');

$fdata = Load::srcinfo(preg_replace("/\/$/","",$gdir));

$ans['gallery'] = $fdata['name'];
$ans["dir"] = $gdir;
$ans["list"] = array();

$name = Ans::GET('name');

if ($name) {
	$ans['name'] = $name;
	$src = Rubrics::find($ans['dir'],$name, 'dir');
	$ans['src'] = $src;
	if (!$src) return Ans::err($ans,'Фотогалерея не найдена');

	$gal = Access::cache(__FILE__.'name', function ($src, $name) {
	
		if (Path::theme($src.'Описание.json')) {
			$gal = Load::loadJSON($src.'Описание.json');
		} else {
			$gal = array();
		}

		if (!$gal) $gal = array();	
		//if (!isset($gal['title'])) $gal['title'] = "Фотогалерея";

		
		
		$list = array();
		array_map(function ($file) use (&$list, $src) {
			if ($file{0} == '.') return;
			$fdata = Load::nameinfo($file);
			if (!in_array($fdata['ext'],array('jpg','jpeg','png','gif'))) return;
			
			$img = array();
			$img['img'] = Path::toutf($file);
			$img['id'] = Path::encode($img['img']);

			$galdata = Load::loadJSON($src.$fdata['name'].'.json');
			if ($galdata) {
				foreach ($galdata as $k => $v ) {
					$img[$k] = $galdata[$k];
				}
			}

			$list[] = $img;
		}, scandir(Path::theme($src)));
		
		$gal['list'] = $list;
		return $gal;
	}, array($src));
		
	if (empty($gal['title'])) $gal['title'] = "";
	if (empty($gal['lable'])) $gal['lable'] = "";

	if (empty($gal['content'])) $gal['content'] = "";
	$ans['title'] = $gal['title'];
	$ans['lable'] = $gal['lable'];
	$ans['content'] = $gal['content'];
	$ans['list'] = $gal['list'];
	
	$ans['gdata'] = Load::loadJSON('-photobank/?src='.$gdir);
	unset($ans['gdata']['list']);

} else {
	if (Path::theme($gdir.'Описание.json')) {
		$gal = Load::loadJSON($gdir.'Описание.json');
		foreach ($gal as $k => $v ) {
			$ans[$k] = $gal[$k];
		}
	}
	$list = Access::cache(__FILE__.'photobank', function ($gdir) {
		$list = array();
		$src = Path::theme($gdir);
		array_map(function ($file) use (&$list, $src) {
			if ($file{0} == '.') return;
			if (is_file($src.$file)) return;

			$dir = $src.$file.'/';
			if ( !is_file($dir.Path::tofs('Описание.json')) ) {
				$gal = array();
			} else {
				$gal = Load::loadJSON($dir.'Описание.json');
			}

			$file = Path::toutf($file);
			$fdata = Load::nameinfo($file);

			$gal['name'] = $fdata['name'];
			$gal['folder'] = $fdata['file'];

			if(empty($gal['content'])) $gal['content'] = "";

			$count = 0;
			array_map(function ($file) use (&$count, $dir) {
				if ($file{0} == '.') return;
				$fdata = Load::nameinfo($file);
				if (!in_array($fdata['ext'],array('jpg','jpeg','png','gif'))) return;
				$count++;
			}, scandir($dir));

			$gal['count'] = $count;
			$list[] = $gal;

		}, scandir($src));

		return $list;
	}, array($gdir));
	$ans['list'] = $list;
}


return Ans::ret($ans);