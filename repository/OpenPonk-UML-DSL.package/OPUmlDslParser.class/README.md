I am a public interface for UML DSL Parser.

!! Example:

[[[
DCUmlDslParser parse: '
Product {
	name : String
	price : Float
}
Category {
	name : String
}
Category[*] categories --- products Product[*];
'
]]]