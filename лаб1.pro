/*имя:Ыбырай Роза
Группа:НКНбд-01-21
Студ.билет:1032205830
Предметная область:Товары,клиенты,покупки.Клиенты покупают товары.
*/
/*Факты*/
/*Товар(id,название,категория,цена)*/
товар("12345678","печенье","сладости",150).
товар("23456789","шоколад","сладости",250).
товар("34567890","мороженое","сладости",100).
товар("34567891","вафли","сладости",130).
товар("34567892","кофе","напитки",350).
товар("34567893","кола","напитки",270).
товар("34567894","пепси","напитки",260).

/*Клиент(имя,телефон)*/
клиент("Ольга","89991234567").
клиент("Александр","89992345678").
клиент("Николай","89993456789").

/*Покупка(телефон клиента, id товара,количество,дата)*/
покупка("89991234567","12345678",12,"12/03/2023").
покупка("89992345678","23456789",15,"11/03/2023").
покупка("89993456789","34567890",14,"22/03/2023").
покупка("89991234567","34567891",5,"12/03/2023").
покупка("89992345678","34567892",1,"11/03/2023").
покупка("89993456789","34567893",4,"22/03/2023").
покупка("89991234567","34567894",4,"10/03/2023").
покупка("89992345678","34567892",7,"23/03/2023").
покупка("89993456789","12345678",8,"12/03/2023").
/*Правила*/
постоянный_клиент(Имя):-
    клиент(Имя,Телефон),
    товар(Idтовара,Название,Категория,Цена),
    покупка(Телефон,Idтовара,Количество,Дата),
    write("Клиент по имени"),write(Имя),write("купил"),write(Название),write("в"),write(Дата),write("\n"),fail.
сумма_покупок_на_определенный_день(Дата):-
    клиент(Имя,Телефон),
    товар(Idтовара,Название,Категория,Цена),
    покупка(Телефон,Idтовара,Количество,Дата),
    write("В"),write(Дата),write("было продано"),write(Количество),write("товаров"),write("\n"),fail.
товар_по_категории(Категория):-
    клиент(Имя,Телефон),
    товар(Idтовара,Название,Категория,Цена),
    покупка(Телефон,Idтовара,Количество,Дата),
    write("Было продано"),write(Количество),write("товаров категории"),write(Категория),write("в"),write(Дата),write("\n"),fail.
/*Запросы
постоянный_клиент("Ольга")
сумма_покупок_на_определенный_день("12/03/2023")
товар_по_категории("сладости")*/