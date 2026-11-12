-- ============================================
-- Roll: Müügikanalite uurija
-- Eesmärk: Toomas tahab teada, milliste kanalite ja asukohtade kaudu UrbanStyle müüki teeb: millised müügikanalid on olemas? millistes kauplustes müüakse? milliseid makseviise kasutatakse? kas on tehinguid ilma asukoha infota?
-- Autor: Marleen Aavere
-- Kuupäev: 2024-11-12

-- ============================================
-- Päring 1: Millised müügikanalid, asukohad ja makseviisid on?
SELECT channel, store_location, payment_method
FROM sales
LIMIT 10; -- Müügikanalid: pood ja online, Asukohad: Tallinn, Tartu, Pärnu ja veebimüükide puhul NULL, Makseviisid: kaart, järelmaks ja sularaha

-- ============================================
-- Päring 2: Milliseid müügikanaleid UrbanStyle kasutab?
SELECT DISTINCT channel FROM sales; -- online ja pood

-- ============================================
-- Päring 3: Kus asuvad kõik UrbanStyle poed?
SELECT DISTINCT store_location FROM sales; --Tallinn, Pärnu, Tartu, NULL, mis tähendab seda, et andmebaas ei tea millises poes ost sooritati või on tegemist online müügiga või info läks andmete sisestamisel kaotsi, kontrollime:
SELECT DISTINCT channel
FROM sales
WHERE store_location IS NULL; --online tellimus

-- ============================================
-- Päring 4: Milliseid makseviise kliendid kasutavad?
SELECT DISTINCT payment_method FROM sales; -- järelmaks, kaart ja sularaha

-- ============================================
-- Päring 5: Leia tehingud, mis on tehtud veebipoe kaudu
SELECT * FROM sales
WHERE channel = 'online'
ORDER BY total_price DESC
LIMIT 15;

-- ============================================
--Päring 6: Leia tehingud ilma asukoha infota. Mitu tehingut on, kus kaupluse asukoht on puudu (NULL)?
SELECT COUNT(*) AS puudub_asukoht
FROM sales
WHERE store_location IS NULL; -- 5204 topeltridadega

SELECT COUNT(DISTINCT sale_id) AS puudub_asukoht
FROM sales
WHERE store_location IS NULL; --3462
-- ============================================
--KOKKUVÕTE. 2 müügikanalit: online ja pood, 4 asukohta: Tallinn, Tartu, Pärnu ja NULL, kus selgitasin välja, et tegemist on online müügiga, 3 makseviisi: sularaha, kaart ja järelmaks, 5204 tehingut ilma asukohata. Poodides on tehingute arv 10030 ehk 66 protsenti ja veebis 5204 ehk 34 protsenti.

-- ============================================
--LISAÜLESANNE
-- ============================================
-- Päring 7: Loe tehingud kokku iga kaupluse asukoha kohta
SELECT COUNT(*) AS tehinguid
FROM sales
WHERE store_location = 'Tartu'; --2708 topeltridadega

SELECT COUNT(DISTINCT invoice_id)  AS tehinguid
FROM sales
WHERE channel = 'pood' AND store_location = 'Tartu'; --1797

SELECT COUNT(*) AS tehinguid
FROM sales
WHERE store_location = 'Tallinn'; --5704 topeltridadega

SELECT COUNT(DISTINCT invoice_id)  AS tehinguid
FROM sales
WHERE channel = 'pood' AND store_location = 'Tallinn'; --3801

SELECT COUNT(*) AS tehinguid
FROM sales
WHERE store_location = 'Pärnu'; --1618 topeltridadega

SELECT COUNT(DISTINCT invoice_id)  AS tehinguid
FROM sales
WHERE channel = 'pood' AND store_location = 'Pärnu'; --1058

-- ============================================
-- Päring 8: Võrdle online vs pood tehingute arvu

-- Online-tehingute arv
SELECT COUNT(*) AS online_tehinguid
FROM sales
WHERE channel = 'online'; --5204 topeltridadega

SELECT COUNT(DISTINCT invoice_id)  AS tehinguid
FROM sales
WHERE channel = 'online'; --3462 

-- Poe-tehingute arv
SELECT COUNT(*) AS poe_tehinguid
FROM sales
WHERE channel = 'pood'; --10030 topeltridadega

SELECT COUNT(DISTINCT invoice_id)  AS tehinguid
FROM sales
WHERE channel = 'pood'; --6656 

-- ============================================
-- Päring 9: Kombineeri tingimused: Leia sularahamaksed Tartus
SELECT * FROM sales
WHERE payment_method = 'sularaha'
  AND store_location = 'Tartu'
ORDER BY total_price DESC
LIMIT 10;
