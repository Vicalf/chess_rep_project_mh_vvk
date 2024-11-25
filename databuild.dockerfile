FROM project_repro
WORKDIR /app
COPY . /app
CMD python ./gptchess/gpt-experiments.py

