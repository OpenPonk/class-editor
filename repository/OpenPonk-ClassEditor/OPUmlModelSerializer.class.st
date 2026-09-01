"
I am responsible for serializing OpenPonk UML models. I export the underlying UML semantic model into standard XMI format and the visual diagram layout into STON format.
"
Class {
	#name : 'OPUmlModelSerializer',
	#superclass : 'OPModelSerializer',
	#category : 'OpenPonk-ClassEditor-Persistence',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Persistence'
}

{ #category : 'accessing' }
OPUmlModelSerializer class >> exportVersion [

	^ 1
]

{ #category : 'accessing' }
OPUmlModelSerializer class >> fileExtensions [

	^ #( #xml #xmi )
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
