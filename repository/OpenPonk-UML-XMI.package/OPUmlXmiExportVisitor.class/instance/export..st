visitor
export: aModel
	| exporter exporterVersion |
	exporter := 'DynaCASE Class Editor'.
	exporterVersion := '0.1+alpha'.
	writer
		tag: #xmi:XMI
		attributes:
			(Dictionary
				with: #xmi:version -> '2.1'
				with: #xmlns:uml -> 'http://schema.omg.org/spec/UML/2.1'
				with: #xmlns:xmi -> 'http://schema.omg.org/spec/XMI/2.1')
		with: [ writer
				tag: #xmi:Documentation
				attributes:
					(Dictionary with: #exporter -> exporter with: #exporterVersion -> exporterVersion).
			writer
				tag: #uml:Model
				attributes: (Dictionary with: #xmi:type -> 'uml:Model' with: 'name' -> 'DC_Model')
				with: [ self visitModel: aModel ].
			writer
				tag: #xmi:Extension
				attributes: (Dictionary with: #extender -> exporter with: #extenderID -> exporterVersion)
				with: [ self visitExtension: aModel ] ].
	^ writer contents