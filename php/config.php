<?php
if (!defined('STATUSNET') && !defined('LACONICA')) { exit(1); }

$config['site']['name'] = 'Openshift Statusnet';

$config['site']['server'] = $_ENV['OPENSHIFT_APP_DNS'];
$config['site']['path'] = false; 

$config['db']['database'] = 'mysqli://' . $_ENV['OPENSHIFT_MYSQL_DB_USERNAME'] . ':' . $_ENV['OPENSHIFT_MYSQL_DB_PASSWORD'] . '@' . $_ENV['OPENSHIFT_MYSQL_DB_HOST'] . ':' . $_ENV['OPENSHIFT_MYSQL_DB_PORT'] . '/' . $_ENV['OPENSHIFT_APP_NAME'];

$config['db']['type'] = 'mysql';

$config['site']['profile'] = 'private';

$config['site']['fancy'] = true;
