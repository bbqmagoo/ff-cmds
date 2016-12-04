#
# http://www.cs.colby.edu/maxwell/courses/tutorials/maketutor/
# https://stackoverflow.com/questions/10883666/makefile-is-missing-separator
# http://www.gnu.org/software/make/manual/make.html
# http://sunsite.ualberta.ca/Documentation/Gnu/make-3.79/html_chapter/make_4.html
#
# Makefile to install ff-tools/ff-cmds to respective places (ver 0.1.1)
#
# $(INSTALL) $$file $(INSTALLDIR)/$$f; \
shell =: /bin/bash
INSTALLDIR = /opt/ff-tools/bin
#INSTALLDIR = /usr/local/bin
APPLICATIONS = /opt/ff-tools/app
#APPLICATIONS = /usr/share/applications
#PYTHONIMPORT = /usr/local/lib/python3.5/dist-packages
PYTHONIMPORT = /opt/ff-tools/app/dist-packages
INSTALL = install --owner=root -T -D
INSTALLD = install --mode=644 --owner=root -T -D
PYPROGRAMS = ff-analyze ff-aspect ff-cleaner ff-dropper ff-info ff-rename ff-size ff-tail ff-thumb-make ff-view
SHPROGRAMS = ff-annotate ff-compare ff-crop-detect ff-cropsize ff-dclick ff-fbrename ff-gourmet ff-kill-recode ff-recode-dir ff-thumb-test
NOINSTALL = aspect ff-grok ff-drop-sh
DESKTOPFILES = conky ff-analyze ff-aspect ffcopy2-dropper ffcrop-dropper ff-dropper ff-gourmet ff-info ff-rename ffrename-dropper ff-size ffwget-dropper
PYYADIMP = yad.py
MAGOOTLS = proctools.py logtools.py yadtools.py __init__.py

.PHONY:
ALL: install

clone: /home/magoo/src
	echo rm -rf src
	echo git clone https://github.com/bbqmagoo/ff-cmds.git

print-%: ; @echo $*=$($*)

install: # $(PYPROGRAMS) $(SHPROGRAMS) $(DESKTOPFILES) $(PYTHONIMP)
	cd Python; \
	for f in $(PYPROGRAMS); do \
		$(INSTALL) $$f $(INSTALLDIR)/$$f; \
	done; \
	cd ..; \
	cd Shell; \
	for f in $(SHPROGRAMS); do \
		$(INSTALL) $$f $(INSTALLDIR)/$$f; \
	done; \
	cd ..; \
	cd Desktop; \
	for f in $(DESKTOPFILES); do \
		$(INSTALLD) $$f $(APPLICATIONS)/$$f.desktop; \
	done; \
	cd ..; \
	cd Python/import/yad; \
	for f in $(PYYADIMP); do \
		$(INSTALLD) $$f $(PYTHONIMPORT)/$$f; \
	done; \
	cd ../../..; \
	cd Python/import/magoo; \
	for f in $(MAGOOTLS); do \
		echo $(INSTALLD) $$f $(PYTHONIMPORT)/magoo/$$f; \
	done; \
	cd ../../..; \

.PHONY: clean
clean: src
	echo rm -rf src
