-- ============================================
--Puhastamisraport Toomasele
-- ============================================
--Duplikaatide kokkuvõte-raport
-- Duplikaatide ülevaade kõigis tabelites
SELECT 'sales' AS tabel,
    COUNT(*) AS ridu_kokku,
    COUNT(DISTINCT sale_id) AS unikaalseid,
    COUNT(*) - COUNT(DISTINCT sale_id) AS duplikaate
FROM sales
UNION ALL
SELECT 'customers',
    COUNT(*),
    COUNT(DISTINCT email),
    -- COUNT(DISTINCT ...) jätab NULL-id vahele, seega loetaks e-mailita klient
    -- duplikaadiks. Lahutame need maha: õige arv on 130, mitte 510.
    COUNT(*) - COUNT(DISTINCT email) - COUNT(*) FILTER (WHERE email IS NULL)
FROM customers
UNION ALL
SELECT 'products',
    COUNT(*),
    COUNT(DISTINCT product_name),
    -- koopiatel on uus product_id, aga sama nimi: loe nime järgi
    COUNT(*) - COUNT(DISTINCT product_name)
FROM products; --5116 duplikaati müügitabelist, 130 klienditabelist ja 12 toodete tabelist

-- ============================================
--NULL väärtuste raport
-- NULL väärtuste raport olulistes veergudes
SELECT 'customers' AS tabel, 'first_name' AS veerg,
       COUNT(*) - COUNT(first_name) AS null_arv
FROM customers
UNION ALL
SELECT 'customers', 'last_name', COUNT(*) - COUNT(last_name) FROM customers
UNION ALL
SELECT 'customers', 'email', COUNT(*) - COUNT(email) FROM customers
UNION ALL
SELECT 'customers', 'phone', COUNT(*) - COUNT(phone) FROM customers
UNION ALL
SELECT 'sales', 'customer_id', COUNT(*) - COUNT(customer_id) FROM sales
UNION ALL
SELECT 'sales', 'total_price', COUNT(*) - COUNT(total_price) FROM sales
UNION ALL
SELECT 'products', 'retail_price', COUNT(*) - COUNT(retail_price) FROM products
ORDER BY tabel, veerg; --Toomase jaoks: “Kõige rohkem puuduvaid väärtusi on sales tabelis, kus customer_id kirjel puudub 1487.”

-- ============================================
--Formaatide diagnostika
-- Formaatide diagnostika: linnade kirjaviisid ja puhastatud versioonid
SELECT DISTINCT
    city AS originaal,
    INITCAP(TRIM(city)) AS puhastatud
FROM customers
WHERE city IS NOT NULL
ORDER BY puhastatud, originaal;

SELECT COUNT(DISTINCT city) AS ebajarjekindlaid
FROM customers
WHERE city IS NOT NULL
  AND city <> INITCAP(TRIM(city)); --Toomase jaoks: “Leidsime 42 ebajärjekindlat linnanimede kirjaviisi, mis tuleb ühtlustada.”

-- ============================================
--Küsimus 10
--Kirjuta SQL päring, mis näitab iga linna kohta: klientide arvu, puuduvate e-mailide arvu ja protsentuaalselt, kui suur osa klientidest on puuduva e-mailiga. Kasuta customers tabelit ja grupeeri puhastatud linnanime järgi.
SELECT
    INITCAP(TRIM(city)) AS linn,
    COUNT(*) AS kliente,
    COUNT(*) - COUNT(email) AS email_puudub,
    ROUND(100.0 * (COUNT(*) - COUNT(email)) / COUNT(*), 1) AS puudub_protsent
FROM customers
WHERE city IS NOT NULL
GROUP BY INITCAP(TRIM(city))
ORDER BY puudub_protsent DESC;

