public-exporting
export: aModel
	| visitor |
	visitor := OPUmlXmiExportVisitor new.
	^ visitor export: aModel