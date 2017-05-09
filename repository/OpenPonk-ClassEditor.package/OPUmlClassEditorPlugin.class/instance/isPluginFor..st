accessing
isPluginFor: aModel
	^ aModel class = self modelClass | (aModel class = OPUMLPackage)