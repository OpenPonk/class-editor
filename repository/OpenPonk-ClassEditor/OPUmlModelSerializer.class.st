"
I serialize UML models into XMI, and the diagrams into STON.
"
Class {
	#name : 'OPUmlModelSerializer',
	#superclass : 'OPModelSerializer',
	#category : 'OpenPonk-ClassEditor-Persistence',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Persistence'
}

{ #category : 'as yet unclassified' }
OPUmlModelSerializer class >> exportVersion [

	^ 1
]

{ #category : 'accessing' }
OPUmlModelSerializer class >> fileExtension [

	^ #xml
]

{ #category : 'formatting' }
OPUmlModelSerializer class >> formatName [

	^ #xmi
]

{ #category : 'accessing' }
OPUmlModelSerializer class >> minImportVersion [

	^ 1
]

{ #category : 'serialize/materialize' }
OPUmlModelSerializer >> materializeModelFrom: aStream [
	^ OPUMLXMIReader read: aStream
]

{ #category : 'serialize/materialize' }
OPUmlModelSerializer >> serializeModel: aModel [

	self
		assert: (aModel name isNotNil and: [ aModel name isNotEmpty ])
		description: 'Model name is mandatory'.
	aModel packagedElements
		select: [ :each | each oclIsKindOf: 'Class' ]
		thenDo: [ :each | 
			self
				assert: (each name isNotNil and: [ each name isNotEmpty ])
				description:
					each umlClassName , ' name is mandatory (' , each umlClassName
					, ' id ' , each uuid asString , ')' ].
	^ OPUMLXMIWriter toString: aModel
]

{ #category : 'serialize/materialize' }
OPUmlModelSerializer >> serializeModel: aModel to: aStream [
	^ aStream << (self serializeModel: aModel)
]
