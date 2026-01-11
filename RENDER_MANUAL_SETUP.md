# 🔧 Render - Configurazione Manuale URGENTE

## ⚠️ Problema Attuale

Render sta usando il **commit vecchio senza Docker**:
```
❌ Commit in uso: 8c6d598 (senza Docker)
✅ Commit corretto: 6f69cc3 (con Docker)
```

Render continua a usare **Node.js** invece di **Docker**.

---

## 🚨 SOLUZIONE IMMEDIATA - Segui Questi Passi

### **Passo 1: Apri Render Dashboard**

1. Vai su: **https://dashboard.render.com**
2. Login con il tuo account
3. Troverai il tuo Web Service backend nella lista

### **Passo 2: Vai su Settings**

1. Click sul tuo **Web Service** (backend)
2. Nel menu laterale, click su **"Settings"**

### **Passo 3: CAMBIA ENVIRONMENT**

Scorri fino a trovare la sezione **"Environment"**

**TROVA:**
- Environment: `Node` 

**CAMBIA IN:**
- Environment: `Docker` ⬅️ **IMPORTANTE!**

### **Passo 4: Configura Dockerfile Path**

Apparirà un nuovo campo:

**Dockerfile Path:**
```
./Dockerfile
```

### **Passo 5: RIMUOVI Build Command**

Scorri fino a **"Build Command"**

**PRIMA:**
```bash
bash build.sh
```

**CAMBIA IN:**
```
(vuoto - cancella tutto)
```

### **Passo 6: RIMUOVI Start Command**

**"Start Command":**

**PRIMA:**
```bash
bash start.sh
```

**CAMBIA IN:**
```
(vuoto - cancella tutto)
```

> **Perché?** Docker usa il `CMD` definito nel Dockerfile, non serve specificarli qui.

### **Passo 7: Salva**

Scorri in fondo e click su:

**🟢 "Save Changes"**

### **Passo 8: Manual Deploy con Commit Corretto**

Dopo aver salvato:

1. Vai su **"Manual Deploy"** nel menu laterale
2. Click sul bottone **"Clear build cache & deploy"**
3. Render farà pull del commit più recente (6f69cc3 con Docker)

---

## 📊 Cosa Vedrai nei Logs

Durante il deploy, vai su **"Logs"** e dovresti vedere:

```
==> Building from Dockerfile...
Step 1/15 : FROM php:8.3-fpm
 ---> Pulling image...
Step 2/15 : RUN apt-get update...
 ---> Running in container...
...
==> Successfully built Docker image
==> Starting container...
🚀 Starting Laravel application...
🗄️  Running migrations...
🔗 Linking storage...
⚡ Optimizing...
🌐 Starting PHP server on port 10000...

Your service is live 🎉
```

---

## ✅ Checklist Configurazione

Prima del deploy, assicurati:

- [ ] Environment = **Docker** (non Node!)
- [ ] Dockerfile Path = `./Dockerfile`
- [ ] Build Command = **(vuoto)**
- [ ] Start Command = **(vuoto)**
- [ ] Environment Variables configurate ⬇️

---

## 🌍 Environment Variables Necessarie

Vai su **"Environment"** e aggiungi:

```bash
APP_KEY=base64:9plw5O7drBQcZB5hlWK//hosBjZFbbmpCvk1akGXXSA=
APP_NAME=Tech Portfolio
APP_ENV=production
APP_DEBUG=false
APP_URL=https://[TUO-URL].onrender.com
FRONTEND_URL=https://[TUO-URL].vercel.app
DB_CONNECTION=sqlite
SESSION_DRIVER=database
CACHE_STORE=database
LOG_CHANNEL=stderr
LOG_LEVEL=error
```

**⚠️ IMPORTANTE:** Sostituisci `[TUO-URL]` con i tuoi URL reali!

---

## 🎯 Come Trovare il Tuo URL Render

Nella pagina del tuo Web Service, in alto vedrai:

```
🌐 https://tech-portfolio-backend-xxxx.onrender.com
```

Copia questo URL e usalo per `APP_URL`.

---

## ❓ FAQ

### "Non trovo dove cambiare da Node a Docker"

È nella sezione **Settings** → scorri fino a **"Environment"** → troverai un menu a tendina.

### "Dockerfile Path non appare"

Appare SOLO dopo che hai selezionato "Docker" come Environment e salvato.

### "Il deploy continua a fallire"

1. Controlla che Environment sia **Docker**
2. Verifica che Build/Start Command siano **vuoti**
3. Controlla i logs per errori specifici

### "Come so se sta usando il commit giusto?"

Nei logs all'inizio vedrai:
```
==> Checking out commit 6f69cc3...
```

Se vedi ancora `8c6d598`, fai "Clear build cache & deploy".

---

## 🆘 Se Continua a Non Funzionare

**Opzione: Crea Nuovo Web Service**

1. Dashboard Render → **"New +"** → **"Web Service"**
2. Connetti repository: `f528/tech-portfoglio-new`
3. **Name:** `tech-portfolio-backend-v2`
4. **Environment:** `Docker`
5. **Dockerfile Path:** `./Dockerfile`
6. **Build Command:** (vuoto)
7. **Start Command:** (vuoto)
8. Aggiungi tutte le Environment Variables
9. Click **"Create Web Service"**

---

**Segui questi passi esattamente e il backend Laravel funzionerà su Render!** 🚀
