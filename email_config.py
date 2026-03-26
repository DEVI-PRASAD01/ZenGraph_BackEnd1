from fastapi_mail import ConnectionConfig

conf = ConnectionConfig(
    MAIL_USERNAME="punugotideviprasad00@gmail.com",
    MAIL_PASSWORD="prmkqtxqadrkskaw",
    MAIL_FROM="punugotideviprasad00@gmail.com",
    MAIL_FROM_NAME="ZenGraph",
    MAIL_PORT=587,
    MAIL_SERVER="smtp.gmail.com",
    MAIL_STARTTLS=True,
    MAIL_SSL_TLS=False,
    USE_CREDENTIALS=True,
    VALIDATE_CERTS=True
)