bytecode decoding
computeVarType
	| info tempNames name |
	types ifEmpty: [ ^ nil ].
	info := types first.
	(hasSend and: [ info isDefinedByMessageSend not ]) ifTrue: 
		[ info type: nil.
		^ info ].
	info isDefinedByTemporary ifFalse: [ ^ info ].
	tempNames := (receiverClass compilerClass new 
		parse: currentMethod getSourceFromFile asString
		in: receiverClass
		notifying: nil) tempNames.
	name := tempNames at: info temporaryOffset + 1.
	info type: (self class getClassFromTypeSuggestingName: name).
	^ info