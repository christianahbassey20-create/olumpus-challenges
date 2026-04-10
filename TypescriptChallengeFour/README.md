Repository
https://github.com/guidepup/guidepup
Commit: 70dc7529d301737fb33ca99a09d157585713da1d

Title
Pattern-matching element navigation

navigateTo(target, options?) on the ScreenReader interface must navigate through items and return a NavigateToResult with found (boolean), phrase (matched text or empty string), steps (count of navigation moves), and visited (array of all phrases encountered during navigation); each navigation step must be recorded in spokenPhraseLog and itemTextLog identically to how individual next()/previous() calls record entries.
Target accepts a string for case-insensitive substring matching, a RegExp for pattern matching, or a predicate function receiving the phrase text and returning boolean; predicates that throw must be treated as non-matching.
Options support direction ("next" or "previous", default "next"), maxSteps (default 100), match ("spokenPhrase" or "itemText", default "spokenPhrase"), and elementType (string) to navigate by element kind using the platform's native element navigation keyboard commands. The following element types must be supported — shared by both platforms: heading, link, table, list, graphic, visitedLink; VoiceOver-only: control, boldText, italicText, underlinedText, plainText, styleChange, colorChange, fontChange, misspelledWord, headingOfSameLevel, differentItem, sameTypeItem; NVDA-only: button, checkbox, radioButton, comboBox, editField, formField, landmark, blockQuote, separator, frame, embeddedObject, annotation, spellingError, listItem, unvisitedLink, nonLinkedText, headingLevel1, headingLevel2, headingLevel3, headingLevel4, headingLevel5, headingLevel6. Unsupported element types on either platform must throw an error whose message contains the element type name.
Navigation must stop when a match is found, when maxSteps is reached, or when a cycle is detected; a cycle occurs when the phrase at the current position equals the phrase captured at the starting position before the first navigation step.
NavigateToOptions and NavigateToResult types and the MatchTarget type (the union of string, RegExp, and predicate) must be exported from the package entry point.
