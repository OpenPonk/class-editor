public-exporting
export: aModel
	| visitor |
	visitor := DCUmlXmiExportVisitor new.
	^ visitor export: aModel