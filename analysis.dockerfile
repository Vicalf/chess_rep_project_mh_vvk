FROM project_repro
WORKDIR /app
COPY . /app
CMD jupyter nbconvert analysis.ipynb --execute --to markdown --output analysis && mv analysis.md /output && mv analysis_files /output
