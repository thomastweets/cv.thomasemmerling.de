PY?=python

TEX = pandoc
TEXFILE = template.tex
CONTENTFILE = details.yml
FLAGS = --latex-engine=xelatex

BASEDIR=$(CURDIR)
INPUTDIR=$(BASEDIR)/content
OUTPUTDIR=$(BASEDIR)/output
OUTPUTFILE=$(OUTPUTDIR)/CV_ThomasEmmerling.pdf

GITHUB_PAGES_BRANCH=master

help:
	@echo 'Makefile for a pelican Web site                                           '
	@echo '                                                                          '
	@echo 'Usage:                                                                    '
	@echo '   make clean                          remove the generated files         '
	@echo '   make build	                        generate files										 '
	@echo '   make github                         upload the web site via gh-pages   '
	@echo '                                                                          '


clean:
	[ ! -d $(OUTPUTDIR) ] || rm -rf $(OUTPUTDIR)

build:
	mkdir $(OUTPUTDIR)
	$(TEX) $(CONTENTFILE) -o $(OUTPUTFILE) --template=$(TEXFILE) $(FLAGS)

github: publish
	ghp-import -n $(OUTPUTDIR)
	@git push -fq https://${GH_TOKEN}@github.com/$(TRAVIS_REPO_SLUG).git gh-pages > /dev/null

.PHONY: help clean build github
