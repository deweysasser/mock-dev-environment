KEY=~/.ssh/id_rsa
JENKINS=192.168.100.10:8081


run: build docker-compose.override.yml
	docker-compose up -d
#	sleep 5 && (cd gitolite-admin; git push -f)

build: jenkins/ssh/id_rsa
	docker-compose build

jenkins/ssh/id_rsa:
	mkdir -p `dirname $@`
	ssh-keygen -P ''  -f $@ -C "Jenkins"

docker-compose.override.yml: docker-compose.override.template
	cp $< $@

plugins:
	curl "http://$(JENKINS)/pluginManager/api/xml?depth=1&xpath=/*/*/shortName|/*/*/version&wrapper=plugins" | sed -f plugins.sed | sort > jenkins/plugins.txt

