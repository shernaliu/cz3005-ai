% Dynamic - informs the interpreter that these predicates are dynamic (can be modified)
% 12 dynamic predicates: meal, bread, size, main, cheese, veg, sauce, side, drink, cookie, dineOption, paymentMethod
% /1 means 1 param
:- dynamic meal/1, bread/1, size/1, main/1, cheese/1, veg/1, sauce/1, side/1, drink/1, cookie/1, dineOption/1, paymentMethod/1.

% The order of definition of facts and rules is not important.
% However, a good rule of thumb is to define facts before rules.
% Fact list of all menu items under each category
meals([standard, vegetarian, healthy, value, salad_bowl]).
breads([multigrain, hearty_italian, italian_wheat, parmesan_oregano, honey_oat, flat_bread]).
sizes([six_inch, foot_long]).
mains([chicken, ham, turkey, tuna, beef, meatball_marinara, egg_mayo, italian_bmt, veggie_delite, veggie_patty, tofu_patty]).
veg_mains([veggie_delite, veggie_patty, tofu_patty]).
cheeses([american, monterey, feta, mozzarella, cheddar, swiss, '0 (none)']).
vegs([cucumbers, tomatoes, lettuce, green_peppers, red_onions, jalapenos, black_olives, pickles, '0 (none)']).
sauces([chipotle, ranch, bbq, chilli, tomato, mayonnaise, vinegar, '0 (none)']).
healthy_sauces([chipotle, ranch, tomato, vinegar, '0 (none)']).
sides([potato_chips, hashbrowns, yogurt, '0 (none)']).
drinks([coke, sprite, orange_fanta, mineral_water, orange_juice, green_tea, hot_coffee, hot_tea, '0 (none)']).
healthy_drinks([diet_coke, diet_sprite, mineral_water, green_tea_no_sugar, hot_coffee_no_sugar, hot_tea_no_sugar, '0 (none)']).
cookies([choco_chip, double_choco_chip, peanut_butter, white_chip_macadamia_nut, oatmeal_raisin, raspberry, '0 (none)']).
dineOptions([dine_in, takeaway, delivery]).
paymentMethods([cash, credit_card, nets]).

% picked predicates/rules for each menu item
% E.g. X is picked in meals if L is meals AND X is a member of L (meals).
picked(X, meals) :- meals(L), member(X, L).
picked(X, breads) :- breads(L), member(X, L).
picked(X, sizes) :- sizes(L), member(X, L).
picked(X, mains) :- mains(L), member(X, L).
picked(X, veg_mains) :- veg_mains(L), member(X, L).
picked(X, cheeses) :- cheeses(L), member(X, L).
picked(X, vegs) :- vegs(L), member(X, L).
picked(X, sauces) :- sauces(L), member(X, L).
picked(X, healthy_sauces) :- healthy_sauces(L), member(X, L).
picked(X, sides) :- sides(L), member(X, L).
picked(X, drinks) :- drinks(L), member(X, L).
picked(X, healthy_drinks) :- healthy_drinks(L), member(X, L).
picked(X, cookies) :- cookies(L), member(X, L).
picked(X, dineOptions) :- dineOptions(L), member(X, L).
picked(X, paymentMethods) :- paymentMethods(L), member(X, L).

% Display all menu item options for each category
display_options(meals):- meals(L), write('Meals: {'), item_list(L).
display_options(breads):- breads(L), write('Breads: {'), item_list(L).
display_options(sizes):- sizes(L), write('Sizes: {'), item_list(L).
display_options(mains):- mains(L), write('Mains: {'), item_list(L).
display_options(veg_mains):- veg_mains(L), write('Veg Mains: {'), item_list(L).
display_options(cheeses):- cheeses(L), write('Cheeses: {'), item_list(L).
display_options(vegs):- vegs(L), write('Vegetables: {'), item_list(L).
display_options(sauces):- sauces(L), write('Sauces: {'), item_list(L).
display_options(healthy_sauces):- healthy_sauces(L), write('Healthy Sauces: {'), item_list(L).
display_options(sides):- sides(L), write('Sides: {'), item_list(L).
display_options(drinks):- drinks(L), write('Drinks: {'), item_list(L).
display_options(healthy_drinks):- healthy_drinks(L), write('Healthy Drinks: {'), item_list(L).
display_options(cookies):- cookies(L), write('Cookies: {'), item_list(L).
display_options(dineOptions):- dineOptions(L), write('Dine Options: {'), item_list(L).
display_options(paymentMethods):- paymentMethods(L), write('Payment Methods: {'), item_list(L).


% item_list predicates and rules to display the list item
% item_list with param empty list
item_list([]).
% item_list with list, write to output each list element and newline
item_list([X]) :- write(X), write('}'), nl.
% item_list with H and T of list, write to output each sub list element
item_list([X|Y]) :- write(X), write(', '), item_list(Y), !.

% clear - use retractall to remove all stored facts in the kbs for all dynamic predicates
clear :- 
    retractall(meal(_)), retractall(bread(_)), retractall(size(_)),
    retractall(main(_)), retractall(cheese(_)), retractall(veg(_)),
    retractall(sauce(_)), retractall(side(_)), retractall(drink(_)),
    retractall(cookie(_)), retractall(dineOption(_)), retractall(paymentMethod(_)).

% retrieve_user_choice to get all menu items chosen by the user
retrieve_user_choice(Meals, Breads, Sizes, Mains, Cheeses, Vegs, Sauces, Sides, Drinks, Cookies, DineOptions, PaymentMethods) :-
    findall(X, meal(X), Meals),
    findall(X, bread(X), Breads),
    findall(X, size(X), Sizes),
    findall(X, main(X), Mains),
    findall(X, cheese(X), Cheeses),
    findall(X, veg(X), Vegs),
    findall(X, sauce(X), Sauces),
    findall(X, side(X), Sides),
    findall(X, drink(X), Drinks),
    findall(X, cookie(X), Cookies),
    findall(X, dineOption(X), DineOptions),
    findall(X, paymentMethod(X), PaymentMethods).

% for each meal types, ask each menu item in the following sequences
% ask_standard_meal - Ask everything.
ask_standard_meal :- ask_bread, ask_size, ask_mains, ask_cheese, ask_vegetables, ask_sauce, ask_sides, ask_drinks, ask_cookies, ask_dineOptions, ask_paymentMethods.

% ask_vegetarian_meal - Do not ask meat mains & cheese. Ask vegetarian mains instead.
ask_vegetarian_meal :- ask_bread, ask_size, ask_veg_mains, ask_vegetables, ask_healthy_sauce, ask_sides, ask_drinks, ask_cookies, ask_dineOptions, ask_paymentMethods.

% ask_healthy_meal - Ask healthy_sauce and healthy_drinks instead. Do not ask cookies as it is unhealthy due to high sugar level.
ask_healthy_meal :- ask_bread, ask_size, ask_mains, ask_cheese, ask_vegetables, ask_healthy_sauce, ask_sides, ask_healthy_drinks, ask_dineOptions, ask_paymentMethods.

% ask_value_meal - Do not ask cheese and sides
ask_value_meal :- ask_bread, ask_size, ask_mains, ask_vegetables, ask_sauce, ask_drinks, ask_dineOptions, ask_paymentMethods.

% ask_salad_bowl_meal - Do not ask bread and size of bread
ask_salad_bowl_meal :- ask_mains, ask_cheese, ask_vegetables, ask_sauce, ask_sides, ask_drinks, ask_cookies, ask_dineOptions, ask_paymentMethods.

% ask user to select an option for the following menu items
ask_meal :-
    write('What kind of meal would you like? '), nl,
    display_options(meals),
    pick_meal.

ask_bread :-
    write('What kind of bread would you like? '), nl,
    display_options(breads),
    pick_bread.

 ask_size :-
    write('What size would you like? '), nl,
    display_options(sizes),
    pick_size.

ask_mains :-
    write('What mains would you like? '), nl,
    display_options(mains),
    pick_main.

ask_veg_mains :-
    write('What vegetarian mains would you like? '), nl,
    display_options(veg_mains),
    pick_main.

ask_cheese :-
    write('Which of these tasty cheese would you like? '), nl,
    display_options(cheeses),
    pick_cheese.

ask_vegetables :-
    write('Don\'t forget your vegetables! What vegetables would you like?'), nl,
    display_options(vegs),
    pick_vegetable.

ask_sauce :-
    write('Let\'s get saucy! What kind of sauce would you like? '), nl,
    display_options(sauces),
    pick_sauce.

ask_healthy_sauce :-
    write('Let\'s get saucy but stay healthy! What kind of sauce would you like? '), nl,
    display_options(healthy_sauces),
    pick_healthy_sauce.

ask_sides :-
    write('What kind of sides would you like? '), nl,
    display_options(sides),
    pick_side.

ask_drinks :-
    write('Let\'s stay hydrated! What drinks would you like? '), nl,
    display_options(drinks),
    pick_drink.

ask_healthy_drinks :-
    write('Let\'s stay hydrated healthily! What drinks would you like? '), nl,
    display_options(healthy_drinks),
    pick_healthy_drink.

ask_cookies :-
    write('Cookies! What cookies do you fancy having today? '), nl,
    display_options(cookies),
    pick_cookie.

ask_dineOptions :-
    write('Would you like to dine in, takeaway or delivery?'), nl,
    display_options(dineOptions),
    pick_dine_option.

ask_paymentMethods :-
    write('How would you like to pay?'), nl,
    display_options(paymentMethods),
    pick_payment_method.

% allow user to pick each menu item and update item to dynamic predicate in kbs
pick_meal :-
    read(X),
    picked(X, meals) -> assertz(meal(X));
    write('Invalid meal. Please try again.'), nl,
    pick_meal.

pick_bread :-
    read(X),
    picked(X, breads) -> assertz(bread(X));
    write('Invalid bread. Please try again.'), nl,
    pick_bread.

pick_size :-
    read(X),
    picked(X, sizes) -> assertz(size(X));
    write('Invalid size. Please try again.'), nl,
    pick_size.

pick_main :-
    read(X),
    picked(X, mains) -> assertz(main(X));
    write('Invalid main. Please try again.'), nl,
    pick_main. 

pick_veg_main :-
    read(X),
    picked(X, veg_mains) -> assertz(main(X));
    write('Invalid vegetarian main. Please try again.'), nl,
    pick_veg_main. 

pick_cheese :-
    read(X),
    (not(X == 0) ->
        (picked(X, cheeses) -> write(' (Enter 0 to end cheese selection.)'), nl, assertz(cheese(X));
        write('Invalid cheese. Please try again.'), nl),
        pick_cheese;
        true
    ). 

pick_vegetable :-
    read(X),
    (not(X == 0) -> 
        (picked(X, vegs) -> write(' (Enter 0 to end vegetables selection.)'), nl, assertz(veg(X));
        write('Invalid veg. Please try again.'), nl),
        pick_vegetable;
        true
    ).

pick_sauce :-
    read(X),
    (not(X == 0) -> 
        (picked(X, sauces) -> write(' (Enter 0 to end sauces selection.)'), nl, assertz(sauce(X));
        write('Invalid sauce. Please try again.'), nl),
        pick_sauce;
        true
    ).

pick_healthy_sauce :-
    read(X),
    (not(X == 0) -> 
        (picked(X, healthy_sauces) -> write(' (Enter 0 to end healthy sauce selection.)'), nl, assertz(sauce(X));
        write('Invalid healthy sauce. Please try again.'), nl),
        pick_healthy_sauce;
        true
    ).

pick_side :-
    read(X),
    (not(X == 0) -> 
        (picked(X, sides) -> write(' (Enter 0 to end sides selection.)'), nl, assertz(side(X));
        write('Invalid sides. Please try again.'), nl),
        pick_side;
        true
    ).

pick_drink :-
    read(X),
    (not(X == 0) -> 
        (picked(X, drinks) -> write(' (Enter 0 to end drink selection.)'), nl, assertz(drink(X));
        write('Invalid drinks. Please try again.'), nl),
        pick_drink;
        true
    ).

pick_healthy_drink :-
    read(X),
    (not(X == 0) -> 
        (picked(X, healthy_drinks) -> write(' (Enter 0 to end healthy drink selection.)'), nl, assertz(drink(X));
        write('Invalid healthy drink. Please try again.'), nl),
        pick_healthy_drink;
        true
    ).

pick_cookie :-
    read(X),
    (not(X == 0) -> 
        (picked(X, cookies) -> write(' (Enter 0 to end cookie selection.)'), nl, assertz(cookie(X));
        write('Invalid cookies. Please try again.'), nl),
        pick_cookie;
        true
    ).

pick_dine_option :-
    read(X),
    picked(X, dineOptions) -> nl, assertz(dineOption(X));
    write('Invalid dine options. Please try again.'), nl,
    pick_dine_option.

pick_payment_method:-
    read(X),
    picked(X, paymentMethods) -> nl, assertz(paymentMethod(X));
    write('Invalid payment method. Please try again.'), nl,
    pick_payment_method.

% retrieve and display the current date time
current_date_time(Day, Month, Year, Hour, Min, Sec) :-
    get_time(T),
    stamp_date_time(T,DateTime,'local'),
    arg(1, DateTime, Year),
    arg(2, DateTime, Month),
    arg(3, DateTime, Day),
    arg(4, DateTime, Hour),
    arg(5, DateTime, Min),
    arg(6, DateTime, Sec),
    format('~t ~w ~25|~w/~w/~w ~w:~w:~0f~n', ['Order Time:', Day, Month, Year, Hour, Min, Sec]).

% generate random number for price as a placeholder
% assume user has paid exact amount
generate_price(Price):-
    random(5.1,11.9,Price),
    format('~t ~w ~25|$~2f~n', ['Total:', Price]),
    format('~t ~w ~25|~w%~n', ['GST:', 7]),
    product(Price, 1.07, SubTotal),
    format('~t ~w ~25|$~2f~n', ['Subtotal:', SubTotal]),
    format('~t ~w ~25|$~2f~n', ['Paid:', SubTotal]),
    format('~t ~w ~25|$~2f~n', ['Change:', 0]).

% generate random number for price with delivery as a placeholder
% assume user has paid exact amount
generate_price_delivery(Price):-
    random(5.1,11.9,Price),
    format('~t ~w ~25|$~2f~n', ['Total:', Price]),
    format('~t ~w ~25|~w%~n', ['GST:', 7]),
    product(Price, 0.07, GstTax),
    format('~t ~w ~25|$~2f~n', ['GST tax:', GstTax]),
    format('~t ~w ~25|$~2f~n', ['Delivery Surcharge:', 3.50]),
    product(Price, 1.07, TotalPrice),
    sum(TotalPrice, 3.5, SubTotal),
    format('~t ~w ~25|$~2f~n', ['Subtotal:', SubTotal]),
    format('~t ~w ~25|$~2f~n', ['Paid:', SubTotal]),
    format('~t ~w ~25|$~2f~n', ['Change:', 0]).

% methods to calculate price
% sum - find the result of A + B
sum(A, B, Result) :- Result is A + B.

% product - find the result of A * B
product(A, B, Result) :- Result is A * B.

% print_receipt to display all the picked menu items by user. Concatenate each menu item and write to output and newline.
% E.g. If Bread is not equals to '', then write out the picked Bread. Otherwise, write none.
print_receipt :-
    format('~`-t~50|~n'),
    format('~tSUBWAY~t~50|~n'),
    current_date_time(_Day, _Month, _Year, _Hour, _Min, _Sec),
    retrieve_user_choice(Meals, Breads, Sizes, Mains, Cheeses, Vegs, Sauces, Sides, Drinks, Cookies, DineOptions, PaymentMethods), 
    atomic_list_concat(Meals, Meal), format('~t ~w ~25|~w~n', ['Meal:', Meal]),
    atomic_list_concat(Breads, Bread), format('~t ~w ~25|', ['Bread:']), (not(Bread == '') -> write(Bread); write(none)), nl,
    atomic_list_concat(Sizes, Size), format('~t ~w ~25|', ['Size:']), (not(Size == '') -> write(Size); write(none)), nl,
    atomic_list_concat(Mains, Main), format('~t ~w ~25|', ['Main:']), (not(Main == '') -> write(Main); write(none)), nl,
    atomic_list_concat(Cheeses, ', ', Cheese), format('~t ~w ~25|', ['Cheeses:']), (not(Cheese == '') -> foreach(member(X, Cheeses), format('~t~25|~w~n',[X])); write(none)), nl,
    atomic_list_concat(Vegs, ', ', Veg), format('~t ~w ~25|', ['Vegetables:']), (not(Veg == '') -> foreach(member(X, Vegs), format('~t~25|~w~n',[X])); write(none)), nl,
    atomic_list_concat(Sauces, ', ', Sauce), format('~t ~w ~25|', ['Sauces:']), (not(Sauce == '') -> foreach(member(X, Sauces), format('~t~25|~w~n',[X])); write(none)), nl,
    atomic_list_concat(Sides, ', ', Side), format('~t ~w ~25|', ['Sides:']), (not(Side == '') -> foreach(member(X, Sides), format('~t~25|~w~n',[X])); write(none)), nl,
    atomic_list_concat(Drinks, ', ', Drink), format('~t ~w ~25|', ['Drinks:']), (not(Drink == '') -> foreach(member(X, Drinks), format('~t~25|~w~n',[X])); write(none)), nl,
    atomic_list_concat(Cookies, ', ', Cookie), format('~t ~w ~25|', ['Cookies:']), (not(Cookie == '') -> foreach(member(X, Cookies), format('~t~25|~w~n',[X])); write(none)), nl,
    atomic_list_concat(DineOptions, ', ', DineOption), format('~t ~w ~25|~w~n', ['Dine Options:', DineOption]),
    atomic_list_concat(PaymentMethods, PaymentMethod), format('~t ~w ~25|~w~n', ['Payment Methods:', PaymentMethod]),
    ((DineOption = 'delivery') -> generate_price_delivery(_Price), format('Estimated delivery time: 30 minutes~n'); generate_price(_Price)),
    format('~t~w~40|~n',['Thank you! Enjoy your meal!']),
    format('~`-t~50|~n').

% Entry point of application
% Start a new subway order by asking user what type of meal he wants.
% If input is vegetarian, use ask_vegetarian_meal
% If input is healthy, use ask_healthy_meal
% If input is value, use ask_value_meal
% If input is salad_bowl, use ask_salad_bowl_meal
new :- 
    format('Hello! Welcome to Subway! ~nMay I take your order please?~n'),
    ask_meal, meal(Meal),
    ((Meal == vegetarian) -> ask_vegetarian_meal;
    (Meal == healthy) -> ask_healthy_meal;
    (Meal == value) -> ask_value_meal;
    (Meal == salad_bowl) -> ask_salad_bowl_meal;
    ask_standard_meal),
    format('Ok! All done! Here is your receipt:~n'),
    print_receipt, 
    clear.
