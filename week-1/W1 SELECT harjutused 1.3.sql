--Harjutus 1A kopeeri ja käivita
SELECT *
FROM sales
LIMIT 5; --näen 5 rida ja 12 veergu

SELECT sale_id, customer_id, total_price, sale_date
FROM sales
LIMIT 10; --suurim summa on rida 7 629.96

SELECT sale_id, total_price AS summa
FROM sales
ORDER BY total_price DESC
LIMIT 5; --kõige suurem müük kogu tabelis on 2170,40

--Harjutus 1B muuda malli: muudan eelmist päringut, et leida 5 väiksemat müüki
SELECT sale_id, total_price AS summa
FROM sales
ORDER BY total_price ASC
LIMIT 5; --kõige väiksem müük -1405.32 ja näen negatiivseid müüke, null müüke minmax_stats_since

--Harjutus 1C vali veerud: Ülesanne: Toomas tahab näha tellimuste loetelu koos kliendi ID, kuupäeva ja summaga — sorteerituna kuupäeva järgi (uuemad enne). Kirjuta see päring ise. Kasuta LIMIT 20, et mitte kogu tabelit väljastada.
SELECT customer_id, sale_date, total_price
FROM sales
ORDER BY sale_date desc
LIMIT 20;

