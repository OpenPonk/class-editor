as yet unclassified
importFromString: aString
	| xml visitor |
	xml := (XMLDOMParser on: aString)
		nodeFactory: (XMLPluggableElementFactory new elementClass: XmiElement);
		parseDocument.
	visitor := OPUmlXmiVisitor new.
	visitor visit: xml.
	^ visitor model