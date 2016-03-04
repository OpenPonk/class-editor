tests
testModel
	self
		export:
			(self
				parseModel:
					'Person {
    name : String
    contact: Contact[1..*]
}

Teacher {
    gradeTests:(test: Test[*]): Number[*]
}

Teacher extends Role;
Student >> Role;
President >> Role;

Person --> roles Role[*];

President president --- university University;
University[1] university <*>-- departments Department[*];
Department[*] memberOf <>-- teachers Teacher[*];')
		equals:
			'Person {
	name : String
	contact : Contact[1..*]
}

Teacher {
	gradeTests:(test : Test[*]) : Number[*]
}

Role { }

President { }

University { }

Department { }

Student { }

Teacher >> Role;
Student >> Role;
President >> Role;

Person --> roles Role[*];
President president --- university University;
University university <*>-- departments Department[*];
Department[*] memberOf <>-- teachers Teacher[*];'