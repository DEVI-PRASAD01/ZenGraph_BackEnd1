from fastapi_mail import ConnectionConfig

conf = ConnectionConfig(
    MAIL_USERNAME="punugotideviprasad00@gmail.com",
    MAIL_PASSWORD="xdjwstmwcexguvtb",
    MAIL_FROM="punugotideviprasad00@gmail.com",
    MAIL_FROM_NAME="ZenGraph",
    MAIL_PORT=465,
    MAIL_SERVER="smtp.gmail.com",
    MAIL_STARTTLS=False,
    MAIL_SSL_TLS=True,
    USE_CREDENTIALS=True,
    VALIDATE_CERTS=False
)