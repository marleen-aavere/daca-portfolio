# Nädal 2 – Meeskonnatöö kokkuvõte (Sales Analytics)

## Meeskond

| Nimi | Roll (Nädal 2) |
|---|---|
| Marleen Aavere | A: Müügiandmete puhastamine |
| Marje Piirisild | B: Kliendiandmete puhastamine |
| Sigrid Nieländer | C: Tooteandmete puhastamine |
| Maarja Valmas | D: Ristvalideerimine ja kvaliteedikontroll |

## Minu panus

- Leidsin duplikaadid sales tabelist, NULL väärtused ja vigased kuupäevad `sales` tabelist
- Lõin test koopia sales_test, puhastasin ja dokumenteerisin kõik muudatused

## Tulemused

| Kategooria | Leitud probleeme | Kirjeldus |
|---|---:|---|
| Duplikaadid | 5116 | Korduvad `invoice_` väärtused |
| NULL `customer_id` | 1487 | Puuduv kliendiviide |
| NULL `sales_date` | 0 | Puuduv kuupäev |
| NULL `total_price` | 0 | Puuduv summa |
| Tuleviku kuupäevad | 0 | Kuupäev > tänane |
| Kuupäevad pärast andmete lõppu | 50 | Kuupäev > 2025-02-28 (märgi, ära kustuta) |
| **Kokku** | **6653** | |

## Järeldused

Leidsin 5116 duplikaati ehk iga kolmas rida oli kordus, mis paisutas müügitulu ja tehingute arvu aruannetes. Pärast puhastamist jäi alles 10 118 unikaalset rida. Leidsin, et customer_id puudub 1487 real ehk ligi 10% müükidest on külalisostud, mitte andmevead, seega jätsin need alles. Leidsin veel, et tuleviku kuupäevi ei leitud (0), kuid 50 müüki on dateeritud pärast andmete lõppu 2025-02-28. Pärast duplikaatide eemaldamist on neid 32, mis märkisin üles ja jätsin analüüsist välja, kuid ei kustutanud. Analüüsiks sobib 10 086 rida. Äriliselt tähendab see, et eelmised müügiaruanded näitasid liiga suuri numbreid ja puhastatud andmetega on need usaldusväärsed.

## Soovitused Toomasele

- Duplikaadid eemaldada
- `customer_id` puuduvate väärtuste probleem lahendada
