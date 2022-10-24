Class {
	#name : #GtNotificationSummary,
	#superclass : #BlElement,
	#instVars : [
		'notifications',
		'updater'
	],
	#category : #'GToolkit-Notifications-UI'
}

{ #category : #accessing }
GtNotificationSummary >> initialize [
	super initialize.
	
	updater := BrElementUpdater new
		element: self
		selector: #updateSummaryContent.
	updater postponedDuration: 1 seconds.
]

{ #category : #accessing }
GtNotificationSummary >> notifications [
	^ notifications
]

{ #category : #accessing }
GtNotificationSummary >> notifications: aCollection [
	self assert: [ aCollection notNil ].
	
	notifications ifNotNil: [ 
		self unsubscribeFromNotifications].

	notifications := aCollection.
	self subscribeToNotifications.
	
	self onNotificationsChanged
]

{ #category : #accessing }
GtNotificationSummary >> onNotificationsChanged [
	self requestUpdate
]

{ #category : #updating }
GtNotificationSummary >> requestUpdate [
	updater requestUpdate
]

{ #category : #subscriptions }
GtNotificationSummary >> subscribeToNotifications [
	"Subclasses can decide to subscribe to announcements from their domain"
]

{ #category : #subscriptions }
GtNotificationSummary >> unsubscribeFromNotifications [
	"Subclasses should unsubscribe from domain announcements"
]

{ #category : #updating }
GtNotificationSummary >> updateSummaryContent [
	"Implemented by subclasses to update the content of the summary"
]
