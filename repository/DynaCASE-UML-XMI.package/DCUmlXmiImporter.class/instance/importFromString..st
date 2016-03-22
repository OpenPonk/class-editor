as yet unclassified
importFromString: aString
	| xml visitor |
	xml := (XMLDOMParser on: aString)
		nodeFactory: (XMLPluggableElementFactory new elementClass: XmiElement);
		parseDocument.
	visitor := DCUmlXmiVisitor new.
	visitor visit: xml.
	^ visitor model