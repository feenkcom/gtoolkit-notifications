Class {
	#name : #GtNotificationCommonExamples,
	#superclass : #Object,
	#category : #'GToolkit-Notifications-Examples'
}

{ #category : #'examples - support' }
GtNotificationCommonExamples >> newSpace [
	<gtExample>
	<return: #BlSpace>
	| aSpace |
	aSpace := BlSpace new.
	aSpace host: BlHeadlessHost new.
	aSpace title: 'Async Element Examples'.
	aSpace extent: 600 @ 400.
	aSpace withCommonSettings.
	^ aSpace
]
