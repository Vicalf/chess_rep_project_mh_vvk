FROM project_repro
WORKDIR /app
COPY . /app
CMD jupyter nbconvert analysis.ipynb --execute --to markdown --output test && mv test.md /output && mv test_files /output
