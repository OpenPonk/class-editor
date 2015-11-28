examples
sampleDsl
	^ DCUmlDslParser
		parse:
			'Person {
    name : String
    contact: Contact[1..*]
}

Teacher {
    gradeTests:(test: Test[*]): Number[*]
}

Teacher extends Person;
Student << Person;
President << Person;

President president --- university University;
University[1] university <*>-- departments Department[*];
Department[*] memberOf <>-- teachers Teacher[*];'