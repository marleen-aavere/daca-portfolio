-- ============================================
-- Roll: Müügiandmete puhastaja
-- Eesmärk: Leia duplikaadid, NULL väärtused ja vigased kuupäevad sales tabelis. Loo test koopia, puhasta ja dokumenteeri kõik muudatused.
-- Autor: Marleen Aavere
-- Kuupäev: 2024-11-17
-- ============================================
-- Samm 1
-- ============================================
--Loo test koopia
DROP TABLE IF EXISTS sales_test;
CREATE TABLE sales_test AS SELECT * FROM sales;
-- Uus veerg id loomine
ALTER TABLE sales_test ADD COLUMN IF NOT EXISTS id SERIAL;
-- Kontrolli ridade arvu
SELECT COUNT(*) AS ridade_arv FROM sales_test; -- Ridade arv  15234
-- ============================================
-- Samm 2
-- ============================================
-- Leia duplikaadid
SELECT invoice_id, COUNT(*) AS koopiate_arv
FROM sales_test
GROUP BY invoice_id
HAVING COUNT(*) > 1
ORDER BY koopiate_arv DESC; -- 4013 duplikaatset invoice_id
-- ============================================
-- Samm 3
-- ============================================
-- Duplikaatsete ridade arv
SELECT COUNT(*) AS duplikaat_read
FROM sales_test
WHERE id NOT IN (
    SELECT MIN(id)
    FROM sales_test
    GROUP BY invoice_id
); -- 5116 rida on duplikaadid
-- ============================================
-- Samm 4
-- ============================================
-- NULL väärtused kriitilistes väljades
SELECT
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS null_customer_id,
    COUNT(*) FILTER (WHERE sale_date IS NULL) AS null_sale_date,
    COUNT(*) FILTER (WHERE total_price IS NULL) AS null_total_price
FROM sales_test; --1487 NULL customer_id, 0 NULL sale_date, 0 NULL total_price
-- ============================================
-- Samm 5
-- ============================================
-- Kontrolli kuupäevade formaati — kas on tuleviku kuupäevi?
SELECT COUNT(*) AS tuleviku_kuupaevad
FROM sales_test
WHERE sale_date > CURRENT_DATE
   OR sale_date < DATE '2020-01-01';   -- UrbanStyle.ltd asutati 2020. Vastus: 0 võimatut kuupäeva

SELECT COUNT(*) AS tuleviku_kuupaevad
FROM sales_test
WHERE sale_date > DATE '2025-02-28'
   OR sale_date < DATE '2020-01-01'; -- 50 kuupäeva pärast andmete lõppu
-- ============================================
-- Samm 6
-- ============================================
-- Koosta puhastamisraport
-- NULL väärtused
SELECT COUNT(*) FROM sales_test WHERE customer_id IS NULL; -- 1487
SELECT COUNT(*) FROM sales_test WHERE sale_date IS NULL; -- 0
SELECT COUNT(*) FROM sales_test WHERE total_price IS NULL; --0
-- Võimatud kuupäevad
SELECT COUNT(*) AS tuleviku_kuupaevad
FROM sales_test
WHERE sale_date > CURRENT_DATE
   OR sale_date < DATE '2020-01-01'; -- 0
-- Kuupäevad pärast andmete lõppu
SELECT COUNT(*) AS parast_andmete_loppu
FROM sales_test
WHERE sale_date > DATE '2025-02-28'; --50
-- Duplikaadid
SELECT COUNT(*) AS duplikaat_read
FROM sales_test
WHERE id NOT IN (
    SELECT MIN(id)
    FROM sales_test
    GROUP BY invoice_id
); -- 5116

-- AI loodud päring puhastamisraportile
SELECT
    (SELECT COUNT(*) FROM sales_test
       WHERE id NOT IN (SELECT MIN(id) FROM sales_test GROUP BY invoice_id)) AS duplikaat_read,
    COUNT(CASE WHEN customer_id IS NULL THEN 1 END) AS null_customer_id,
    COUNT(CASE WHEN sale_date IS NULL THEN 1 END)   AS null_sale_date,
    COUNT(CASE WHEN total_price IS NULL THEN 1 END) AS null_total_price,
    COUNT(CASE WHEN sale_date > CURRENT_DATE
                 OR sale_date < DATE '2020-01-01' THEN 1 END) AS tuleviku_kuupaevad,
    COUNT(CASE WHEN sale_date > DATE '2025-02-28' THEN 1 END)  AS parast_andmete_loppu
FROM sales_test;

-- ============================================
-- Edasijõudnud tase
-- ============================================
-- Kustuta duplikaadid (jäta alles ainult esimene rida iga invoice_id kohta)
DELETE FROM sales_test
WHERE id NOT IN (
    SELECT MIN(id)
    FROM sales_test
    GROUP BY invoice_id
);
-- Kontroll: ridade arv peaks nüüd olema unikaalsete invoice_id arv (10 118)
SELECT COUNT(*) AS pärast FROM sales_test; -- on 10 118

-- Dokumenteeri NULL customer_id (need on külalisostud — kehtiv äriloogika!)
-- NB: NULL tähendab siin "tundmatu klient / külalisost", MITTE andmeviga.
-- Vaata, kui palju neid on:
SELECT COUNT(*) AS külalisostud FROM sales_test WHERE customer_id IS NULL; -- 988 NULL customer_id ("tundmatu klient / külalisost")
-- Analüüsis kasuta COALESCE, et anda neile ajutine silt:
SELECT COALESCE(customer_id, -1) AS customer_id_puhas 
FROM sales_test;

-- Kuupäevi EI parandata: vigased (pärast andmete lõppu) märgi ja jäta analüüsist välja
SELECT COUNT(*) AS vigased_kuupaevad
FROM sales_test 
WHERE sale_date > DATE '2025-02-28'; -- 32

-- Analüüsis: 
SELECT COUNT(*) AS vigased_kuupaevad
FROM sales_test 
WHERE sale_date <= DATE '2025-02-28' -- 10086

-- Kontrolli tulemust
SELECT COUNT(*) AS ridu_parast FROM sales_test; -- Pärast duplikaatide eemaldamist jäi 10 118 unikaalset rida. Neist 32 on vigase kuupäevaga (märgitud, mitte kustutatud) ja 10 086 sobib analüüsiks.
