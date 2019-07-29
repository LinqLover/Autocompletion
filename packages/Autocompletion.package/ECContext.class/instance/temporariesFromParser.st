accessing
temporariesFromParser
	| tempRanges |
	tempRanges := ranges haltOnce
				select: [:each | #(#patternTempVar #patternArg #undefinedIdentifier) includes: each type].
	tempRanges addAll: self blockTemporaries.
	^ tempRanges
		collect: [:each | ECLocalEntry
				contents: (self sourceOf: each)
				type: each type]