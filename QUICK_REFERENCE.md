# 🎯 Quick Reference - Variabili d'Ambiente

## 🔴 RENDER (Backend Laravel)

Vai su: Dashboard Render → Web Service → Environment

```bash
# App Configuration
APP_NAME="Tech Portfolio"
APP_ENV=production
APP_DEBUG=false
APP_KEY=base64:... # Genera con: php artisan key:generate --show

# URLs (SOSTITUISCI CON I TUOI!)
APP_URL=https://tuo-backend.onrender.com
FRONTEND_URL=https://tuo-portfolio.vercel.app

# Database (se usi PostgreSQL su Render)
DB_CONNECTION=pgsql
DB_HOST=<render-db-host>
DB_PORT=5432
DB_DATABASE=<db-name>
DB_USERNAME=<db-user>
DB_PASSWORD=<db-password>

# Session & Cache
SESSION_DRIVER=database
CACHE_STORE=database
QUEUE_CONNECTION=database

# File Storage
FILESYSTEM_DISK=public
```

---

## 🔵 VERCEL (Frontend Next.js)

Vai su: Dashboard Vercel → Project → Settings → Environment Variables

```bash
# Backend URLs (SOSTITUISCI CON IL TUO DOMINIO RENDER!)
NEXT_PUBLIC_API_URL=https://tuo-backend.onrender.com/api
NEXT_PUBLIC_STORAGE_URL=https://tuo-backend.onrender.com/storage
NEXT_PUBLIC_BACKEND_URL=https://tuo-backend.onrender.com
```

**⚠️ Importante:**
- Applica a: ✅ Production, ✅ Preview, ✅ Development
- Dopo aver salvato, rideploya senza build cache

---

## 🧪 Test Rapido

### Metodo 1: Browser
Apri nel browser:
```
https://tuo-backend.onrender.com/api/portfolio
```
Dovresti vedere i dati JSON.

### Metodo 2: Script
Esegui nel terminale:
```bash
./test-connection.sh
```

### Metodo 3: Console Browser
Sul tuo sito Vercel, apri la console (F12) e digita:
```javascript
fetch(process.env.NEXT_PUBLIC_API_URL + '/portfolio')
  .then(r => r.json())
  .then(console.log)
```

---

## ✅ Checklist Post-Deploy

### Render
- [ ] Variabili d'ambiente configurate
- [ ] Database migrato: `php artisan migrate --force`
- [ ] Storage collegato: `php artisan storage:link`
- [ ] Servizio attivo (non in sleep)

### Vercel  
- [ ] Variabili d'ambiente configurate
- [ ] Redeployato senza cache
- [ ] Site live e raggiungibile

### Test Finali
- [ ] Backend risponde a `/api/portfolio`
- [ ] Frontend carica senza errori CORS
- [ ] Immagini dal backend si vedono
- [ ] Console browser senza errori rossi

---

## 🆘 Problemi Comuni

| Errore | Causa | Soluzione |
|--------|-------|-----------|
| CORS Error | Backend non permette origine | Controlla `FRONTEND_URL` su Render |
| Network Error | URL backend sbagliato | Verifica `NEXT_PUBLIC_*` su Vercel |
| 500 Error | Backend crashato | Controlla logs su Render |
| Immagini rotte | Storage non configurato | `php artisan storage:link` |
| Backend lento | Sleep mode (free tier) | Aspetta 30-60s o usa ping service |

---

**Domande?** Leggi la guida completa in [`DEPLOYMENT_FIX.md`](./DEPLOYMENT_FIX.md)
