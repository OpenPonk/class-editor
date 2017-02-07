visitor
visitMemberEnd: aProperty
	writer
		tag: #memberEnd
		attributes: (Dictionary with: #xmi:idref -> aProperty uuid asString)