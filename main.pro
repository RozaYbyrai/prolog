% Copyright
/*имя:Ыбырай Роза
Группа:НКНбд-01-21
Студ.билет:1032205830
Предметная область:Товары,клиенты,покупки.Клиенты покупают товары.
*/

implement main
    open core, stdio, file

domains
    status = symbol{none, regular}.

class facts
    product : (string ID, string ProductName, string Category, integer Cost).
    client : (string Name, string PhoneNumber).
    purchase : (string PhoneNumber, string ID, integer Amount, string Date).

clauses
    product("12345678", "cookie", "sweets", 150).
    product("23456789", "chocolate", "sweets", 250).
    product("34567890", "ice cream", "sweets", 100).
    product("34567891", "waffles", "sweets", 130).
    product("34567892", "coffee", "drinks", 350).
    product("34567893", "cola", "drinks", 270).
    product("34567894", "pepsi", "drinks", 260).

    client("Olga", "89991234567").
    client("Alex", "89992345678").
    client("Nick", "89993456789").
    client("Brad", "89993456780").

    purchase("89991234567", "12345678", 12, "12 / 03 / 2023").
    purchase("89992345678", 23456789, 15, "11 / 03 / 2023").
    purchase("89993456789", "34567890", 14, "22 / 03 / 2023").
    purchase("89991234567", "34567891", 5, "10 / 03 / 2023").
    purchase("89992345678", "34567892", 1, "11 / 03 / 2023").
    purchase("89993456789", "34567893", 4, "22 / 03 / 2023").
    purchase("89991234567", "34567894", 4, "10 / 03 / 2023").
    purchase("89992345678", "34567892", 7, "23 / 03 / 2023").
    purchase("89993456780", "12345678", 8, "12 / 03 / 2023").

class predicates
    regular_client : (string Name) failure.
    amount_of_purchases_on_a_certain_day : (string Date, string Name, Sum) failure.
    get_client_status : (string Name, Status) failure.
    sum_of_purchases_of_certain_product : (string ProductName) failure.

class facts
    s : (integer Sum) single.

clauses
    s(0).

clauses
    regular_client(Name) :-
        client(Name, PhoneNumber),
        product(ProductName, _Category, _Cost),
        purchase(PhoneNumber, _ID, _Amount, Date),
        write("Клиент по имени"),
        write(Name),
        write("с телефоном номера"),
        write(PhoneNumber),
        write("купил"),
        write(ProductName),
        write("в"),
        write(Date),
        write("\n"),
        nl,
        fail.

clauses
    amount_of_purchases_on_a_certain_day(Name, Date, Sum) :-
        client(Name, PhoneNumber),
        product(ID, _ProductName, _Category, Cost),
        purchase(PhoneNumber, _, Amount, Date),
        Sum in Amount,
        write("В"),
        write(Date),
        write("было продано"),
        write(Amount),
        write("товаров"),
        write("\n"),
        nl,
        fail.

    get_client_status(Name, Status) :-
        client(Name, PhoneNumber),
        product(_ID, _Category),
        purchase(PhoneNumber, ID, Amount, Date),
        regular_client(Name),
        Status = regular,
        nl,
        fail.
    get_client_status(Name, Status) :-
        client(Name, Phone),
        purchase(Phone, _, _, _),
        Status = none,
        nl,
        fail.
    sum_of_purchases_of_certain_product(ProductName) :-
        assert(s(0)),
        product(ID, ProductName, Cost),
        purchase(ID, Amount),
        s(Sum),
        asserta(s(Sum + Amount * Cost)),
        fail.
    sum_of_purchases_of_certain_product(ProductName) :-
        product(ProductName),
        s(Sum),
        write("Сумма покупок товара", ProductName, "равно", Sum),
        nl.

clauses
    run() :-
        console::init(),
        reconsult("...\\lab2.txt"),
        regular_client("Olga"),
        fail.
    run() :-
        amount_of_purchases_on_a_certain_day("23 / 03 / 23"),
        fail.
    run() :-
        get_client_status("Olga"),
        fail.
    run() :-
        sum_of_purchases_of_certain_product("Cola"),
        fail.
    run() :-
        succeed.

end implement main

goal
    console::runUtf8(main::run).
