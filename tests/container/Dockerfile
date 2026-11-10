# syntax=docker/dockerfile:1.25
FROM koalaman/shellcheck:v0.11.0 AS shellcheck
FROM node:24.22.2

RUN npm install --global markdownlint-cli2@0.24.0 --ignore-scripts --no-audit --no-fund
COPY --from=shellcheck /bin/shellcheck /usr/local/bin/shellcheck
COPY tests/container/check /opt/check/run
