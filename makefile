PYTHON=./env/bin/python3
SRC=./pmix/
TEST=./test/

PYLINT=${PYTHON} -m pylint --output-format=colorized --reports=n
PYCODESTYLE=${PYTHON} -m pycodestyle
PYDOCSTYLE=${PYTHON} -m pydocstyle

LINT_SRC=${PYLINT} ${SRC}
LINT_TEST=${PYLINT} ${TEST}

CODE_SRC=${PYCODESTYLE} ${SRC}
CODE_TEST=${PYCODESTYLE} ${TEST}

DOC_SRC=${PYDOCSTYLE} ${SRC}
DOC_TEST=${PYDOCSTYLE} ${TEST}


.PHONY: lint linttest lintall pylint pylinttest pylintall code codetest codeall doc test testdoc test_all ssh tags ltags test_feature test_feature_doc

# ALL LINTING
lint:
	${LINT_SRC} && ${CODE_SRC} && ${DOC_SRC}

linttest:
	${LINT_TEST} && ${CODE_TEST} && ${DOC_TEST}

lintall: lint linttest


# PYLINT
pylint:
	${LINT_SRC}

pylinttest:
	${LINT_TEST}

pylintall: pylint pylinttest

# PYCODESTYLE
code:
	${CODE_SRC}

codetest:
	${CODE_TEST}

codeall: code codetest


# PYDOCSTYLE
doc:
	${DOC_SRC}


# TESTING
TEST_FEATURE_FILE=BFR5-Female-Questionnaire-v8-jef
test:
	${PYTHON} -m unittest discover -v

test_feature:
	${PYTHON} -m pmix.ppp test/files/${TEST_FEATURE_FILE}.xlsx -l English -f html -p minimal > output/${TEST_FEATURE_FILE}.html

test_feature_doc:
	${PYTHON} -m pmix.ppp test/files/${TEST_FEATURE_FILE}.xlsx -l English -f doc -p minimal > output/${TEST_FEATURE_FILE}.doc
	open output/${TEST_FEATURE_FILE}.doc

testdoc:
	${PYTHON} -m test.test --doctests-only

test_all: test testdoc


# SERVER MANAGEMENT
ssh:
	ssh root@192.155.80.11


# CTAGS
tags:
	ctags -R --python-kinds=-i .

ltags:
	ctags -R --python-kinds=-i ./${CODE_SRC}
