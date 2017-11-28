accessing
contextMenuMapping
	^ {[ :obj | obj oclIsKindOf: #Package ]
		->
			{'Export as XMI...' -> [ :pkg | OPUmlClassEditorPlugin exportPackage: pkg ].
			'Import from XMI...' -> [ :pkg | OPUmlClassEditorPlugin importToPackage: pkg ]}.
	[ :obj | obj oclIsKindOf: #Profile ]
		-> {'Generate...' -> [ :pkg | OPUmlProfileGeneratorWizard openOn: pkg ]}}