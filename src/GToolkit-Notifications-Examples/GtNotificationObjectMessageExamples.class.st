Class {
	#name : #GtNotificationObjectMessageExamples,
	#superclass : #GtNotificationCommonExamples,
	#category : #'GToolkit-Notifications-Examples'
}

{ #category : #accessing }
GtNotificationObjectMessageExamples >> notificationElement [
	<gtExample>
	| notification element |
	notification := self notificationEvent.
	element := notification asElement.
	
	self assert: element notification equals: notification.
	self 
		assert: element inspectButton label asString 
		equals: 'Inspect the object'.
	
	^ element
]

{ #category : #accessing }
GtNotificationObjectMessageExamples >> notificationEvent [
	<gtExample>
	| notificationEvent message targetObject |
	notificationEvent := GtObjectNotificationMessage new.
	message := 'An object to inspect'.
	targetObject := Object new.
	notificationEvent 
		message: message;
		object: targetObject;
		tooltip: 'Inspect the object'.
	
	self assert: notificationEvent message equals: message.
	self assert: notificationEvent object equals: targetObject.
	
	^ notificationEvent
]
