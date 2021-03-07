FROM gcr.io/project-id/nodejs-server-non-runnable-base:v1.0.0 as source-content

WORKDIR /home/nodejs/app

COPY app/* ./

RUN npm install

CMD [ "node", "app.js" ]
