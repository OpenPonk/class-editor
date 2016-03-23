visitor
export: aModel
	writer
		tag: #xmi:XMI
		attributes:
			(Dictionary
				with: #xmi:version -> '2.1'
				with: #xmlns:uml -> 'http://schema.omg.org/spec/UML/2.1'
				with: #xmlns:xmi -> 'http://schema.omg.org/spec/XMI/2.1')
		with: [ writer
				tag: #xmi:Documentation
				attributes: (Dictionary with: #exporter -> 'DynaCASE' with: #exporterVersion -> '0.1+alpha').
			writer
				tag: #uml:Model
				attributes: (Dictionary with: #xmi:type -> 'uml:Model' with: 'name' -> 'DC_Model')
				with: [ self visitModel: aModel ] ].
	^ writer contents