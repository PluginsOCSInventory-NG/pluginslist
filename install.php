<?php
function plugin_version_pluginslist()
{
return array('name' => 'pluginslist',
'version' => '1.0',
'author'=> 'Stephane PAUTREL',
'license' => 'GPLv2',
'verMinOcs' => '2.2');
}

function plugin_init_pluginslist()
{
$object = new plugins;
$object -> add_cd_entry("pluginslist","other");

$object -> sql_query("CREATE TABLE IF NOT EXISTS `pluginslist` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `HARDWARE_ID` INT(11) NOT NULL,
  `SCRIPTNAME` VARCHAR(255) DEFAULT NULL,
  `LANGUAGE` VARCHAR(255) DEFAULT NULL,
  `DESCRIPTION` VARCHAR(255) DEFAULT NULL,
  `VERSION` VARCHAR(255) DEFAULT NULL,
  `CREADATE` VARCHAR(255) DEFAULT NULL,
  `MODIDATE` VARCHAR(255) DEFAULT NULL,
  `AUTHOR` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY  (`ID`,`HARDWARE_ID`)
) ENGINE=INNODB ;");

}

function plugin_delete_pluginslist()
{
$object = new plugins;
$object -> del_cd_entry("pluginslist");
$object -> sql_query("DROP TABLE `pluginslist`;");

}

?>
