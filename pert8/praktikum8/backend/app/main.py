from datetime import datetime

from fastapi import FastAPI

app = FastAPI(title="TabungKu API", version="0.1.0")


@app.get("/")
def beranda():
    return {"pesan": "Selamat datang di TabungKu API. Dokumentasi: /docs"}


@app.get("/health")
def health():
    return {
        "status": "ok",
        "waktu_server": datetime.now().isoformat(timespec="seconds"),
    }


@app.get("/info")
def info():
    return {"nama_aplikasi": "TabungKu", "versi": "0.1.0", "zona_waktu": "Asia/Jakarta"}
