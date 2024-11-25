FROM project_repro
WORKDIR /app
COPY . /app
CMD python3 ./gptchess/gpt-experiments.py

