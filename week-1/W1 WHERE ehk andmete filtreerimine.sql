--ANDMETE FILTREERIMINE

-- UrbanStyle näide: müügid üle 100 euro
SELECT sale_id, total_price
FROM sales
WHERE total_price > 100
ORDER BY total_price DESC;

-- between
-- Müügid vahemikus 100-500 eurot
SELECT sale_id, total_price
FROM sales
WHERE total_price BETWEEN 100 AND 500;

-- in
-- Müügid Tallinna VÕI Tartu kauplustest
SELECT sale_id, total_price, channel
FROM sales
WHERE store_location IN ('Tallinn', 'Tartu');

--like
-- Kliendid, kelle nimi algab "K"-ga
SELECT customer_id, first_name, last_name
FROM customers
WHERE first_name LIKE 'K%';

--AND:mõlemad tingimused peavad olema tõesed
-- Suured müügid Tallinnast
SELECT sale_id, total_price, channel
FROM sales
WHERE total_price > 500 AND store_location = 'Tallinn';

--OR:vähemalt üks tingimus peab olema tõene
-- Müügid, mis on kas väga suured VÕI väga väikesed
SELECT sale_id, total_price
FROM sales
WHERE total_price > 500 OR total_price < 10;

--Oluline: AND ja OR kombineerides kasuta sulge, et vältida segadust
-- Selge järjekord sulgudega
SELECT sale_id, total_price, channel
FROM sales
WHERE (store_location = 'Tallinn' OR store_location = 'Tartu')
  AND total_price > 100;

--Harjutus 2a käivita ja kopeeri

--suured tellimused
SELECT sale_id, customer_id, total_price
FROM sales
WHERE total_price > 500
ORDER BY total_price DESC
LIMIT 10; --Mitu tellimust on üle 500 euro? 2499 (kood all)

SELECT COUNT(*)
FROM sales
WHERE total_price > 500;

--kindla perioodi müügid
SELECT sale_id, sale_date, total_price
FROM sales
WHERE sale_date BETWEEN '2024-01-01' AND '2024-03-31'
ORDER BY sale_date; --Mitu müüki oli 2024. aasta esimeses kvartalis? 1604 (kood all)

SELECT COUNT(*)
FROM sales
WHERE sale_date BETWEEN '2024-01-01' AND '2024-03-31';

--nullväärtuste otsimine
SELECT sale_id, customer_id, total_price
FROM sales
WHERE customer_id IS NULL; --mitu tellimust on ilma kliendi id-ta: 1487 (kood all)

SELECT COUNT(*)
FROM sales
WHERE customer_id IS NULL;

--Harjutus 2B kombineeri tingimusi

--Ülesanne: Toomas tahab näha kõiki tellimusi, mis vastavad KÕIGILE järgmistele tingimustele: Summa on üle 200 euro ja tellimus on tehtud 2024. aastal. Kirjuta päring, mis ühendab need kaks tingimust AND-iga
SELECT COUNT(*)
FROM sales
WHERE total_price> 200
  AND sale_date BETWEEN '2024-01-01' AND '2024-12-31'; --4233

--Lisaülesanne: Lisa kolmas tingimus — näita ainult konkreetse kanali (channel) tellimusi. Vali kanal ise.

SELECT DISTINCT channel
FROM sales;--vaatasin üle, mis channelid ehk müügikanalid on tabelis

SELECT COUNT(*)
FROM sales
WHERE total_price> 200
  AND sale_date BETWEEN '2024-01-01' AND '2024-12-31'
  AND channel = 'online'; --1581

--Harjutus 2C Rakendus
--Ülesanne: Toomas küsib: "Näidake mulle kõik tellimused, kus midagi on kahtlast — kas summa on 0 või väiksem, või kliendi ID puudub." Kirjuta päring, mis leiab need "kahtlased" read.
-- Sinu päring "kahtlaste" ridade leidmiseks:

SELECT sale_id, customer_id, total_price
FROM sales
WHERE total_price <= 0 OR customer_id IS NULL
ORDER BY total_price ASC;

--nüüd kokku, mitu kahtlast rida on: 1766
SELECT count (*) 
FROM sales
WHERE total_price <= 0
   OR customer_id IS NULL;
