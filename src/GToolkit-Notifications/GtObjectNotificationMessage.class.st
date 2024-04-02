"
GtObjectNotificationMessage extends {{gtClass:GtNotificationMessage}} to include an object with the text message which can be inspected.
"
Class {
	#name : #GtObjectNotificationMessage,
	#superclass : #GtNotificationMessage,
	#instVars : [
		'object',
		'tooltip'
	],
	#category : #'GToolkit-Notifications-Message'
}

{ #category : #accessing }
GtObjectNotificationMessage >> elementClass [
	"Return a class that when instantiated displayes the notification to user (as a widget)"
	<return: #GtNotificationEventElement>

	^ GtObjectNotificationMessageElement
]

{ #category : #accessing }
GtObjectNotificationMessage >> message: aString [

	super message: aString.
	self notifyNotificationDataChanged.
]

{ #category : #accessing }
GtObjectNotificationMessage >> object [
	^ object
]

{ #category : #accessing }
GtObjectNotificationMessage >> object: anObject [
	object := anObject
]

{ #category : #accessing }
GtObjectNotificationMessage >> tooltip [
	^ tooltip
]

{ #category : #accessing }
GtObjectNotificationMessage >> tooltip: aString [
	tooltip := aString
]
