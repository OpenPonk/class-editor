Class {
	#name : 'UCMVWXmlExporter',
	#superclass : 'Object',
	#instVars : [
		'xmlWriter',
		'writer',
		'packageName',
		'environment',
		'namespaceEnvironment'
	],
	#category : 'UML-CodeGenerator-VW-Generators',
	#package : 'UML-CodeGenerator',
	#tag : 'VW-Generators'
}

{ #category : 'as yet unclassified' }
UCMVWXmlExporter class >> example [
| pim psm writer |
pim := '
MyPSM <<CormasModel>> {
}
VegetationUnit <<Entity>> {
	biomass : Integer = 0
}' asClassDiagram.
pim name: 'Model'.
pim allClasses second attributes first unit: 'kg'.

psm := UCMVWPimToPsmTransformer new generateFor: pim with: nil.

writer := UCMVWXmlExporter new.
(writer writeModel: psm).
"
'D:\import.xml.st' asFileReference
	ensureDelete;
	writeStreamDo: [ :str |
		str nextPutAll: (writer writeModel: psm).
	].
"
]

{ #category : 'initialization' }
UCMVWXmlExporter >> initialize [
	super initialize.
	namespaceEnvironment := 'CormasNS.Models'.
	packageName := 'UnknownModel'.
	environment := namespaceEnvironment , '.' , packageName
]

{ #category : 'helpers' }
UCMVWXmlExporter >> sortedHierarchyFor: classes [
	^ classes asArray
		sorted: [ :a :b | (b superclassHierarchy includes: a) | (a superclassHierarchy includes: b) not ]
]

{ #category : 'as yet unclassified' }
UCMVWXmlExporter >> superClassFor: aClass [
	aClass stereotypes
		ifEmpty: [ ^ aClass anySuperclass
				ifNil: [ 'Core.Object' ]
				ifNotNil: [ :sup | environment , '.' , sup name ] ].
	^ 'CormasNS.Kernel.' , aClass stereotypes first name
]

{ #category : 'as yet unclassified' }
UCMVWXmlExporter >> writeClassesIn: aModel [
	(self sortedHierarchyFor: aModel allClasses)
		do: [ :each | 
			writer
				tag: 'class'
				with: [ writer
						tag: 'name' with: each name;
						tag: 'environment' with: environment;
						tag: 'super' with: (self superClassFor: each);
						tag: 'private' with: 'false';
						tag: 'indexed-type' with: 'none';
						tag: 'inst-vars'
							with: (((each attributes reject: #isStatic) collect: #name) joinUsing: ' ');
						tag: 'class-inst-vars'
							with: (((each attributes select: #isStatic) collect: #name) joinUsing: ' ');
						tag: 'imports' with: '';
						tag: 'category' with: packageName , 'Category';
						tag: 'attributes' with: [ writer tag: 'package' with: packageName ] ] ]
]

{ #category : 'as yet unclassified' }
UCMVWXmlExporter >> writeForgetMethod [
	writer
		tag: 'methods'
		with: [ writer
				tag: 'class-id' with: 'CormasNS.Kernel.Entity';
				tag: 'category' with: '-accessing'.
			writer
				tag: 'body'
				attributes: (Dictionary with: #package -> 'Cormas' with: 'selector' -> 'forgetAttribute:')
				with:
					'forgetAttribute: aSymbol
	self instVarAt: (self class instVarIndexFor: aSymbol) put: nil' ]
]

{ #category : 'as yet unclassified' }
UCMVWXmlExporter >> writeMetadata [
	| time |
	time := DateAndTime now truncated.
	writer
		tag: 'time-stamp'
		with:
			('OpenPonk UML Class Editor v{1}, on {2}'
				format:
					{OPUmlOldClassPlugin new version.
					time asDate asString , ' at ' , time asTime asString}).
	writer
		tag: 'component-property'
		with: [ writer
				tag: 'name' with: packageName;
				tag: 'type' with: 'package';
				tag: 'property' with: 'packageName';
				tag: 'value' with: '''' , packageName , '''' ].
	writer
		tag: 'component-property'
		with: [ writer
				tag: 'name' with: packageName;
				tag: 'type' with: 'package';
				tag: 'property' with: 'parcelName';
				tag: 'value' with: '''' , packageName , '''' ].
	^ writer
		tag: 'name-space'
		with: [ writer
				tag: 'name' with: packageName;
				tag: 'environment' with: namespaceEnvironment;
				tag: 'private' with: 'false';
				tag: 'imports'
					with: 'private Smalltalk.*' , String lf , 'private CormasNS.Kernel.*';
				tag: 'category' with: packageName , 'Category';
				tag: 'attributes'
					with: [ writer tag: 'package' with: packageName ] ]
]

{ #category : 'as yet unclassified' }
UCMVWXmlExporter >> writeMethodsIn: aModel [
	(self sortedHierarchyFor: aModel allClasses)
		do: [ :cls | 
			((cls methods reject: #isStatic) groupedBy: #protocol)
				valuesDo: [ :group | 
					group
						ifNotEmpty: [ writer
								tag: 'methods'
								with: [ writer
										tag: 'class-id' with: environment , '.' , cls name;
										tag: 'category' with: group anyOne protocol.
									group
										do: [ :method | 
											writer
												tag: 'body'
												attributes: (Dictionary with: #package -> packageName with: 'selector' -> method name)
												with: method sourceText ] ] ] ].
			((cls methods select: #isStatic) groupedBy: #protocol)
				valuesDo: [ :group | 
					group
						ifNotEmpty: [ writer
								tag: 'methods'
								with: [ writer
										tag: 'class-id' with: environment , '.' , cls name , ' class';
										tag: 'category' with: group anyOne protocol.
									group
										do: [ :method | 
											writer
												tag: 'body'
												attributes: (Dictionary with: #package -> packageName with: 'selector' -> method name)
												with: method sourceText ] ] ] ] ]
]

{ #category : 'as yet unclassified' }
UCMVWXmlExporter >> writeModel: aModel [
	aModel
		detect:
			[ :each | each stereotypes isNotEmpty and: [ each stereotypes first name = 'CormasModel' ] ]
		ifFound: [ :each | packageName := each name ].
	environment := namespaceEnvironment , '.' , packageName.
	writer := XMLWriter new.
	writer
		writeWith: [ :w | 
			writer
				enablePrettyPrinting;
				xml;
				comment: 'Generated from Pharo.'.
			writer
				tag: 'st-source'
				with: [ self writeMetadata.
					self writeClassesIn: aModel.
					self writeForgetMethod.
					self writeMethodsIn: aModel ] ].
	^ writer contents
]
