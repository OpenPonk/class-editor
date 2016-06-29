I wrap code generation for Enumerations.

!! Example

BormParticipantType <<enumeration>> {
	Organization
	Person
	System
}

will be generated to:

BormParticipantType {
	+Organization() : #Organization
	+Person() : #Person
	+System() : #Symbol
	_+default() : BormParticipantType
}