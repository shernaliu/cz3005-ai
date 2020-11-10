% Exercise 1: The Smart Phone Rivalry

% facts
company(appy).
company(sumsum).
competitor(sumsum, appy).
smartPhoneTechnology(galacticas3).
developed(galacticas3, sumsum).
boss(stevey).
steal(stevey, galacticas3).

% rules
rival(Comp):- competitor(Comp, appy);competitor(appy, Comp).
business(Tech):- smartPhoneTechnology(Tech).
unethical(Person):- boss(Person), steal(Person, Tech), business(Tech), developed(Tech, Comp), rival(Comp).