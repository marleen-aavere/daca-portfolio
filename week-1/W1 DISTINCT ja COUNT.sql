--Distinct ja count: unikaalsed väärtused ja loendamine

--DISTINCT: eemaldab korduvad read tulemusest
-- Kõik kanalid (korduvad)
SELECT channel
FROM sales;
-- Tulemus: tuhandeid ridu, palju korduvad

-- Ainult unikaalsed kanalid
SELECT DISTINCT channel
FROM sales;
-- Tulemus: 2 rida online ja pood

--DISTINCT töötab ka mitme veeruga: siis otsib unikaalseid KOMBINATSIOONE
-- Unikaalsed kanali ja staatuse kombinatsioonid
SELECT DISTINCT channel, payment_method
FROM sales;

--COUNT
-- Mitu rida on tabelis kokku? 15234
SELECT COUNT(*) AS ridade_arv
FROM sales;

-- Mitu rida omab customer_id väärtust (mitte NULL)? 13747
SELECT COUNT(customer_id) AS klientidega_tellimused
FROM sales;

-- Mitu ERINEVAT klienti on tellimusi teinud? 2558
SELECT COUNT(DISTINCT customer_id) AS unikaalseid_kliente
FROM sales;

--NULLide loendamine
-- Mitu customer_id on NULL?
SELECT
    COUNT(*) AS kokku,
    COUNT(customer_id) AS klientidega,
    COUNT(*) - COUNT(customer_id) AS puuduvaid
FROM sales;

--Duplikaatide tuvastamine
-- Samm A: Mitu rida kokku?
SELECT COUNT(*) FROM sales;

-- Samm B: Mitu unikaalset sale_id on? 10118
SELECT COUNT(DISTINCT sale_id) FROM sales;

-- Kui A > B, siis on duplikaadid!

--Harjutus 3A kopeeri ja käivita
SELECT
    COUNT(*) AS ridade_arv,
    COUNT(customer_id) AS klientidega,
    COUNT(*) - COUNT(customer_id) AS puudub_klient,
    COUNT(DISTINCT customer_id) AS unikaalseid_kliente
FROM sales; --ridu kokku: 15234, klientidega tellimusi: 13747, puuduvaid kliente: 1487, unikaalseid kliente: 2558

SELECT DISTINCT channel
FROM sales
ORDER BY channel; --unikaalsed kanalid: online ja pood

SELECT DISTINCT payment_method
FROM sales
ORDER BY payment_method; --unikaalsed makseviisid: järelmaks, kaart ja sularaha

--Harjutus 3B: Toomas tahab teada, kui palju on duplikaate
--ridade arv
SELECT COUNT(*) AS kokku FROM sales; 

--unikaalsete sale-id arv
SELECT COUNT(DISTINCT sale_id) AS unikaalseid FROM sales;

--arvuta duplikaatide arv
SELECT
    COUNT(*) AS kokku,
    COUNT(DISTINCT sale_id) AS unikaalseid,
    COUNT(*) - COUNT(DISTINCT sale_id) AS duplikaate
FROM sales; -- duplikaate 5116

--Lisaülesanne: Kontrolli ka customers tabelit — kas seal on duplikaatseid e-maile?
SELECT
    COUNT(*) AS kokku,
    COUNT(DISTINCT email) AS unikaalseid_emaile,
    COUNT(*) - COUNT(DISTINCT email) AS duplikaatseid
FROM customers; --duplikaateid emaile: 510

--Harjutus 3C: Rakendus. Ülesanne: Toomas tahab ka products tabeli kohta ülevaadet. Kirjuta ise päring, mis näitab:Toodete koguarv, Unikaalsete kategooriate arv, Puuduvate hindade arv

SELECT
    COUNT(*) AS kokku,
    COUNT(DISTINCT category) AS unikaalseid_kategooriaid,
    COUNT(*) - COUNT(retail_price) AS duplikaatseid
FROM products; --duplikaatseid on 0

--CONCRETE PRACTISE: integreeriv harjutus
--ülesanne 1:Küsimus: mitu duplikaati on?
SELECT
    COUNT(*) AS ridu_kokku,
    COUNT(DISTINCT sale_id) AS unikaalseid,
    COUNT(*) - COUNT(DISTINCT sale_id) AS duplikaate
FROM sales; --Toomase jaoks: "Meie tabelis on 15234 rida, millest 5116 on duplikaadid."

--ülesanne 2: Kirjuta ise päring, mis näitab, mitmel real puudub customer_id (NULL väärtused)
SELECT COUNT(*)
FROM sales
WHERE customer_id IS NULL;--Toomase jaoks: "1487 tellimusel puudub kliendi ID."

SELECT
    COUNT(*) AS kokku,
    COUNT(customer_id) AS klientidega,
    COUNT(*) - COUNT(customer_id) AS puuduvaid
FROM sales; --Toomase jaoks: "1487 tellimusel puudub kliendi ID."

--ülesanne 3: Kirjuta päring, mis näitab 10 suurimat tellimust (sale_id, customer_id, total_price) (suurimad müügid)
SELECT sale_id, customer_id, total_price
FROM sales
WHERE total_price IS NOT NULL
ORDER BY total_price DESC
LIMIT 10;
--Toomase jaoks: "Suurim müük oli 2170.40 eurot."

--ülesanne 4:Kirjuta päring, mis näitab 10 väikseimat tellimust JA read, kus summa on 0 või väiksem
SELECT sale_id, customer_id, total_price
FROM sales
ORDER BY total_price
LIMIT 10;

SELECT COUNT(*)
FROM sales
WHERE total_price <= 0;
--Toomase jaoks: "Leidsime 305 tellimust, kus summa on 0 või negatiivne."

--Küsimus 10: Kirjuta SQL päring, mis vastab Toomase küsimusele: "Mitu tellimust on igas kanalis (channel) ja mitu unikaalset klienti igas kanalis?" Kasuta sales tabelit. Vihje: Sa vajad DISTINCT-i ja COUNT-i, aga mitte veel GROUP BY-d (see tuleb nädal 4). Kirjuta eraldi päring iga kanali kohta VÕI kasuta üht päringut, mis näitab unikaalseid kanaleid.
--kõigepealt leian kanalite nimed:
SELECT DISTINCT channel
FROM sales;

--online kanal
SELECT
    COUNT(*) AS tellimusi,
    COUNT(DISTINCT customer_id) AS unikaalseid_kliente
FROM sales
WHERE channel= 'online'; --5204 tellimust ja 1730 unikaalset klienti (sisaldab topeltridu)

--pood kanal
SELECT
    COUNT(*) AS tellimusi,
    COUNT(DISTINCT customer_id) AS unikaalseid_kliente
FROM sales
WHERE channel= 'pood'; --10030 tellimust ja 2287 unikaalseid kliente (sisaldab topeltridu)

--Ilma topeltridateta
SELECT COUNT(DISTINCT invoice_id)  AS tellimusi,
       COUNT(DISTINCT customer_id) AS unikaalseid_kliente
FROM sales
WHERE channel = 'online'; --tellimusi 3462, kliente 1730

SELECT COUNT(DISTINCT invoice_id)  AS tellimusi,
       COUNT(DISTINCT customer_id) AS unikaalseid_kliente
FROM sales
WHERE channel = 'pood';--tellimusi 6656, kliente 2287
