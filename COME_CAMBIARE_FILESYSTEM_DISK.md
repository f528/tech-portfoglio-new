# 📝 CAMBIARE FILESYSTEM_DISK SU RENDER (3 minuti)

## 🎯 Passi Precisi

### **1. Apri Render Dashboard**
👉 https://dashboard.render.com

### **2. Seleziona il Servizio**
- Nella lista, cerca `tech-portfoglio-new`
- Click sul nome per aprire

### **3. Vai su Environment**
- Nel menu laterale sinistro
- Click su **"Environment"**

### **4. Trova FILESYSTEM_DISK**
- Nella lista di variabili, cerca `FILESYSTEM_DISK`
- Attualmente il valore è: `cloudinary`

### **5. Modifica la Variabile**
- Click sui **3 puntini (...)** a destra della riga `FILESYSTEM_DISK`
- Dal menu a tendina, click su **"Edit"**

### **6. Cambia il Valore**
- Nel campo "Value", cancella: `cloudinary`
- Scrivi: `public`
- Click su **"Save"**

### **7. Conferma il Salvataggio**
- Dovresti vedere un messaggio di conferma
- Il valore ora mostra: `public`

### **8. Riavvio Automatico**
- Render rileverà il cambio
- Il servizio si riavvierà automaticamente
- Tempo: **1-2 minuti**

---

## ✅ Come Verificare

**Dashboard Render:**
- Vai su "Events" (menu laterale)
- Dovresti vedere "Deployment started" 
- Aspetta che diventi "Live"

**Oppure:**
- Vai su "Logs" (menu laterale)
- Vedi i log del riavvio
- Aspetta "🌐 Starting PHP server..."

---

## 🎯 Dopo il Riavvio

1. Vai su: https://tech-portfoglio-new.onrender.com/admin
2. Login: admin@example.com / password123
3. Projects → Edit un progetto
4. **Carica una foto** (dovrebbe funzionare!)

---

**Fai questi passi e dimmi quando vedi il servizio "Live"!** 🚀
