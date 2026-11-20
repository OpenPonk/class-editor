Extension { #name : 'ClClockProfileFactory' }

{ #category : '*OpenPonk-ClassEditor-Profiles' }
ClClockProfileFactory >> openExample [

	<script: 'self new openExample'>
	(OPProject openOnModel: self modelWithAppliedStereotype) showAllElementsInAllDiagrams
]

{ #category : '*OpenPonk-ClassEditor-Profiles' }
ClClockProfileFactory >> openProfile [

	<script: 'self new openProfile'>
	(OPProject openOnModel: self class profile) showAllElementsInAllDiagrams
]
