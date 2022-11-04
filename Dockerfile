FROM python:3.12.0a1-alpine3.16
ENV TZ=Europe/Berlin
COPY ./requirements.txt ./app.py /app/
WORKDIR /app
RUN pip install -r requirements.txt

ENTRYPOINT [ "python" ]
CMD ["app.py" ]
