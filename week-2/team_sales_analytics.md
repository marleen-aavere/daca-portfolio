# Nädal 2 – Meeskonnatöö kokkuvõte (Sales Analytics)

## Meeskond

| Nimi | Roll (Nädal 2) |
|---|---|
| Marleen Aavere | A: Müügiandmete puhastamine |
| Marje Piirisild | B: Kliendiandmete puhastamine |
| Sigrid Nieländer | C: Tooteandmete puhastamine |
| Maarja Valmas | D: Ristvalideerimine ja kvaliteedikontroll |

## Minu panus

- Analüüsisin müügiandmeid tabelist sales_test, et tuvastada andmekvaliteedi probleeme ning tagada aruannete usaldusväärsus.
- Leidsin duplikaadid, NULL väärtused ja vigased kuupäevad `sales_test` tabelist.
- Lõin test koopia sales_test, puhastasin ja dokumenteerisin kõik muudatused.

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

### Teostatud puhastamine
- Eemaldasin duplikaadid, mille järel jäi alles 10 118 unikaalset rida.
- Analüüsisin puuduvaid customer_id väärtusi ning tuvastasin, et tegemist on külalisostudega, mitte andmeveaga. Peale puhastamist jäi alles 988 rida.
- Kontrollisin kuupäevi andmete lõppkuupäeva suhtes.
- Märgistasin andmete lõppkuupäevast hilisemad müügid, mida oli kokku 32 ning jätsin need analüüsist välja, kuid ei kustutanud.


## Järeldused

Leidsin 5116 duplikaati ehk iga kolmas rida oli kordus, mis paisutas müügitulu ja tehingute arvu aruannetes. Pärast puhastamist jäi alles 10 118 unikaalset rida. Leidsin, et customer_id puudub 1487 real ehk ligi 10% müükidest on külalisostud, mitte andmevead. Peale puhastamist jäi alles 988 rida. Leidsin veel, et tuleviku kuupäevi ei leitud (0), kuid 50 müüki on dateeritud pärast andmete lõppu 2025-02-28. Pärast duplikaatide eemaldamist on neid 32, mis märkisin üles ja jätsin analüüsist välja, kuid ei kustutanud. Analüüsiks sobib 10 086 rida. Äriliselt tähendab see, et eelmised müügiaruanded näitasid liiga suuri numbreid ja puhastatud andmetega on need usaldusväärsed.

## Soovitused Toomasele

- Duplikaadid eemaldada, kuna need moonutavad andmete õigsust.
- Andmete lõppkuupäevast hilisemad kirjed vajavad edasist käsitlemist, et tagada nende korrektne kasutamine analüüsides. 
