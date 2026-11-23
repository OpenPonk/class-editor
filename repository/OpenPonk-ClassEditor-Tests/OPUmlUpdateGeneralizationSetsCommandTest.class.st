"
Tests transactional execution, undo, redo, affected generalization tracking, and view model notifications for generalization set updates.
"
Class {
	#name : 'OPUmlUpdateGeneralizationSetsCommandTest',
	#superclass : 'TestCase',
	#instVars : [
		'package',
		'generalization',
		'generalizationSet',
		'projectController'
	],
	#category : 'OpenPonk-ClassEditor-Tests-Commands',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'Commands'
}

{ #category : 'running' }
OPUmlUpdateGeneralizationSetsCommandTest >> setUp [

	| project classGeneral classSpecific |
	super setUp.
	project := OPProject named: 'GenSetsCommandTestProject'.
	package := OPUMLPackage new
		           name: 'TestPackage';
		           yourself.
	classGeneral := OPUMLClass new
		                name: 'GeneralClass';
		                yourself.
	classSpecific := OPUMLClass new
		                 name: 'SpecificClass';
		                 yourself.
	package packagedElements
		add: classGeneral;
		add: classSpecific.
	generalization := OPUMLGeneralization new
		                  general: classGeneral;
		                  specific: classSpecific;
		                  yourself.
	classSpecific generalizations add: generalization.
	generalizationSet := OPUMLGeneralizationSet new
		                     name: 'InitialSet';
		                     yourself.
	generalizationSet generalizations add: generalization.
	package packagedElements add: generalizationSet.
	project addModel: package.
	projectController := OPProjectController forProject: project
]

{ #category : 'tests' }
OPUmlUpdateGeneralizationSetsCommandTest >> testAddRemoveAndMembershipChangesUndoRedoAndIdempotentIfAbsent [

	| newSet command |
	newSet := OPUMLGeneralizationSet new
		          name: 'AddedSet';
		          yourself.
	command := OPUmlUpdateGeneralizationSetsCommand new.
	command recordAddSet: newSet toPackage: package.
	command recordMembershipChangeOn: newSet added: { generalization } removed: #(  ).
	command recordMembershipChangeOn: generalizationSet added: #(  ) removed: { generalization }.
	command recordRemoveSet: generalizationSet fromPackage: package generalizations: { generalization }.

	command execute.
	self assertCollection: package packagedElements includesAll: { newSet }.
	self denyCollection: package packagedElements includesAny: { generalizationSet }.
	self assertCollection: newSet generalizations hasSameElements: { generalization }.
	self assertEmpty: generalizationSet generalizations.

	"Re-executing when already removed exercises ifAbsent: paths safely"
	command execute.
	self assertEmpty: generalizationSet generalizations.

	command undo.
	self assertCollection: package packagedElements includesAll: { generalizationSet }.
	self denyCollection: package packagedElements includesAny: { newSet }.
	self assertCollection: generalizationSet generalizations hasSameElements: { generalization }.
	self assertEmpty: newSet generalizations.

	"Re-undoing when already undone exercises undo ifAbsent: paths safely"
	command undo.
	self denyCollection: package packagedElements includesAny: { newSet }
]

{ #category : 'tests' }
OPUmlUpdateGeneralizationSetsCommandTest >> testIsEmptyAndIsSetMarkedForRemoval [

	| command otherSet |
	otherSet := OPUMLGeneralizationSet new
		            name: 'OtherSet';
		            yourself.
	generalizationSet uuid.
	otherSet uuid.
	command := OPUmlUpdateGeneralizationSetsCommand new.

	self assert: command isEmpty description: 'Fresh command must be empty'.
	self deny: (command isSetMarkedForRemoval: generalizationSet) description: 'Fresh command has no sets marked for removal'.

	command recordRemoveSet: generalizationSet fromPackage: package generalizations: { generalization }.

	self deny: command isEmpty description: 'Command with removal must not be empty'.
	self assert: (command isSetMarkedForRemoval: generalizationSet) description: 'Recorded set must be marked for removal'.
	self deny: (command isSetMarkedForRemoval: otherSet) description: 'Unrecorded set must not be marked for removal'
]

{ #category : 'tests' }
OPUmlUpdateGeneralizationSetsCommandTest >> testRecordPropertyChangeExecuteUndoRedoAndNotifyAffectedGeneralizations [

	| generalizationViewModel changeCount command |
	generalizationViewModel := projectController viewModelRegistry viewModelFor: generalization.
	changeCount := 0.
	generalizationViewModel announcer when: OPModelChanged do: [ changeCount := changeCount + 1 ] for: self.

	command := OPUmlUpdateGeneralizationSetsCommand new.
	command viewModelRegistry: projectController viewModelRegistry.
	command
		recordPropertyChangeOn: generalizationSet
		oldName: 'InitialSet'
		newName: 'UpdatedSet'
		oldIsCovering: false
		newIsCovering: true
		oldIsDisjoint: false
		newIsDisjoint: true.

	self assertCollection: command allAffectedGeneralizations hasSameElements: { generalization }.

	command execute.
	self assert: generalizationSet name equals: 'UpdatedSet'.
	self assert: generalizationSet isCovering description: 'Execute must apply isCovering'.
	self assert: generalizationSet isDisjoint description: 'Execute must apply isDisjoint'.
	self assert: changeCount equals: 1.

	command undo.
	self assert: generalizationSet name equals: 'InitialSet'.
	self deny: generalizationSet isCovering description: 'Undo must restore isCovering'.
	self deny: generalizationSet isDisjoint description: 'Undo must restore isDisjoint'.
	self assert: changeCount equals: 2
]
