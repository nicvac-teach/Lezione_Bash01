#!/bin/bash

# =============================================================================
# Script di setup per Lezione_Bash01
# Esegui questo script per creare l'ambiente di esercitazione
# =============================================================================

echo "🔧 Creazione ambiente di esercitazione..."
rm -fr esercizi
rm -fr sandbox

# -----------------------------------------------------------------------------
# Albero di directory per esercizi di navigazione
# -----------------------------------------------------------------------------

mkdir -p esercizi/documenti/lettere
mkdir -p esercizi/documenti/report/2023
mkdir -p esercizi/documenti/report/2024
mkdir -p esercizi/immagini/vacanze
mkdir -p esercizi/immagini/lavoro
mkdir -p esercizi/progetti/webapp/src
mkdir -p esercizi/progetti/webapp/docs
mkdir -p esercizi/progetti/script

# -----------------------------------------------------------------------------
# File di esempio con contenuti diversi
# -----------------------------------------------------------------------------

echo "Ciao, questa è una lettera di esempio." > esercizi/documenti/lettere/lettera1.txt
echo "Seconda lettera di prova." > esercizi/documenti/lettere/lettera2.txt

echo "Report vendite Q1 2023" > esercizi/documenti/report/2023/vendite_q1.txt
echo "Report vendite Q2 2023" > esercizi/documenti/report/2023/vendite_q2.txt
echo "Report vendite Q1 2024" > esercizi/documenti/report/2024/vendite_q1.txt

echo "console.log('Hello World');" > esercizi/progetti/webapp/src/index.js
echo "# Documentazione WebApp" > esercizi/progetti/webapp/docs/README.md

cat << 'EOF' > esercizi/progetti/script/backup.sh
#!/bin/bash
# Script di backup
echo "Avvio backup..."
cp -r documenti/ backup/
echo "Backup completato!"
EOF

cat << 'EOF' > esercizi/progetti/script/pulizia.sh
#!/bin/bash
# Script di pulizia file temporanei
echo "Pulizia in corso..."
rm -f *.tmp
echo "Pulizia completata!"
EOF

# -----------------------------------------------------------------------------
# File con permessi diversi per esercizi su chmod
# -----------------------------------------------------------------------------

mkdir -p esercizi/permessi

echo "File pubblico - tutti possono leggere" > esercizi/permessi/pubblico.txt
chmod 644 esercizi/permessi/pubblico.txt

echo "File privato - solo il proprietario" > esercizi/permessi/privato.txt
chmod 600 esercizi/permessi/privato.txt

echo "File segreto - solo lettura per il proprietario" > esercizi/permessi/segreto.txt
chmod 000 esercizi/permessi/segreto.txt

cat << 'EOF' > esercizi/permessi/eseguibile.sh
#!/bin/bash
echo "Sono eseguibile!"
EOF
chmod 755 esercizi/permessi/eseguibile.sh

cat << 'EOF' > esercizi/permessi/non_eseguibile.sh
#!/bin/bash
echo "Script non eseguibile"
EOF
chmod 644 esercizi/permessi/non_eseguibile.sh

# -----------------------------------------------------------------------------
# Directory per esercizi pratici (da usare come "sandbox")
# -----------------------------------------------------------------------------

mkdir -p sandbox

echo ""
echo "✅ Ambiente creato con successo!"
echo ""
echo "Struttura creata:"
tree esercizi 2>/dev/null || find esercizi -type d | head -20
echo ""
echo "✅ Ambiente pronto!"
echo ""
echo "Puoi iniziare gli esercizi!"