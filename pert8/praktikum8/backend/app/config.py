from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    database_url: str = "mysql+pymysql://tabungku:local_only@localhost:3307/tabungku"


settings = Settings()
