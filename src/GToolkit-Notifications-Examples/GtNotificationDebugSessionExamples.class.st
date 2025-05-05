Class {
	#name : #GtNotificationDebugSessionExamples,
	#superclass : #GtNotificationCommonExamples,
	#instVars : [
		'sessions'
	],
	#category : #'GToolkit-Notifications-Examples'
}

{ #category : #'private - support' }
GtNotificationDebugSessionExamples >> addSession: aSession [
	self sessions add: aSession.
]

{ #category : #'examples - debug session' }
GtNotificationDebugSessionExamples >> basicDebugSessionElement [
	<gtExample>
	<return: #GtNotificationDebugSessionElement>
	| anElement |
	anElement := GtNotificationDebugSessionElement new.
	self assert: anElement notification isNil.
	^ anElement
]

{ #category : #'examples - debug session' }
GtNotificationDebugSessionExamples >> basicDebugSessionEvent [
	<gtExample>
	<return: #GtNotificationDebugSession>
	| anEvent |
	anEvent := GtNotificationDebugSession new.
	self assert: anEvent debugSession isNil.
	self assert: (anEvent asElement isKindOf: BlElement).
	^ anEvent
]

{ #category : #'examples - debug session' }
GtNotificationDebugSessionExamples >> debugSession [
	<gtExample>
	<after: #terminateSessions>
	<return: #DebugSession>
	| aContext aProcess aSession |
	aContext := [ 1 + 1 ] asContext.
	aProcess := Process
			forContext: aContext
			priority: Processor userInterruptPriority.
	aSession := aProcess
			newDebugSessionNamed: 'Example session'
			startedAt: aContext.
	self addSession: aSession.
	^ aSession
]

{ #category : #'examples - debug session' }
GtNotificationDebugSessionExamples >> debugSessionElement [
	<gtExample>
	<return: #GtNotificationDebugSessionElement>
	| anElement anEvent |
	anElement := self basicDebugSessionElement.
	anEvent := self debugSessionNotification.
	anElement notification: anEvent.
	self assert: anElement notification equals: anEvent.
	^ anElement
]

{ #category : #'examples - debug session' }
GtNotificationDebugSessionExamples >> debugSessionNotification [
	<gtExample>
	<return: #GtNotificationDebugSession>
	| anEvent aSession |
	anEvent := self basicDebugSessionEvent.
	aSession := self sharedDebugSession.
	anEvent debugSession: aSession.
	self assert: anEvent debugSession equals: aSession.
	self assert: (anEvent asElement isKindOf: BlElement).
	^ anEvent
]

{ #category : #'private - support' }
GtNotificationDebugSessionExamples >> sessions [
	^ sessions ifNil: [ sessions := OrderedCollection new ]
]

{ #category : #'examples - debug session' }
GtNotificationDebugSessionExamples >> sharedDebugSession [
	<gtExample>
	<return: #GtSharedDebugSession>
	| aSharedSession aPharoSession |
	aSharedSession := GtSharedDebugSession new.
	aPharoSession := self debugSession.
	aSharedSession session: aPharoSession.
	self assert: aSharedSession session equals: aPharoSession.
	^ aSharedSession
]

{ #category : #'private - support' }
GtNotificationDebugSessionExamples >> terminateSessions [
	self sessions do: [ :eachSession | 
		eachSession terminate ]
]
