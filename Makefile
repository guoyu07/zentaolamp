all:help
zentao:prepare zentaorelease
xirang:prepare xirangrelease
common:prepare commonrelease
help:
	@echo "make lampp source=xxx product=zentao|xirang to build the common lampp package."
	@echo make zentao to make a zentao release.
	@echo make xirang to make a xirang release.
	@echo make common to make a common release.
	@echo make lamppclean to clean lampp directory.
	@echo make releaseclean to clean zentao or xirang directory.
lampp:
	./buildlampp.sh $(source) $(product)
lamppclean:
	rm -fr lampp
prepare:
	sudo ./lampp stop
	sudo rm -fr logs/*
	sudo rm -fr var/mysql/*.err
	sudo rm -fr var/mysql/ib*
	sudo mkdir .package
	sudo mv * .package
	sudo mv .package lampp
	sudo mv lampp/Makefile .
	sudo chmod a+rx lampp/start*
	sudo chmod a+rx lampp/start88
zentaorelease:	
	VERSION=$(shell head -n 1 zentao/VERSION)
	sudo 7z a -sfx ZenTaoPMS.${VERSION}.linux.7z lampp
xirangrelease:	
	VERSION=$(shell head -n 1 xirang/VERSION)
	sudo 7z a -sfx xirangEPS.${VERSION}.linux.7z lampp
commonrelease:	
	VERSION=$(shell head -n 1 lib/VERSION)
	sudo 7z a -sfx zentaolamp.${VERSION}.linux.7z lampp
releaseclean:
	sudo mv lampp lampp.bak
	sudo mv lampp.bak/* .
	sudo rm -fr *.7z
	sudo rm -fr lampp.bak
