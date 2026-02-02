# Lezione Bash01 - Navigazione e gestione di file e directory

## Obiettivo

In questa lezione imparerai a muoverti nel filesystem Linux usando il terminale. Alla fine sarai in grado di:

- Navigare tra le directory
- Capire la differenza tra path assoluti e relativi
- Creare ed eliminare directory
- Esplorare il contenuto delle cartelle
- Leggere e modificare i permessi dei file

```
/
├── home/
│   └── utente/
│       └── esercizi/
│           ├── documenti/
│           ├── immagini/
│           └── progetti/
└── ...
```

Lavorerai sulla cartella `esercizi/` che contiene un albero di directory già pronto per fare pratica.

---

## Prima di iniziare

Per preparare l'ambiente di lavoro, 
apri il terminale ed esegui:

```bash
./setup.sh
```

---


## Blocco 1 - Orientarsi nel filesystem

### Obiettivo

Capire dove ci troviamo, vedere cosa c'è intorno a noi, spostarci in un'altra directory.

### Ingredienti

| Comando | Descrizione |
|---------|-------------|
| `pwd` | **P**rint **W**orking **D**irectory - mostra il percorso completo della directory corrente |
| `ls` | **L**i**s**t - elenca il contenuto della directory corrente |
| `cd <percorso>` | **C**hange **D**irectory - cambia la directory corrente |

### Come usarli

1. `pwd` non richiede argomenti: restituisce il percorso assoluto di dove ti trovi
2. `ls` senza argomenti mostra il contenuto della directory corrente
3. `cd` seguito dal nome di una cartella ti sposta in quella cartella

### Esercizio 1.1

1. Apri il terminale
2. Scopri in quale directory ti trovi
3. Visualizza il contenuto della directory corrente
4. Entra nella cartella `esercizi`
5. Verifica di essere nella nuova posizione
6. Visualizza il contenuto di `esercizi`

<details>
<summary>Solo dopo aver svolto l'esercizio, apri qui per vedere la soluzione</summary>

```bash
pwd
# Output esempio: /workspaces/Lezione_Bash01

ls
# Output: esercizi  README.md  sandbox

cd esercizi

pwd
# Output: /workspaces/Lezione_Bash01/esercizi

ls
# Output: documenti  immagini  permessi  progetti
```

</details>

---

### Esercizio 1.2

Partendo dalla cartella `esercizi`:

1. Entra nella cartella `documenti`
2. Entra nella cartella `report`
3. Entra nella cartella `2024`
4. Verifica il percorso completo in cui ti trovi
5. Visualizza cosa contiene

<details>
<summary>Solo dopo aver svolto l'esercizio, apri qui per vedere la soluzione</summary>

```bash
cd documenti
cd report
cd 2024

pwd
# Output: /workspaces/Lezione_Bash01/esercizi/documenti/report/2024

ls
# Output: vendite_q1.txt
```

</details>

---

## Blocco 2 - Path assoluti e relativi

### Obiettivo

Capire la differenza tra path assoluti e relativi, e usare le scorciatoie per navigare più velocemente.

### Ingredienti

| Simbolo | Significato |
|---------|-------------|
| `/` | La radice (root) del filesystem. Un path che inizia con `/` è **assoluto**. |
| `.` | La directory corrente (dove mi trovo adesso) |
| `..` | La directory genitore (un livello sopra) |
| `~` | La home directory dell'utente |

### Path assoluto vs relativo

- **Path assoluto**: parte dalla radice `/`, è sempre lo stesso indipendentemente da dove ti trovi
  - Esempio: `/workspaces/Lezione_Bash01/esercizi/documenti`
  
- **Path relativo**: parte dalla posizione corrente
  - Esempio: `documenti/report` (se sei già in `esercizi`)

### Come usarli

```bash
cd /workspaces/Lezione_Bash01    # path assoluto - vai esattamente qui
cd esercizi                       # path relativo - entra in esercizi (da dove sei)
cd ..                             # sali di un livello
cd ../..                          # sali di due livelli
cd ~                              # torna alla home
cd -                              # torna alla directory precedente
```

### Esercizio 2.1

Partendo da qualsiasi posizione:

1. Vai nella cartella `esercizi/progetti/webapp/src` usando un **path assoluto**
2. Verifica dove ti trovi con `pwd`
3. Torna alla radice del repository usando `..` (quante volte serve?)

<details>
<summary>Solo dopo aver svolto l'esercizio, apri qui per vedere la soluzione</summary>

```bash
cd /workspaces/Lezione_Bash01/esercizi/progetti/webapp/src

pwd
# Output: /workspaces/Lezione_Bash01/esercizi/progetti/webapp/src

cd ../../../..
# Oppure: cd /workspaces/Lezione_Bash01

pwd
# Output: /workspaces/Lezione_Bash01
```

**Nota:** Da `src` devi salire 4 livelli: `src` → `webapp` → `progetti` → `esercizi` → radice repository

</details>

---

### Esercizio 2.2

Partendo dalla radice del repository:

1. Vai in `esercizi/documenti/lettere` con un **path relativo**
2. Ora spostati in `esercizi/immagini/vacanze` usando `..` e path relativo (senza tornare alla radice)
3. Verifica la posizione

<details>
<summary>Solo dopo aver svolto l'esercizio, apri qui per vedere la soluzione</summary>

```bash
cd esercizi/documenti/lettere

cd ../../immagini/vacanze

pwd
# Output: /workspaces/Lezione_Bash01/esercizi/immagini/vacanze
```

**Spiegazione:** Da `lettere` sali due livelli (`..` → `documenti`, `..` → `esercizi`) e poi scendi in `immagini/vacanze`

</details>

---

### Esercizio 2.3

1. Vai nella home directory usando `~`
2. Torna alla directory precedente con un solo comando (senza digitare il path)

<details>
<summary>Solo dopo aver svolto l'esercizio, apri qui per vedere la soluzione</summary>

```bash
cd ~

pwd
# Output: /home/codespace (o simile)

cd -
# Output: /workspaces/Lezione_Bash01/esercizi/immagini/vacanze

pwd
# Conferma: sei tornato dove eri prima
```

**Nota:** `cd -` è molto utile per "saltare" tra due directory su cui stai lavorando

</details>

---

## Blocco 3 - Creare directory

### Obiettivo

Imparare a creare nuove directory, singole o annidate, e visualizzare la struttura ad albero.

### Ingredienti

| Comando | Descrizione |
|---------|-------------|
| `mkdir <nome>` | **M**a**k**e **Dir**ectory - crea una nuova directory |
| `mkdir -p <percorso>` | Crea una directory e tutte le directory intermedie necessarie |
| `tree <percorso>` | Visualizza la struttura delle directory ad albero |

### Come usarli

```bash
mkdir progetti              # crea la directory "progetti"
mkdir uno due tre           # crea tre directory in un colpo solo
mkdir -p a/b/c/d            # crea l'intera gerarchia a → b → c → d
tree a                      # mostra la struttura ad albero di "a"
```

**Nota:** Senza `-p`, se provi a creare `a/b/c` e `a` non esiste, ricevi un errore.

### Esercizio 3.1

Spostati nella cartella `sandbox` ed esegui:

1. Crea una directory chiamata `test`
2. Verifica che esista con `ls`
3. Entra in `test` e crea tre directory: `alfa`, `beta`, `gamma`
4. Verifica con `ls`

<details>
<summary>Solo dopo aver svolto l'esercizio, apri qui per vedere la soluzione</summary>

```bash
cd /workspaces/Lezione_Bash01/sandbox

mkdir test

ls
# Output: test

cd test

mkdir alfa beta gamma

ls
# Output: alfa  beta  gamma
```

</details>

---

### Esercizio 3.2

Dalla cartella `sandbox`:

1. Prova a creare la struttura `livello1/livello2/livello3` con un semplice `mkdir` (senza `-p`). Cosa succede?
2. Ora creala usando l'opzione corretta
3. Verifica che l'intera struttura esista usando `tree`

<details>
<summary>Solo dopo aver svolto l'esercizio, apri qui per vedere la soluzione</summary>

```bash
cd /workspaces/Lezione_Bash01/sandbox

mkdir livello1/livello2/livello3
# Errore: mkdir: cannot create directory 'livello1/livello2/livello3': No such file or directory

mkdir -p livello1/livello2/livello3

tree livello1
# Output:
# livello1
# └── livello2
#     └── livello3
```

</details>

---

### Esercizio 3.3

Usando un **solo comando**, crea nella cartella `sandbox` questa struttura:

```
archivio/
├── 2022/
│   ├── entrate/
│   └── uscite/
├── 2023/
│   ├── entrate/
│   └── uscite/
└── 2024/
    ├── entrate/
    └── uscite/
```

Poi verifica il risultato con `tree`.

<details>
<summary>Solo dopo aver svolto l'esercizio, apri qui per vedere la soluzione</summary>

```bash
cd /workspaces/Lezione_Bash01/sandbox

mkdir -p archivio/{2022,2023,2024}/{entrate,uscite}

tree archivio
# Output:
# archivio
# ├── 2022
# │   ├── entrate
# │   └── uscite
# ├── 2023
# │   ├── entrate
# │   └── uscite
# └── 2024
#     ├── entrate
#     └── uscite
```

**Spiegazione:** Le parentesi graffe `{}` permettono di espandere più valori. Bash espande:
- `archivio/2022/entrate`
- `archivio/2022/uscite`
- `archivio/2023/entrate`
- ... e così via

</details>

---

## Blocco 4 - Eliminare directory e file

### Obiettivo

Imparare a rimuovere file e directory, con le dovute cautele.

### Ingredienti

| Comando | Descrizione |
|---------|-------------|
| `rm <file>` | **R**e**m**ove - elimina un file |
| `rm -r <directory>` | Elimina una directory e tutto il suo contenuto (ricorsivo) |
| `rm -i <file>` | Chiede conferma prima di eliminare |
| `rmdir <directory>` | Elimina una directory solo se è vuota |

### Come usarli

```bash
rm documento.txt            # elimina il file documento.txt
rm file1.txt file2.txt      # elimina più file
rm -i importante.txt        # chiede conferma: "remove importante.txt?"
rmdir cartella_vuota        # elimina solo se la cartella è vuota
rm -r cartella              # elimina la cartella e tutto ciò che contiene
```

⚠️ **Attenzione:** `rm` non sposta i file nel cestino, li elimina definitivamente! Usa `rm -i` se non sei sicuro.

### Esercizio 4.1

Dalla cartella `sandbox`:

1. Entra nella cartella `test` (creata nel Blocco 3)
2. Prova a eliminare la directory `alfa` usando `rmdir`. Funziona?
3. Verifica con `ls` che `alfa` sia stata eliminata

<details>
<summary>Solo dopo aver svolto l'esercizio, apri qui per vedere la soluzione</summary>

```bash
cd /workspaces/Lezione_Bash01/sandbox/test

rmdir alfa

ls
# Output: beta  gamma
```

Sì, funziona perché `alfa` è vuota.

</details>

---

### Esercizio 4.2

Dalla cartella `sandbox`:

1. Prova a eliminare la directory `livello1` usando `rmdir`. Cosa succede?
2. Ora eliminala con il comando corretto
3. Verifica che sia stata eliminata

<details>
<summary>Solo dopo aver svolto l'esercizio, apri qui per vedere la soluzione</summary>

```bash
cd /workspaces/Lezione_Bash01/sandbox

rmdir livello1
# Errore: rmdir: failed to remove 'livello1': Directory not empty

rm -r livello1

ls
# livello1 non compare più
```

`rmdir` fallisce perché `livello1` contiene `livello2`. Con `rm -r` eliminiamo tutto ricorsivamente.

</details>

---

### Esercizio 4.3

Dalla cartella `sandbox`:

1. Elimina l'intera struttura `archivio` creata nel Blocco 3
2. Elimina la cartella `test` con tutto il suo contenuto
3. Verifica che `sandbox` sia vuota

<details>
<summary>Solo dopo aver svolto l'esercizio, apri qui per vedere la soluzione</summary>

```bash
cd /workspaces/Lezione_Bash01/sandbox

rm -r archivio

rm -r test

ls
# Output: (nessun output, la cartella è vuota)
```

</details>

---

## Blocco 5 - Esplorare il contenuto delle directory

### Obiettivo

Imparare a visualizzare il contenuto delle directory in modi diversi: lista semplice, dettagliata, con file nascosti.

### Ingredienti

| Comando | Descrizione |
|---------|-------------|
| `ls` | Lista semplice del contenuto |
| `ls -l` | Lista dettagliata (permessi, proprietario, dimensione, data) |
| `ls -a` | Mostra anche i file nascosti (quelli che iniziano con `.`) |
| `ls -la` | Combina: lista dettagliata con file nascosti |
| `ls <percorso>` | Mostra il contenuto di una directory senza entrarci |

### Come usarli

```bash
ls                          # contenuto directory corrente
ls -l                       # dettagli: permessi, owner, size, data
ls -a                       # include file nascosti (.bashrc, .git, ecc.)
ls -la                      # dettagli + nascosti
ls esercizi/documenti       # contenuto di una directory specifica
```

### Leggere l'output di `ls -l`

```
-rw-r--r-- 1 utente gruppo 1234 gen 15 10:30 documento.txt
│└──┬───┘   └──┬──┘ └──┬─┘ └─┬┘ └────┬─────┘ └─────┬──────┘
│   │          │       │     │       │             │
│   │          │       │     │       │             └─ nome file
│   │          │       │     │       └─ data ultima modifica
│   │          │       │     └─ dimensione in byte
│   │          │       └─ gruppo proprietario
│   │          └─ utente proprietario
│   └─ permessi (rwx per owner, group, others)
└─ tipo (- = file, d = directory)
```

### Esercizio 5.1

1. Vai nella cartella `esercizi`
2. Visualizza il contenuto con `ls`
3. Visualizza il contenuto in formato dettagliato
4. Cosa noti di diverso nell'output?

<details>
<summary>Solo dopo aver svolto l'esercizio, apri qui per vedere la soluzione</summary>

```bash
cd /workspaces/Lezione_Bash01/esercizi

ls
# Output: documenti  immagini  permessi  progetti

ls -l
# Output:
# drwxr-xr-x 4 codespace codespace 4096 gen 20 10:00 documenti
# drwxr-xr-x 4 codespace codespace 4096 gen 20 10:00 immagini
# drwxr-xr-x 2 codespace codespace 4096 gen 20 10:00 permessi
# drwxr-xr-x 3 codespace codespace 4096 gen 20 10:00 progetti
```

Con `ls -l` vedi: il tipo (`d` = directory), i permessi, il proprietario, la dimensione e la data.

</details>

---

### Esercizio 5.2

1. Vai nella tua home directory (`~`)
2. Confronta l'output di `ls` e `ls -a`
3. Quanti file nascosti trovi?

<details>
<summary>Solo dopo aver svolto l'esercizio, apri qui per vedere la soluzione</summary>

```bash
cd ~

ls
# Output: (varia, potresti vedere alcune cartelle)

ls -a
# Output: .  ..  .bashrc  .profile  .config  .local  ... (e altri)
```

I file che iniziano con `.` sono nascosti. Noterai anche `.` (directory corrente) e `..` (directory genitore).

</details>

---

### Esercizio 5.3

Senza spostarti dalla directory corrente:

1. Visualizza il contenuto dettagliato di `esercizi/permessi`
2. Osserva i permessi dei vari file: quali differenze noti?

<details>
<summary>Solo dopo aver svolto l'esercizio, apri qui per vedere la soluzione</summary>

```bash
ls -l /workspaces/Lezione_Bash01/esercizi/permessi
# Output:
# -rwxr-xr-x 1 codespace codespace  ... eseguibile.sh
# -rw-r--r-- 1 codespace codespace  ... non_eseguibile.sh
# -rw------- 1 codespace codespace  ... privato.txt
# -rw-r--r-- 1 codespace codespace  ... pubblico.txt
# ---------- 1 codespace codespace  ... segreto.txt
```

Differenze:
- `eseguibile.sh` ha la `x` (permesso di esecuzione)
- `privato.txt` ha `rw-------` (solo il proprietario può leggere/scrivere)
- `segreto.txt` ha `----------` (nessun permesso per nessuno)

</details>

---

## Blocco 6 - Capire i permessi

### Obiettivo

Comprendere come funzionano i permessi in Linux: chi può leggere, scrivere, eseguire un file.

### I tre tipi di permesso

| Simbolo | Permesso | Su un file | Su una directory |
|---------|----------|------------|------------------|
| `r` | Read | Leggere il contenuto | Elencare il contenuto (`ls`) |
| `w` | Write | Modificare il file | Creare/eliminare file dentro |
| `x` | Execute | Eseguire come programma | Entrare nella directory (`cd`) |

### I tre livelli di utente

| Posizione | Chi |
|-----------|-----|
| Owner (u) | Il proprietario del file |
| Group (g) | Gli utenti del gruppo |
| Others (o) | Tutti gli altri |

### Leggere i permessi

```
-rwxr-xr--
│└┬┘└┬┘└┬┘
│ │  │  └─ others: r-- (solo lettura)
│ │  └──── group:  r-x (lettura + esecuzione)
│ └─────── owner:  rwx (lettura + scrittura + esecuzione)
└───────── tipo: - (file) oppure d (directory)
```

### Esercizio 6.1

Vai nella cartella `esercizi/permessi` e rispondi a queste domande osservando l'output di `ls -l`:

1. Quali permessi ha `pubblico.txt`? Chi può leggerlo?
2. Quali permessi ha `privato.txt`? Chi può leggerlo?
3. Quali permessi ha `segreto.txt`?

<details>
<summary>Solo dopo aver svolto l'esercizio, apri qui per vedere la soluzione</summary>

```bash
cd /workspaces/Lezione_Bash01/esercizi/permessi

ls -l
```

Risposte:

1. `pubblico.txt` ha `-rw-r--r--`:
   - Owner: `rw-` (lettura e scrittura)
   - Group: `r--` (solo lettura)
   - Others: `r--` (solo lettura)
   - **Tutti possono leggerlo**, solo il proprietario può modificarlo

2. `privato.txt` ha `-rw-------`:
   - Owner: `rw-` (lettura e scrittura)
   - Group: `---` (nessun permesso)
   - Others: `---` (nessun permesso)
   - **Solo il proprietario può leggerlo e modificarlo**

3. `segreto.txt` ha `----------`:
   - Nessuno ha permessi (nemmeno il proprietario!)
   - Per accedervi, bisogna prima modificare i permessi

</details>

---

### Esercizio 6.2

Prova a eseguire questi comandi nella cartella `esercizi/permessi`:

1. `cat pubblico.txt` - Funziona?
2. `cat privato.txt` - Funziona?
3. `cat segreto.txt` - Funziona?
4. `./eseguibile.sh` - Funziona?
5. `./non_eseguibile.sh` - Funziona?

<details>
<summary>Solo dopo aver svolto l'esercizio, apri qui per vedere la soluzione</summary>

```bash
cd /workspaces/Lezione_Bash01/esercizi/permessi

cat pubblico.txt
# Output: File pubblico - tutti possono leggere
# ✅ Funziona

cat privato.txt
# Output: File privato - solo il proprietario
# ✅ Funziona (sei il proprietario)

cat segreto.txt
# Errore: Permission denied
# ❌ Non funziona (nessun permesso di lettura)

./eseguibile.sh
# Output: Sono eseguibile!
# ✅ Funziona (ha il permesso x)

./non_eseguibile.sh
# Errore: Permission denied
# ❌ Non funziona (non ha il permesso x)
```

</details>

---

### Esercizio 6.3

Osserva i permessi delle directory in `esercizi/`:

1. Che permessi hanno le directory?
2. Cosa succederebbe se una directory non avesse il permesso `x`?

<details>
<summary>Solo dopo aver svolto l'esercizio, apri qui per vedere la soluzione</summary>

```bash
ls -l /workspaces/Lezione_Bash01/esercizi
# Output:
# drwxr-xr-x ... documenti
# drwxr-xr-x ... immagini
# drwxr-xr-x ... permessi
# drwxr-xr-x ... progetti
```

Le directory hanno `rwxr-xr-x`:
- Owner: può leggere, modificare, entrare
- Group e Others: possono leggere ed entrare, ma non modificare

**Senza il permesso `x` su una directory:**
- Non puoi entrarci con `cd`
- Non puoi accedere ai file al suo interno (anche se hanno permessi di lettura)

Il permesso `x` su una directory significa "attraversamento": senza di esso, la directory è inaccessibile.

</details>

---

## Blocco 7 - Modificare i permessi

### Obiettivo

Imparare a cambiare i permessi dei file usando `chmod` con la notazione simbolica.

### Ingredienti

| Comando | Descrizione |
|---------|-------------|
| `chmod <permessi> <file>` | **Ch**ange **Mod**e - modifica i permessi di un file |

### Notazione simbolica

```bash
chmod u+x file.sh           # aggiungi esecuzione al proprietario (user)
chmod g-w file.txt          # rimuovi scrittura al gruppo
chmod o=r file.txt          # imposta solo lettura per gli altri
chmod a+r file.txt          # aggiungi lettura a tutti (all)
chmod u+x,g-w file.sh       # combinazioni multiple
```

| Simbolo | Significato |
|---------|-------------|
| `u` | User (proprietario) |
| `g` | Group (gruppo) |
| `o` | Others (altri) |
| `a` | All (tutti) |
| `+` | Aggiungi permesso |
| `-` | Rimuovi permesso |
| `=` | Imposta esattamente |

### Esercizio 7.1

Vai nella cartella `esercizi/permessi`:

1. Prova a leggere `segreto.txt` con `cat`. Cosa succede?
2. Aggiungi il permesso di lettura per il proprietario
3. Ora prova di nuovo a leggere il file

<details>
<summary>Solo dopo aver svolto l'esercizio, apri qui per vedere la soluzione</summary>

```bash
cd /workspaces/Lezione_Bash01/esercizi/permessi

cat segreto.txt
# Errore: Permission denied

chmod u+r segreto.txt

cat segreto.txt
# Output: File segreto - nessun permesso
```

</details>

---

### Esercizio 7.2

Nella cartella `esercizi/permessi`:

1. Rendi `non_eseguibile.sh` eseguibile
2. Eseguilo con `./non_eseguibile.sh`
3. Verifica i nuovi permessi con `ls -l`

<details>
<summary>Solo dopo aver svolto l'esercizio, apri qui per vedere la soluzione</summary>

```bash
cd /workspaces/Lezione_Bash01/esercizi/permessi

chmod u+x non_eseguibile.sh

./non_eseguibile.sh
# Output: Script non eseguibile

ls -l non_eseguibile.sh
# Output: -rwxr--r-- ... non_eseguibile.sh
```

Ora ha la `x` nei permessi del proprietario.

</details>

---

### Esercizio 7.3

Crea nella cartella `sandbox` un nuovo script e rendilo eseguibile:

1. Crea un file `saluta.sh` che stampa "Ciao, sono uno script!"
2. Prova ad eseguirlo. Funziona?
3. Rendilo eseguibile e prova di nuovo

<details>
<summary>Solo dopo aver svolto l'esercizio, apri qui per vedere la soluzione</summary>

```bash
cd /workspaces/Lezione_Bash01/sandbox

echo '#!/bin/bash
echo "Ciao, sono uno script!"' > saluta.sh

./saluta.sh
# Errore: Permission denied

chmod +x saluta.sh

./saluta.sh
# Output: Ciao, sono uno script!
```

**Nota:** `chmod +x` è una scorciatoia per `chmod a+x` (aggiunge esecuzione a tutti).

</details>

---

## Esercizi extra

Questi esercizi combinano quanto appreso nei blocchi precedenti. Prova a risolverli senza guardare subito la soluzione.

### Extra 1 - Costruisci e demolisci

1. Nella cartella `sandbox`, crea con un solo comando questa struttura:

```
azienda/
├── amministrazione/
│   ├── fatture/
│   └── contratti/
├── sviluppo/
│   ├── frontend/
│   └── backend/
└── risorse_umane/
    ├── assunzioni/
    └── stipendi/
```

2. Verifica con `tree`
3. Elimina l'intera struttura con un solo comando

<details>
<summary>Solo dopo aver svolto l'esercizio, apri qui per vedere la soluzione</summary>

```bash
cd /workspaces/Lezione_Bash01/sandbox

mkdir -p azienda/{amministrazione/{fatture,contratti},sviluppo/{frontend,backend},risorse_umane/{assunzioni,stipendi}}

tree azienda
# Output:
# azienda
# ├── amministrazione
# │   ├── contratti
# │   └── fatture
# ├── risorse_umane
# │   ├── assunzioni
# │   └── stipendi
# └── sviluppo
#     ├── backend
#     └── frontend

rm -r azienda
```

</details>

---

### Extra 2 - Caccia ai permessi

Esplora la cartella `esercizi` e rispondi:

1. Trova tutti i file che hanno il permesso di esecuzione
2. Trova il file che non ha nessun permesso

<details>
<summary>Solo dopo aver svolto l'esercizio, apri qui per vedere la soluzione</summary>

```bash
ls -l esercizi/permessi/

# File con permesso di esecuzione (hanno la x):
# -rwxr-xr-x ... eseguibile.sh

# File senza nessun permesso:
# ---------- ... segreto.txt
```

</details>

---

### Extra 3 - Lo script segreto

1. Nella cartella `sandbox`, crea uno script `segreto.sh` che stampa "Hai scoperto il segreto!"
2. Imposta i permessi in modo che solo il proprietario possa leggerlo ed eseguirlo (nessun permesso per group e others)
3. Eseguilo per verificare che funzioni
4. Verifica i permessi con `ls -l`

<details>
<summary>Solo dopo aver svolto l'esercizio, apri qui per vedere la soluzione</summary>

```bash
cd /workspaces/Lezione_Bash01/sandbox

cat << 'EOF' > segreto.sh
#!/bin/bash
echo "Hai scoperto il segreto!"
EOF

chmod u=rwx,go= segreto.sh

./segreto.sh
# Output: Hai scoperto il segreto!

ls -l segreto.sh
# Output: -rwx------ ... segreto.sh
```

**Spiegazione:** `u=rwx,go=` significa:
- `u=rwx` → owner: lettura, scrittura, esecuzione
- `go=` → group e others: nessun permesso

</details>

---

## Riepilogo comandi

| Comando | Descrizione |
|---------|-------------|
| `pwd` | Mostra la directory corrente |
| `ls` | Elenca il contenuto della directory |
| `ls -l` | Elenca con dettagli (permessi, owner, dimensione) |
| `ls -a` | Elenca includendo i file nascosti |
| `cd <percorso>` | Cambia directory |
| `cd ..` | Sali di un livello |
| `cd ~` | Vai alla home directory |
| `cd -` | Torna alla directory precedente |
| `mkdir <nome>` | Crea una directory |
| `mkdir -p <percorso>` | Crea directory annidate |
| `rm <file>` | Elimina un file |
| `rm -r <directory>` | Elimina una directory e il suo contenuto |
| `rmdir <directory>` | Elimina una directory vuota |
| `tree <percorso>` | Visualizza la struttura ad albero |
| `chmod <permessi> <file>` | Modifica i permessi |

### Simboli per i path

| Simbolo | Significato |
|---------|-------------|
| `/` | Radice del filesystem |
| `.` | Directory corrente |
| `..` | Directory genitore |
| `~` | Home directory |

### Simboli per chmod

| Simbolo | Significato |
|---------|-------------|
| `u` | User (proprietario) |
| `g` | Group (gruppo) |
| `o` | Others (altri) |
| `a` | All (tutti) |
| `r` | Read (lettura) |
| `w` | Write (scrittura) |
| `x` | Execute (esecuzione) |
| `+` | Aggiungi permesso |
| `-` | Rimuovi permesso |
| `=` | Imposta esattamente |