FROM python:3.12-slim AS base
WORKDIR /project
ENV PATH=/project/.venv/bin:$PATH

FROM base AS deps
ENV PDM_CHECK_UPDATE=false
RUN pip install -U pdm
COPY pyproject.toml pdm.lock /project/
RUN pdm install --check --prod --no-editable

FROM deps AS test 
RUN pdm install --check --dev --no-editable
COPY src /project/src
COPY tests /project/tests
ENTRYPOINT [ "pdm" ]

FROM base AS app 
COPY --from=deps /project/.venv /project/.venv
COPY src /project/
ENTRYPOINT [ "python", "-m" ]
