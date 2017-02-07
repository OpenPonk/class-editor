I am a parser / builder that parses textual representation of an operation and creates a DCUmlOperation instance.

!! Examples

method() => new method
method(): RetType => return type
method(): RetType[0..1] => and multiplicity
method(param)
method(param  : SomeType)
method(param : SomeType, otherPar : OtherType[2..*])

!! Not yet supported
_method()_ => method is class-side
/method()/ => method is abstact