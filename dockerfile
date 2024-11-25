FROM python:3.11-buster
WORKDIR /app
COPY . /app
RUN pip install -r gptchess/requirements.txt
CMD jupyter nbconvert analysis.ipynb --execute --to markdown
