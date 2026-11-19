-- ============================================
--NULL väärtused
-- ============================================
--NULL: info puudu, näide kliendi emaili pole kunagi sisestatud
--'' (tühi string): sisestatud, aga tühi, näide klient jättis emaili välja tühjaks
--0 ehk number null, näide kliendi tellimuste summa on null
-- ============================================
--NULL väärtuste leidmiseks kasutad IS NULL (mitte = NULL!)
-- Leia tellimused, kus klient on teadmata
SELECT sale_id, customer_id, total_price
FROM sales
WHERE customer_id IS NULL;

-- Leia kliendid, kellel ON e-mail olemas
SELECT customer_id, first_name, email
FROM customers
WHERE email IS NOT NULL;

-- ============================================
--COALESCE(): asendusväärtus NULL-ile. COALESCE võtab mitu argumenti ja tagastab esimese, mis EI OLE NULL
-- Asenda puuduv kliendi nimi vaikeväärtusega
SELECT
    customer_id,
    COALESCE(first_name, 'Tundmatu') AS eesnimi,
    COALESCE(email, 'puudub@urbanstyle.ee') AS email
FROM customers;

-- Mitu asendusväärtust (valib esimese mitte-NULL väärtuse)
SELECT COALESCE(NULL, NULL, 'Kolmas valik');
-- Tulemus: 'Kolmas valik'

-- ============================================
--NULLIF(): vastupidine tööriist. NULLIF võrdleb kahte väärtust. Kui need on võrdsed, tagastab NULL
-- NULLIF(a, b): kui a = b, tagastab NULL; muidu tagastab a
SELECT NULLIF(100, 100);  -- Tulemus: NULL
SELECT NULLIF(100, 200);  -- Tulemus: 100
-- Muuda 0-hinnaga tooted NULL-iks (hind pole tegelikult 0, vaid puudub)
SELECT
    product_id,
    product_name,
    NULLIF(retail_price, 0) AS puhas_hind
FROM products;

-- ============================================
--NULL matemaatikas: NULL + 5 = NULL
SELECT 100 + NULL;      -- Tulemus: NULL
SELECT NULL * 5;        -- Tulemus: NULL
SELECT SUM(total_price) FROM sales;   -- SUM ignoreerib NULL-e (AVG(veerg) samuti ignoreerib NULL-e)

-- ============================================
--2.3 NULL harjutused
-- ============================================
--2A
-- NULL-ide ülevaade customers tabelis
SELECT
    COUNT(*) AS kliente_kokku,
    COUNT(first_name) AS eesnimi_olemas,
    COUNT(*) - COUNT(first_name) AS eesnimi_puudub,
    COUNT(email) AS email_olemas,
    COUNT(*) - COUNT(email) AS email_puudub,
    COUNT(phone) AS telefon_olemas,
    COUNT(*) - COUNT(phone) AS telefon_puudub
FROM customers; --kliente, eesnimi olemas ja telefon olemas 3150, email olemas 2770, email puudu 380

-- Kliendid, kellel puudub nimi VÕI e-mail
SELECT customer_id, first_name, last_name, email, city
FROM customers
WHERE first_name IS NULL
   OR last_name IS NULL
   OR email IS NULL
ORDER BY customer_id
LIMIT 15;
-- ============================================
--2B. Ülesanne: Liis Koppel tahab näha kõiki kliente, aga tühjade nimede asemel peaks kuvama “Tundmatu klient”. Kirjuta päring, mis kasutab COALESCE funktsiooni
SELECT
    customer_id,
    COALESCE(first_name, 'Tundmatu') AS eesnimi,
    COALESCE(last_name, '') AS perekonnanimi,
    COALESCE(email, 'puudub') AS email,
    COALESCE(phone, 'puudub') AS telefon
FROM customers
WHERE first_name IS NULL
   OR last_name IS NULL
   OR email IS NULL
   OR phone IS NULL
ORDER BY customer_id;

-- ============================================
--2C. Ülesanne: Kontrolli, kas NULL-id mõjutavad sales tabeli arvutusi. Võrdle tulemusi
-- Võrdlus: SUM kõigist vs SUM mitte-NULL väärtustest
SELECT
    COUNT(*) AS ridu,
    COUNT(total_price) AS summa_olemas,
    COUNT(*) - COUNT(total_price) AS summa_puudub,
    SUM(total_price) AS kogusumma,
    AVG(total_price) AS keskmine
FROM sales;