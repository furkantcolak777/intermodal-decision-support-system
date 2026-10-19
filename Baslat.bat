@echo off
chcp 65001 >nul
title ULUK 2026 - Tasinabilir Sunum Modu
color 0A

cd /d "%~dp0"

echo [BILGI] Tasinabilir Python motoru ile kokpit baslatiliyor...

:: Eğer ilk kez çalıştırılıyorsa ve kütüphaneler yoksa pip ile kur (İnternet varsa)
if not exist "Lib\site-packages\fastapi" (
    echo [BILGI] Kutuphaneler ilk kurulum icin indiriliyor...
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python get-pip.py --no-warn-script-location >nul 2>&1
    python -m pip install fastapi uvicorn httpx beautifulsoup4 lxml >nul 2>&1
)

:: Tarayıcıyı 3 saniye sonra aç
start "" cmd /c "timeout /t 3 /nobreak >nul & start http://localhost:8000"

:: Yerel Python motoru ile sunucuyu ayağa kaldır
python -m uvicorn uluk_scraper_server_v2:app --port 8000
pause