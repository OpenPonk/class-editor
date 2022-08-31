Trait {
	#name : #OPTUmlStereotypedElementController,
	#traits : 'OPTUmlBaseController',
	#classTraits : 'OPTUmlBaseController classTrait',
	#category : #'OpenPonk-ClassEditor-Controllers'
}

{ #category : #forms }
OPTUmlStereotypedElementController >> applyStereotype: aStereotypeModel to: aModel [
	(aModel appliedStereotypes
		anySatisfy: [ :each | each umlClassName = aStereotypeModel umlClassName ])
		ifTrue: [ ^ self ].
	self removeStereotypesIn: aModel.
	aModel applyStereotype: aStereotypeModel implementationClass new
]

{ #category : #forms }
OPTUmlStereotypedElementController >> descriptionStereotype [

	| names stereotypes |
	stereotypes := self diagramController model profileApplications
		               ifEmpty: [ ^ nil ]
		               ifNotEmpty: [ :applications | 
			               applications flatCollect: [ :each | 
				               self
					               stereotypesIn: each appliedProfile
					               for: self model ] ].
	names := stereotypes asArray collect: [ :each | 
		         each name -> each name ].
	^ MASingleOptionDescription new
		  optionsAndLabels: { (nil -> '') } , names;
		  accessor: (MAPluggableAccessor
				   read: [ :me | 
					   me model appliedStereotypes
						   ifEmpty: [ nil ]
						   ifNotEmpty: [ :col | col first umlClassName ] ]
				   write: [ :me :newValue | 
					   newValue
						   ifNil: [ self removeStereotypesIn: me model ]
						   ifNotNil: [ 
							   self
								   applyStereotype:
									   (stereotypes detect: [ :each | each name = newValue ])
								   to: me model ].
					   me refreshFigure ]);
		  label: 'Stereotype';
		  priority: 4;
		  yourself
]

{ #category : #removing }
OPTUmlStereotypedElementController >> removeStereotypesIn: aModel [
	[ aModel appliedStereotypes isNotEmpty ]
		whileTrue: [ aModel unapplyStereotype: aModel appliedStereotypes first ]
]

{ #category : #accessing }
OPTUmlStereotypedElementController >> stereotypeMagritteDescription [
	| descriptions |
	descriptions := OPUmlStereotypeDescriptions new controller: self.
	^ descriptions descriptions
]

{ #category : #'as yet unclassified' }
OPTUmlStereotypedElementController >> stereotypesIn: aProfile for: aModel [

	^ (aProfile ownedStereotype reject: #isAbstract) select: [ :stereo | 
		  stereo allAttributes anySatisfy: [ :each | 
			  (each name beginsWith: 'base_') and: [ 
				  self model oclIsKindOf: each type name ] ] ]
]
