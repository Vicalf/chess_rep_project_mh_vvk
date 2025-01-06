FROM project_repro
WORKDIR /app
COPY . /app
CMD jupyter nbconvert replication-analysis.ipynb --execute --to markdown --output analysis && mv analysis.md /output/replication && mv analysis_files /output/replication
