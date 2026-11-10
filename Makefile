.DEFAULT_GOAL := check

CHECK_TASKS := lint
BUILD_OUTPUTS :=
CONTAINER_BUILD_ARGS :=

export CHECK_TASKS BUILD_OUTPUTS CONTAINER_BUILD_ARGS TEST_ARGS COMMAND

.PHONY: check check-info lint test build exec

check lint test build exec:
	@./tests/container/run $@

check-info:
	@./tests/container/run info
