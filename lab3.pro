% Copyright
/*имя:Ыбырай Роза
Группа:НКНбд-01-21
Студ.билет:1032205830
Предметная область:Товары,клиенты,покупки.Клиенты покупают товары.
Какой клиент покупал какие товары и их инфо,
Какой определенный товар был куплен какими клиентами и инфо клиента,
Инфо о продуктах которые были проданы в определенный день
Инфо о затраты клиента
*/

implement main
    open core, stdio, file

domains
    product_info=product_info(string ID, string ProductName, string Category, integer Cost).
    client_info=client_info(string Name, string PhoneNumber).
    purchase_info=purchase_info(string ClientName, string PhoneNumber, string ID, integer Amount, string Date).

class facts
    product : (string ID, string ProductName, string Category, integer Cost).
    client : (string ClientName, string PhoneNumber).
    purchase : (string PhoneNumber, string ID, integer Amount, string Date).
class predicates
    length:(A*)->integer N.
    sum:(real*List)->real Sum.
clauses
    length([])=0.
    length([_|T])=length(T)+1.
    sum([])=0.
    sum([H|T])=sum(T)+H.
class predicates
    list_product:(string ClientName)-> string*Products determ.
    list_client:(string ProductName)->string*Clients determ.
    list_purchase:(string Date)->string*Date determ.
    expenses_of_client:(string ClientName)->integer N determ.
    list_client_info:(string ProductName)->client_info*determ.
    list_product_info:(string ClientName)->product_info*determ.
    list_purchase_info:(string Date)->purchase_info*determ.
clauses
    list_product(ClientName)=ListProduct:-
        client(string ClientName, string PhoneNumber),
        !,
        ListProduct=
            [ProductName ||
                product(ID,ProductName),
                purchase(PhoneNumber,Amount)
                ].
    list_client(ProductName)=ListClient:-
        product(ID,ProductName),
        !,
        ListClient=
            [ClientName ||
                client(ClientName, PhoneNumber),
                purchase(ID,Amount)
                ].
    list_client_info(ProductName)=
        [client_info(ClientName,PhoneNumber)||
            product(ID,ProductName),
            client(ClientName,PhoneNumber),
            purchase(ID,Amount)
        ]:-
        product(ID,ProductName),
        !.
    list_product_info(ClientName)=
        [product_info(ID,ProductName)||
            product(ID,ProductName),
            client(ClientName,PhoneNumber),
            purchase(ID,Amount)
        ]:-
        client(ClientName,PhoneNumber),
        !.
    list_purchase(Date)=
            [purchase_info(ClientName,ID,Amount,Date) ||
                product(ID),
                client(ClientName),
                purchase(Amount,Date)
            ]:-
        purchase(Date,ClientName),
        !.
    expenses_of_client(ClientName)=
        sum(
            [Cost*Amount||
                client(ClientName),
                purchase(ID,Amount,Cost)
            ]):-
        client(ClientName,PhoneNumber),
        !.
class predicates
    write_client_info:(client_info*X).
    write_product_info:(product_info*X).
    write_purchase_info:(purchase_info*X).
clauses
    write_client_info(L):-
        foreach client_info(ClientName,PhoneNumber)=list::getTupleMember_nd(L)do
            writef("\t%s\t%s\n", ClientName,PhoneNumber)
        end foreach.
     write_product_info(L):-
        foreach product_info(ID,ProductName,Cost,Category)=list::getTupleMember_nd(L)do
            writef("\t%s\t%s\t%s\t%s\n", ID,ProductName,Cost,Category)
        end foreach.
     write_purchase_info(L):-
        foreach purchase_info(ID,ClientName,Amount,Date)=list::getTupleMember_nd(L)do
            writef("\t%s\t%s\t%s\t%s\n", ID,ClientName,Amount,Date)
        end foreach.
clauses
    run() :-
        console::init(),
        file::consult("...\\lab2.txt"),
        fail.
    run() :-
        ClientName="Nick",
        L=list_client(ProductName),
        write("Client",ClientName, "bought:\n"),
        write(L),
        nl,
        write("the client",ClientName,"spent",expenses_of_client(ClientName)),
        nl,
        nl,
        fail.
    run():-
        ProductName="ice cream",
        L=list_product(ClientName),
        write("product",ProductName,"was bought by:\n"),
        write(L),
        write_client_info(list_client_info(ProductName)),
        nl,
        fail.
    run():-
        Date="22/03/2023",
        write("products that were sold on this day are:",ProductName),
        write_purchase_info(list_purchase_info(Date)),
        nl,
        fail.
    run() :-
        succeed.

end implement main

goal
    console::runUtf8(main::run).
