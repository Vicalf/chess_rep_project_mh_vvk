FROM project_repro
WORKDIR /app
COPY . /app
CMD jupyter nbconvert analysis.ipynb --execute --to markdown
