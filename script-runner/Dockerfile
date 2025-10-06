FROM python:3.11-slim

WORKDIR /script-runner

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python"]