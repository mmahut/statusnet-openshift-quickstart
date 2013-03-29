Status on OpenShift
===================

This quickstart will help you get Statusnet up and running on Openwhift.

Running on OpenShift
---------------------

1) Create an account at http://openshift.redhat.com/

2) Create a php-5.3 application (you can call your application whatever you want)

	rhc app create -a statusnet -t php-5.3

3) Add a MySQL cartridge to your gear

	rhc cartridge add -a statusnet -c mysql-5.1

4) Add this upstream git repository

	cd statusnet
	git remote add upstream -m master git://github.com/mmahut/statusnet-quickstart.git
	git pull -s recursive -X theirs upstream master
    
5) Then push the repo to your application

	git push

6) Login into your application URL with the login details below and change them.

	Login: Admin
	Password: OpenShiftAdmin
