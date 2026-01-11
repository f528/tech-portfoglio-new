# 🔧 Guida alla Connessione Frontend-Backend (Vercel + Render)

## 🎯 Problema Identificato

Il backend Laravel su Render non permette le richieste dal frontend Next.js su Vercel a causa di:
1. ❌ **CORS** bloccato - solo localhost configurato
2. ❌ **Content Security Policy** troppo restrittiva
3. ❌ **Variabili d'ambiente** mancanti

## ✅ Modifiche Applicate

### Backend (Laravel - Render)

**File: `backend/config/cors.php`**
- ✅ Aggiunto supporto per domini Vercel con pattern regex
- ✅ Supporto per variabile d'ambiente `FRONTEND_URL`

**File: `backend/.env.example`**
- ✅ Aggiunta variabile `FRONTEND_URL`

### Frontend (Next.js - Vercel)

**File: `next.config.mjs`**
- ✅ Supporto dinamico per backend URL in `remotePatterns`
- ✅ CSP aggiornato per includere backend Render

**File: `.env.local`**
- ✅ Creato con configurazione localhost

---

## 🚀 Configurazione su Render (Backend)

### 1. Accedi al Dashboard Render
Vai su [https://dashboard.render.com](https://dashboard.render.com)

### 2. Seleziona il tuo Web Service del backend

### 3. Vai su "Environment" → Click su "Add Environment Variable"

### 4. Aggiungi queste variabili:

```bash
# URL del tuo backend (esempio)
APP_URL=https://tuo-backend.onrender.com

# URL del tuo frontend Vercel
FRONTEND_URL=https://tuo-portfolio.vercel.app

# Se usi database PostgreSQL su Render, assicurati di avere:
DB_CONNECTION=pgsql
DB_HOST=<render-database-host>
DB_PORT=5432
DB_DATABASE=<database-name>
DB_USERNAME=<database-username>
DB_PASSWORD=<database-password>

# Altre variabili importanti
APP_ENV=production
APP_DEBUG=false
APP_KEY=<generato-con-php-artisan-key:generate>
```

### 5. Salva e Rideploya il servizio

Dopo aver salvato le variabili, Render riavvierà automaticamente il servizio.

---

## 🎨 Configurazione su Vercel (Frontend)

### 1. Accedi al Dashboard Vercel
Vai su [https://vercel.com/dashboard](https://vercel.com/dashboard)

### 2. Seleziona il tuo progetto

### 3. Vai su "Settings" → "Environment Variables"

### 4. Aggiungi queste variabili:

```bash
# URL del backend su Render (IMPORTANTE!)
NEXT_PUBLIC_API_URL=https://tuo-backend.onrender.com/api
NEXT_PUBLIC_STORAGE_URL=https://tuo-backend.onrender.com/storage
NEXT_PUBLIC_BACKEND_URL=https://tuo-backend.onrender.com
```

> **⚠️ IMPORTANTE:** Sostituisci `tuo-backend.onrender.com` con il tuo vero dominio Render!

### 5. Scope delle Variabili

Per ciascuna variabile, seleziona:
- ✅ Production
- ✅ Preview
- ✅ Development

### 6. Rideploya

Dopo aver salvato le variabili:
1. Vai su "Deployments"
2. Click sui tre puntini (...) sull'ultimo deployment
3. Click su "Redeploy"
4. Seleziona "Use existing Build Cache" ❌ (deseleziona)
5. Click su "Redeploy"

---

## 🔍 Come Trovare gli URL

### URL Backend Render
1. Dashboard Render → tuo Web Service
2. In alto troverai l'URL tipo: `https://tuo-portfolio-backend.onrender.com`

### URL Frontend Vercel
1. Dashboard Vercel → tuo progetto
2. In alto troverai l'URL tipo: `https://tuo-portfolio.vercel.app`

---

## 🧪 Test della Connessione

### 1. Test API Diretto
Apri il browser e vai a:
```
https://tuo-backend.onrender.com/api/portfolio
```

Dovresti vedere i dati JSON del portfolio.

### 2. Test CORS
Apri la console del browser sul tuo sito Vercel (F12) e controlla:
- ❌ Se vedi errori CORS → ricontrolla le configurazioni
- ✅ Se vedi i dati caricati → tutto funziona!

### 3. Test dal Frontend
Vai sul tuo sito Vercel e controlla:
- Home page carica i dati?
- Le immagini dal backend si vedono?
- La console non mostra errori?

---

## 🐛 Troubleshooting Comuni

### Errore: "CORS policy: No 'Access-Control-Allow-Origin'"

**Soluzione:**
1. Controlla che `FRONTEND_URL` su Render sia corretto
2. Verifica che includa `https://` e il dominio esatto
3. Rideploya il backend su Render

### Errore: "Failed to fetch" o "Network Error"

**Soluzione:**
1. Controlla che le variabili `NEXT_PUBLIC_*` su Vercel siano corrette
2. Verifica che il backend sia attivo su Render (non in sleep mode)
3. Rideploya il frontend su Vercel

### Immagini non si caricano

**Soluzione:**
1. Verifica che `NEXT_PUBLIC_STORAGE_URL` sia corretto
2. Controlla che le immagini esistano nel backend
3. Verifica i permessi della cartella `storage/app/public`

### Backend Render in "Sleep Mode"

Render mette i servizi free in sleep dopo 15 minuti di inattività.

**Soluzione:**
- Usa un servizio di ping (es. UptimeRobot) per mantenere attivo il backend
- Oppure passa a un piano a pagamento

---

## 📝 Checklist Finale

Prima del deploy, verifica:

### Backend (Render)
- [ ] `APP_URL` configurato con dominio Render
- [ ] `FRONTEND_URL` configurato con dominio Vercel  
- [ ] `APP_ENV=production`
- [ ] `APP_DEBUG=false`
- [ ] `APP_KEY` generato
- [ ] Database configurato (se usi PostgreSQL)
- [ ] Migrations eseguite
- [ ] Storage linkata: `php artisan storage:link`

### Frontend (Vercel)
- [ ] `NEXT_PUBLIC_API_URL` configurato
- [ ] `NEXT_PUBLIC_STORAGE_URL` configurato
- [ ] `NEXT_PUBLIC_BACKEND_URL` configurato
- [ ] Variabili applicate a Production, Preview, Development
- [ ] Build cache disabilitato durante redeploy

---

## 📞 Comandi Utili

### Sul Backend (terminale locale)
```bash
# Test connessione al backend
curl https://tuo-backend.onrender.com/api/portfolio

# Test CORS
curl -H "Origin: https://tuo-portfolio.vercel.app" \
  -H "Access-Control-Request-Method: GET" \
  -X OPTIONS --verbose \
  https://tuo-backend.onrender.com/api/portfolio
```

### Sul Frontend (console browser)
```javascript
// Test API fetch
fetch('https://tuo-backend.onrender.com/api/portfolio')
  .then(r => r.json())
  .then(console.log)
  .catch(console.error);
```

---

## 🎉 Dopo la Configurazione

Una volta completati tutti i passaggi:

1. ✅ Il frontend Vercel caricherà i dati dal backend Render
2. ✅ Le immagini verranno servite correttamente
3. ✅ Nessun errore CORS nella console
4. ✅ Il portfolio sarà completamente funzionale

---

## 💡 Note Importanti

- **Free tier Render:** Il backend va in sleep dopo 15 minuti di inattività. Il primo caricamento dopo lo sleep può richiedere 30-60 secondi.
- **HTTPS:** Usa sempre `https://` per i domini in produzione, mai `http://`
- **Environment Variables:** Le modifiche alle variabili richiedono un redeploy per essere applicate
- **Build Cache:** Quando aggiorni variabili d'ambiente, disabilita la build cache sul redeploy

---

**Creato il:** 2026-01-11  
**Ultima modifica:** 2026-01-11
