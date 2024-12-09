# docker-lamp-resoucespace

Docker with Apache, MySQL 8.3.1, PHPMyAdmin, PHP (including some important PHP extensions) and ResourceSpace.

To run these containers:

```
docker-compose up -d
```

Open phpmyadmin at [http://127.0.0.1:8000](http://127.0.0.1:8000)
Open web browser to look at a simple php example at [http://127.0.0.1:8090](http://127.0.0.1:8090)

Run MySQL client:

- `docker-compose exec db mysql -u root -p` 


## ResourceSpace

### Folders

ResourceSpace ist unter dem Root-Verzeichnis `/` (⬅️ `/var/www/html`) verfügbar.

Das `/var/www/html`-Webseiten-Root-Verzeichnis wird in ein persistentes Volume abgelegt. Es als bind mount einzubinden, führt dazu, dass es im Container leer ist (eine Möglichkeit, das Container-Verzeichnis nach außen "freizugeben" gibt es wohl nicht).

### Setup

Wird gemappt auf: `http://localhost:8090/`.

Die meisten Konfigurationsvariablen werden über die `uploads.ini` angepasst, sodass bei der Installation keine Fehler geworfen werden. Ein Problem beleibt aber bestehen: als `Basis URL` müsste man etwas eintragen, das im und außerhalb vom Container funktioniert. `http://www` lässt die Installation durchlaufen, führt beim Aufrufen später aber zu Fehlern. Die Lösung kann sein: `http://${IP_DES_HOSTS}:8090`.

Nach Aufrufen von `http://localhost:8090` braucht es folgende Angaben:
- Database server: `db`
- Database: `${MYSQL_DB}`
- Database user: `${MYSQL_DB}`
- Database user password: `${MYSQL_PW}`
- Database read-only credentials: leave blank
- Base URL: `${HOST_IP_ADDRESS}:8090`