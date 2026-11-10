# syntax=docker/dockerfile:1.25
FROM koalaman/shellcheck:v0.11.0 AS shellcheck

FROM node:24.22.2 AS markdown
WORKDIR /opt/markdown
COPY tests/container/package.json tests/container/package-lock.json ./
RUN npm ci --ignore-scripts --no-audit --no-fund

FROM node:24.22.2
COPY --from=shellcheck /bin/shellcheck /usr/local/bin/shellcheck
COPY --from=markdown /usr/local/bin/node /usr/local/bin/node
COPY --from=markdown /opt/markdown /opt/markdown
COPY tests/container/check /opt/check/run
ENV PATH=/opt/markdown/node_modules/.bin:${PATH}
