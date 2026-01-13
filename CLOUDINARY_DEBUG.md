# 🔍 Checklist Debug Upload Cloudinary

## ✅ Verifica su Render (CRITICO)

Vai su: https://dashboard.render.com → tech-portfoglio-new → Environment

**Controlla che TUTTE queste variabili esistano:**

```
FILESYSTEM_DISK = cloudinary
CLOUDINARY_CLOUD_NAME = [il tuo cloud name]
CLOUDINARY_API_KEY = [la tua API key]
CLOUDINARY_API_SECRET = [il tuo API secret]
```

**⚠️ IMPORTANTE:**
- Il valore deve essere esattamente `cloudinary` (minuscolo)
- Non `Cloudinary` o `CLOUDINARY`

---

## 🧪 Test Manuale Upload

1. Vai su: https://tech-portfoglio-new.onrender.com/admin
2. Login: admin@example.com / password123
3. Click "Projects" → "New Project"
4. Compila:
   - Title: "Test Upload"
   - Category: "web"
   - Description: "Test"
5. Click sul campo Image e seleziona un JPG < 5MB
6. Click "Create"

**Cosa succede?**
- A) File si carica, vedi preview ✅
- B) Errore rosso con messaggio specifico ❌
- C) Nulla succede ⚠️
- D) Pagina si ricarica ma immagine non c'è ⚠️

---

## 🔧 Soluzioni per Scenario

### **Scenario B: Errore con messaggio**
Copia l'esatto messaggio di errore e mandamelo.

### **Scenario C o D: Nessun errore ma non funziona**

**Possibili cause:**
1. `FILESYSTEM_DISK` non è `cloudinary`
2. Credenziali Cloudinary sbagliate
3. il servizio non si è riavviato dopo l'aggiunta delle env vars

**Soluzione:**
1. Verifica tutte le env vars su Render
2. Click "Manual Deploy" → "Deploy latest commit"
3. Aspetta deploy completo
4. Riprova upload

---

## 🆘 Alternative Immediate

Se Cloudinary continua a non funzionare, possiamo:

**Opzione 1: Usa storage locale temporaneamente**
- Su Render Environment, rimuovi `FILESYSTEM_DISK=cloudinary`
- Le foto funzioneranno MA spariranno al prossimo deploy
- OK solo per test

**Opzione 2: Debug approfondito**
- Accesso alla Shell di Render
- Esegui comandi per verificare configurazione
- Vediamo logs dettagliati

---

**Dimmi esattamente cosa vedi quando provi a caricare la foto!**
