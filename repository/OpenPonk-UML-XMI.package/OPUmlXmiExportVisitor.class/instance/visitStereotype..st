visitor
visitStereotype: aStereotype
	"This is a non-standard extension."

	| attrs |
	attrs := Dictionary
		with: #xmi:type -> 'uml:Stereotype'
		with: #xmi:id -> aStereotype uuid asString
		with: #name -> aStereotype name.
	writer tag: #packagedElement attributes: attrs