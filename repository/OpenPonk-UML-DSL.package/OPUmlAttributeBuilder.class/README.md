I am a parser / builder that parses textual representation of an attribute and creates an DCUmlAttribute instance.

!! Examples

attributeName => FAMIX Attribute named  'attributeName'
attributeName : SomeType => with declared type
attributeName : SomeType[0..1] => and declared multiplicity

!! Not yet supported
_attribute : flags_ => attribute is class-side
_attribute : flags = someValue => default value