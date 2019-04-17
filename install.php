<?php

/**
 * This function is called on installation and is used to create database schema for the plugin
 */
function extension_install_pluginslist()
{
    $commonObject = new ExtensionCommon;

    $commonObject -> sqlQuery("CREATE TABLE IF NOT EXISTS `pluginslist` (
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

/**
 * This function is called on removal and is used to destroy database schema for the plugin
 */
function extension_delete_pluginslist()
{
    $commonObject = new ExtensionCommon;
    $commonObject -> sqlQuery("DROP TABLE `pluginslist`;");
}

/**
 * This function is called on plugin upgrade
 */
function extension_upgrade_pluginslist()
{

}
