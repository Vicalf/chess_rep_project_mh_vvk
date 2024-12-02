FROM project_repro
WORKDIR /app
COPY . /app
VOLUME ./games ./games
CMD python3 ./gptchess/gpt-experiments.py

