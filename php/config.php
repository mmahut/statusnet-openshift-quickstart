<?php
if (!defined('STATUSNET') && !defined('LACONICA')) { exit(1); }

$config['site']['name'] = 'Openshift Statusnet';

$config['site']['server'] = $_ENV['OPENSHIFT_APP_DNS'];
$config['site']['path'] = false; 

$config['db']['database'] = 'mysqli://' . $_ENV['OPENSHIFT_MYSQL_DB_USERNAME'] . ':' . $_ENV['OPENSHIFT_MYSQL_DB_PASSWORD'] . '@' . $_ENV['OPENSHIFT_MYSQL_DB_HOST'] . ':' . $_ENV['OPENSHIFT_MYSQL_DB_PORT'] . '/statusnet';

$config['db']['type'] = 'mysql';

$config['site']['profile'] = 'private';

$config['site']['fancy'] = true;

$config['site']['logfile'] = $_ENV['OPENSHIFT_PHP_LOG_DIR'] . '/statusnet.log';

$config['attachments']['dir'] = $_ENV['OPENSHIFT_DATA_DIR'] . '/attachments';

$config['avatar']['path'] = $_ENV['OPENSHIFT_DATA_DIR'] . '/avatar';
