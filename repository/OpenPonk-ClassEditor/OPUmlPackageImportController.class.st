"
I am a controller for a PackageImport.
"
Class {
	#name : 'OPUmlPackageImportController',
	#superclass : 'OPUmlRelationshipController',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'forms' }
OPUmlPackageImportController >> descriptionGeneral [
	"<magritteDescription>
	^ MAStringDescription new
		beReadonly;
		accessor:
			(MAPluggableAccessor read: [ :me | me model general name ] write: [ :me :newValue |  ]);
		label: 'General';
		priority: 1;
		yourself"
]

{ #category : 'forms' }
OPUmlPackageImportController >> descriptionGeneralizationSet [
"	<magritteDescription>
	^ MAToManyRelationDescription new
		initializer: [ :desc | 
			desc
				controller: self;
				set: OPUMLGeneralizationSet new ];
		display: [ :desc | 
			String
				streamContents: [ :stream | 
					stream
						<< 'GeneralizationSet {''';
						<< (desc set name ifNil: [ '' ]);
						<< ''', '.
					desc set isCovering
						ifTrue: [ stream << 'complete, ' ]
						ifFalse: [ stream << 'incomplete, ' ].
					desc set isDisjoint
						ifTrue: [ stream << 'disjoint, ' ]
						ifFalse: [ stream << 'overlapping, ' ].
					stream << ('(' , desc set generalizations size asString , ')}') ] ];
		accessor:
			(MAPluggableAccessor
				read: [ :me | 
					me model generalizationSets
						collect: [ :each | 
							OPUmlGeneralizationSetDescriptions new
								controller: self;
								set: each ] ]
				write: [ :me :newValue | 
					me model generalizationSets: (newValue collect: #set).
					diagramElement ifNotNil: [ self refreshFigure ] ]);
		classes: {OPUmlGeneralizationSetDescriptions};
		label: 'Generalization Sets';
		priority: 5;
		yourself"
]

{ #category : 'forms' }
OPUmlPackageImportController >> descriptionName [
	^ nil
]

{ #category : 'forms' }
OPUmlPackageImportController >> descriptionSpecific [
"	<magritteDescription>
	^ MAStringDescription new
		beReadonly;
		accessor:
			(MAPluggableAccessor read: [ :me | me model specific name ] write: [ :me :newValue |  ]);
		label: 'Specific';
		priority: 2;
		yourself"
]

{ #category : 'forms' }
OPUmlPackageImportController >> descriptionVisibility [
	^ nil
]

{ #category : 'figures' }
OPUmlPackageImportController >> diagramElementClass [

	^ OPUmlPackageImportShape
]

{ #category : 'accessing' }
OPUmlPackageImportController >> modelClass [
	^ OPUMLPackageImport
]

{ #category : 'forms' }
OPUmlPackageImportController >> modelSource [
	^ model importingNamespace
]

{ #category : 'figures' }
OPUmlPackageImportController >> modelSource: aModel in: aParentModel [
	"answers whether model's source has been changed"

	self modelSource = aModel ifTrue: [ ^ false ].
	model importingNamespace: aModel.
	^ true
]

{ #category : 'forms' }
OPUmlPackageImportController >> modelTarget [
	^ model importedPackage
]

{ #category : 'figures' }
OPUmlPackageImportController >> modelTarget: aModel in: aParentModel [
	"answers whether model's target has been changed"

	self modelTarget = aModel ifTrue: [ ^ false ].
	model importedPackage: aModel.
	^ true
]

{ #category : 'removing' }
OPUmlPackageImportController >> removeModel [

	model importedPackage: nil.
	model importingNamespace: nil.
	self diagramController model packagedElements remove: self model
]
