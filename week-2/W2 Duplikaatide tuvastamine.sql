-- ============================================
--Duplikaatide tuvastamine
-- ============================================
-- Leia duplikaatsed sale_id väärtused
SELECT
    sale_id,
    COUNT(*) AS koopiate_arv
FROM sales
GROUP BY sale_id
HAVING COUNT(*) > 1
ORDER BY koopiate_arv DESC;
--Kuidas see töötab: GROUP BY sale_id: grupeeri read sale_id kaupa, HAVING COUNT(*) > 1: näita ainult gruppe, kus on rohkem kui 1 rida, Tulemus: iga duplikaatne sale_id ja mitu koopiat sellest on
--Oluline: WHERE filtreerib RIDU enne grupeerimist, HAVING filtreerib GRUPPE pärast grupeerimist. Duplikaatide leidmisel kasuta alati HAVING.
-- ============================================
-- Anna igale reale number oma grupi sees
SELECT
    sale_id,
    customer_id,
    total_price,
    sale_date,
    ROW_NUMBER() OVER (PARTITION BY sale_id ORDER BY sale_date) AS rn
FROM sales;
--Kuidas see töötab: PARTITION BY sale_id: jaga read gruppidesse sale_id kaupa, ORDER BY sale_date: iga grupi sees nummerdatakse kuupäeva järgi, rn = 1 on esimene (vanim) rida: see on "originaal", rn > 1 on duplikaadid: need tuleks eemaldada
-- ============================================
--Harjutus 1.3
-- ============================================
-- 1A.Leia kõik duplikaatsed sale_id väärtused sales tabelis
SELECT
    sale_id,
    COUNT(*) AS koopiate_arv
FROM sales
GROUP BY sale_id
HAVING COUNT(*) > 1
ORDER BY koopiate_arv DESC
LIMIT 10;
-- Duplikaatide mõju müüginumbritele
SELECT
    COUNT(*) AS ridu_kokku,
    COUNT(DISTINCT sale_id) AS unikaalseid,
    COUNT(*) - COUNT(DISTINCT sale_id) AS duplikaate,
    SUM(total_price) AS summa_duplikaatidega,
    (SELECT SUM(total_price) FROM (
        SELECT DISTINCT ON (sale_id) total_price
        FROM sales
        ORDER BY sale_id, id   -- iga müügi väikseima id-ga rida = originaal
    ) unikaalsed) AS summa_ilma_duplikaatideta
FROM sales;
-- ============================================
--1B.ROW NUMBER kasutamine
--Ülesanne: Kirjuta päring, mis kasutab ROW_NUMBER() funktsiooni, et nummerdada customers tabeli read email veeru järgi. Nii leiad kliendid, kellel on sama e-mail mitu korda.
SELECT * FROM (
    SELECT
        customer_id,
        first_name,
        last_name,
        email,
        ROW_NUMBER() OVER (PARTITION BY email ORDER BY customer_id) AS rn
    FROM customers
    WHERE email IS NOT NULL
) numbered
WHERE rn > 1
ORDER BY email;
-- ============================================
--1C. Oma duplikaatide audit
-- Duplikaatide audit: customers tabel, duplikaadi alus = email
SELECT
    email,
    COUNT(*) AS koopiate_arv
FROM customers
WHERE email IS NOT NULL
GROUP BY email
HAVING COUNT(*) > 1
ORDER BY koopiate_arv DESC;

-- Duplikaatide audit: products tabel, duplikaadi alus = toote nimi
SELECT
    product_name,
    COUNT(*) AS koopiate_arv
FROM products
GROUP BY product_name
HAVING COUNT(*) > 1
ORDER BY koopiate_arv DESC;

SELECT
    COUNT(*) AS duplikeeritud_emaile,
    SUM(koopiate_arv - 1) AS lisaridu_kokku
FROM (
    SELECT email, COUNT(*) AS koopiate_arv
    FROM customers
    WHERE email IS NOT NULL
    GROUP BY email
    HAVING COUNT(*) > 1
) t;


