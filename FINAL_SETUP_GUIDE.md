# ✅ GUIDA STEP-BY-STEP: Configurazione Finale

## 🎯 Passi da Completare (in ordine)

### ✅ STEP 1: Fix Cloudinary su Render (CRITICO)

**Su Render Dashboard:**
1. Vai su: https://dashboard.render.com
2. Seleziona servizio `tech-portfoglio-new`
3. Click "Environment" nel menu laterale
4. Trova `LOUDINARY_API_SECRET` → Click ... → Delete
5. Click "Add Environment Variable"
   - Key: `CLOUDINARY_API_SECRET`
   - Value: (stesso valore che aveva LOUDINARY_API_SECRET)
6. Salva
7. Il servizio si riavvierà automaticamente (aspetta 2 min)

---

### ✅ STEP 2: Verifica Upload File

**Dopo il riavvio:**
1. Vai su: https://tech-portfoglio-new.onrender.com/admin
2. Login: `admin@example.com` / `password123`
3. Click "Projects" → "New Project"
4. Compila i campi:
   - Title: `Test Project`
   - Category: `web`
   - Description: `Test upload immagini`
5. Carica un'immagine JPG < 5MB
6. Salva

✅ Se vedi l'immagine nella lista → **FUNZIONA!**
❌ Se errore → verifica credenziali Cloudinary

---

### ✅ STEP 3: Popola Database

**Via Admin Panel (https://tech-portfoglio-new.onrender.com/admin):**

#### Profile
1. Click "Profiles" → Edit existing
2. Compila:
   - Name, Title, Bio, Email
   - Carica Avatar
   - Location (opzionale)
   - Social Links (opzionale)
3. Salva

#### Skills (almeno 5)
1. Click "Skills" → "New Skill"
2. Per ogni skill:
   - Name: es. `Laravel`
   - Category: `Backend`
   - Level: `85`
3. Ripeti per: PHP, JavaScript, React, Docker

#### Projects (almeno 2)
1. Click "Projects" → "New Project"
2. Per ogni progetto:
   - Title, Description
   - Category: `web`/`security`/`fullstack`
   - Link (opzionale)
   - Skills: `['Laravel', 'Next.js']`
   - **Carica immagine**
3. Salva

#### Certifications (almeno 2)
1. Click "Certifications" → "New Certification"
2. Compila: Name, Issuer, Date
3. Carica badge (opzionale)

---

### ✅ STEP 4: Verifica API con Dati

```bash
curl https://tech-portfoglio-new.onrender.com/api/portfolio | python3 -m json.tool
```

Dovresti vedere:
- ✅ Profile popolato
- ✅ Skills array con 5+ elementi
- ✅ Projects array con 2+ progetti
- ✅ Certifications array
- ✅ URL immagini puntano a Cloudinary

---

### ✅ STEP 5: Configura Vercel

1. Vai su: https://vercel.com/dashboard
2. Seleziona progetto `tech-portfoglio-new`
3. Click "Settings" → "Environment Variables"

**Aggiungi queste 3 variabili:**

**Variabile 1:**
- Key: `NEXT_PUBLIC_API_URL`
- Value: `https://tech-portfoglio-new.onrender.com/api`
- Environments: ✅ Production, ✅ Preview, ✅ Development
- Click "Add"

**Variabile 2:**
- Key: `NEXT_PUBLIC_STORAGE_URL`
- Value: `https://tech-portfoglio-new.onrender.com/storage`
- Environments: ✅ Production, ✅ Preview, ✅ Development
- Click "Add"

**Variabile 3:**
- Key: `NEXT_PUBLIC_BACKEND_URL`
- Value: `https://tech-portfoglio-new.onrender.com`
- Environments: ✅ Production, ✅ Preview, ✅ Development
- Click "Add"

---

### ✅ STEP 6: Redeploy Vercel

1. Click "Deployments" (top menu)
2. Trova l'ultimo deployment
3. Click ... (tre puntini) → "Redeploy"
4. **Deseleziona** "Use existing Build Cache"
5. Click "Redeploy"
6. Aspetta 2-3 minuti

---

### ✅ STEP 7: Test Frontend

1. Apri: https://tech-portfoglio-new.vercel.app
2. Verifica che si carichino:
   - ✅ Dati profile
   - ✅ Skills con progress bars
   - ✅ Projects con immagini
   - ✅ Certifications
3. Apri Developer Tools (F12)
4. Vai su Console
5. **NON devono esserci errori CORS**

---

### ✅ STEP 8: Update CORS su Render (se necessario)

Se vedi errori CORS:

1. Su Render → Environment
2. Aggiungi/Modifica:
   - Key: `FRONTEND_URL`
   - Value: `https://tech-portfoglio-new.vercel.app`
3. Salva e riavvia

---

## 🎉 Checklist Finale

- [ ] STEP 1: Fix typo Cloudinary
- [ ] STEP 2: Upload test funzionante
- [ ] STEP 3: Database popolato con dati reali
- [ ] STEP 4: API ritorna dati completi
- [ ] STEP 5: Vercel environment variables configurate
- [ ] STEP 6: Frontend redeployato
- [ ] STEP 7: Frontend mostra dati e immagini
- [ ] STEP 8: Nessun errore CORS

---

**Vai step-by-step e dimmi quando completi ciascuno!** 🚀
