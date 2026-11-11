MARKDOWN_IMAGE := node:24.22.2
SHELLCHECK_IMAGE := koalaman/shellcheck:v0.11.0

export MARKDOWN_IMAGE SHELLCHECK_IMAGE

.PHONY: check

check:
	@./tests/container/check
