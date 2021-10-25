f={3.rand;};
f.value;


g={arg a; a.value +10};
m={2.0;};
g.value(m);


(
f={ arg a,b;
	a-b;
};
f.value(10,2);
)

//// NO ORDER IN MATHS; YOU SHOULD USE PARENTHESIS


g={|a,b,c| a + b + c;};
g.value(1,2,2);

//// DECLARE INTERMMEDIATE VARIABLES AND ALSO FUNCTIONS (ASIDE FROM SINGLE LETTERS)
(
fan = { arg a, b;
    var firstResult, finalResult;
    firstResult = a + b;
    finalResult = firstResult * 2;
    finalResult;
};

)