--select ja from samm-sammult
SELECT *
FROM sales;

--konkreetsete veergude valimine
SELECT customer_id, total_price, sale_date
FROM sales;

--veergude ümbernimetamine
select
  customer_id AS klient,
  total_price AS summa,
  sale_date AS kuupäev
FROM sales;

--piira tulemuste arvu
SELECT customer_id, total_price
FROM sales
LIMIT 10;

--TULEMUSTE SORTEERIMINE
-- Väiksemast suuremani (vaikimisi)
SELECT customer_id, total_price
FROM sales
ORDER BY total_price;
-- Suuremast väiksemani
SELECT customer_id, total_price
FROM sales
ORDER BY total_price DESC;

