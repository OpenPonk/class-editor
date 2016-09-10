as yet unclassified
writeMetadata
	| time |
	time := DateAndTime now truncated.
	writer
		tag: 'time-stamp'
		with:
			('OpenPonk UML Class Editor v{1}, on {2}'
				format:
					{DCUmlClassPlugin new version.
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
				tag: 'imports' with: 'private Smalltalk.*' , String lf , 'private CormasNS.Kernel.*';
				tag: 'category' with: packageName , 'Category';
				tag: 'attributes' with: [ writer tag: 'package' with: packageName ] ]