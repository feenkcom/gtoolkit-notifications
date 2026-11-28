Class {
	#name : #GtNotificationForwarder,
	#superclass : #Object,
	#traits : 'TGtUniqueInstance',
	#classTraits : 'TGtUniqueInstance classTrait',
	#category : #'GToolkit-Notifications-Basic'
}

{ #category : #'api - notification' }
GtNotificationForwarder class >> showNotification: aNotification [
	self default showNotification: aNotification
]

{ #category : #'api - space' }
GtNotificationForwarder class >> spaceDo: aBlock [
	self default spaceDo: aBlock
]

{ #category : #'api - space' }
GtNotificationForwarder >> anotherSpaceDo: aBlock [
	"Find a focused space"
	self focusedSpaceDo: [ :aSpace | ^ aBlock cull: aSpace ].

	"There is no a focused space, find any opened space"
	self openedSpaceDo: [ :aSpace | aBlock cull: aSpace ]
]

{ #category : #'api - space' }
GtNotificationForwarder >> focusedSpaceDo: aBlock [
	"Find a focused space"

	BlSpace
		allOpenSpacesDo: [ :aSpace | aSpace isFocused ifTrue: [ ^ aBlock cull: aSpace ] ]
]

{ #category : #'api - space' }
GtNotificationForwarder >> isProcessedSpace: aSpace [
	"Return true if a UI process pulses the universe of aSpace, so that tasks enqueued in the space are executed.
	In a headless image a space saved in the image (e.g. the world) is still open, but no UI process runs,
	so notifications added to it would accumulate in its task queue forever."

	<return: #Boolean>
	^ aSpace universe hasUIProcess
]

{ #category : #'api - space' }
GtNotificationForwarder >> notificationSpaceDo: aBlock [
	"Like #spaceDo:, but outside of a coder execution context ignore spaces
	that no UI process pulses (e.g. the world of a headless image).
	Notifications added to such spaces would accumulate in their task queue forever."

	GtCoderExecutionContextVariable
		spaceDo: [ :aSpace | aBlock cull: aSpace ]
		ifClosed: [ self
				anotherSpaceDo: [ :aSpace | 
					(self isProcessedSpace: aSpace) ifTrue: [ aBlock cull: aSpace ] ] ]
]

{ #category : #'api - space' }
GtNotificationForwarder >> openedSpaceDo: aBlock [
	"Find any opened space"

	BlSpace allOpenSpacesDo: [ :aSpace | ^ aBlock cull: aSpace ]
]

{ #category : #'api - notification' }
GtNotificationForwarder >> showNotification: aNotification [
	(aNotification job notNil
		and: [ aNotification job class name = #IceExternalJob ])
		ifTrue: [  "Ignore iceberg progress notifications.
				https://github.com/feenkcom/gtoolkit/issues/4680"^ self ].

	self notificationSpaceDo: [ :aSpace | aSpace showNotification: aNotification ]
]

{ #category : #'api - space' }
GtNotificationForwarder >> spaceDo: aBlock [
	GtCoderExecutionContextVariable
		spaceDo: [ :aSpace | 
			aBlock cull: aSpace ]
		ifClosed: [ self anotherSpaceDo: aBlock ].
]
