# Nädal 1 – Meeskonnatöö kokkuvõte (Sales Analytics)

## Meeskond

| Nimi | Roll (Nädal 1) |
|---|---|
| Marje Piirisild | A: Müügitehingud |
| Sigrid Nieländer | B: Kliendiandmed |
| Maarja Valmas | C: Tooteandmed |
| Marleen Aavere | D: Müügikanalid |

## Minu panus

- Analüüsisin UrbanStyle müügiandmete tabelit SQL päringute abil, uurides müügikanaleid, asukohti ja makseviise.
- Tuvastasin korduvad müügitehingud ja puuduvad asukohad.
- Hindasin leitud probleemide võimalikku mõju andmete usaldusväärsusele.

## Tulemused

- **2 müügikanalit:** online ja pood
- **4 asukohta:** Tallinn, Tartu, Pärnu ja NULL väärtusega read
- **3 makseviisi:** sularaha, kaart ja järelmaks
- **5204 tehingut ilma asukohata**

### Tehingute arv kanalite lõikes

| Kanal | Duplikaatidega | Ilma duplikaatideta |
|---|---:|---:|
| Pood | 10 030 | 6656 |
| Veeb | 5204 | 3462 |

### Tehingud kokku iga kaupluse kohta

| Kauplus | Duplikaatidega | Ilma duplikaatideta |
|---|---:|---:|
| Tallinn | 5704 | 3801 |
| Tartu | 2708 | 1791 |
| Pärnu | 1618 | 1058 |
