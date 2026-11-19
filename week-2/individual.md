# Week 2 – SQL puhastamine

## Nädala 2 eesmärk

- Tuvastada ja eemaldada duplikaate, kasutades `GROUP BY` + `HAVING` ja `ROW_NUMBER()`
- Leida ja käsitleda NULL väärtusi, kasutades `IS NULL`, `COALESCE()` ja `NULLIF()`
- Puhastada ja ühtlustada andmevälju, kasutades `CAST`, `TRIM()`, `UPPER()`/`LOWER()` ja kuupäevafunktsioone

## Mida ma tegin?

### Individual

- NotebookLM märkmikku "DACA Õppematerjalid" lisatud 2 RAG faili juurde, kokku 8 faili
- Harjutused duplikaatide tuvastamisel — kuidas `GROUP BY` + `HAVING` ja `ROW_NUMBER()` aitavad leida topeltridu
- Harjutused NULL väärtuste käsitlemisel — kuidas `IS NULL`, `COALESCE` ja `NULLIF` muudavad puuduvad andmed hallatavaks
- Harjutused andmeformaatide ühtlustamisel — kuidas `TRIM`, `INITCAP` ja `TO_CHAR` tagavad, et andmed on korrektsed
- Puhastamisraport Toomasele (duplikaatide raport, NULL väärtuste raport ja formaatide diagnostika)
- Lugesin raamatut
- Tegin harjutusi meie õppekeskkonnas Learn

### Grupitöö (Sales Analytics team)

- Roll: müügiandmete puhastaja
- Leidsin duplikaadid (5116), NULL väärtused (1487) ja vigased kuupäevad `sales_test` tabelist
- Lõin test koopia, puhastasin ja dokumenteerisin kõik muudatused
- Tegin presentatsiooni slaidid

## Mida ma õppisin?

- Duplikaatide tuvastamist: kuidas `GROUP BY` + `HAVING` ja `ROW_NUMBER()` aitavad leida topeltridu
- NULL väärtuste käsitlemist: kuidas `IS NULL`, `COALESCE` ja `NULLIF` muudavad puuduvad andmed hallatavaks
- Andmeformaatide ühtlustamist: kuidas `TRIM`, `INITCAP` ja `TO_CHAR` tagavad, et andmed on korrektsed
- Test koopia loomist ning kustutamist, andmeväljade puhastamist
