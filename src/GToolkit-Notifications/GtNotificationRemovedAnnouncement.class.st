Class {
	#name : #GtNotificationRemovedAnnouncement,
	#superclass : #GtNotificationsChangedAnnouncement,
	#instVars : [
		'removedNotification'
	],
	#category : #'GToolkit-Notifications-Announcements'
}

{ #category : #accessing }
GtNotificationRemovedAnnouncement >> removedNotification [
	^ removedNotification
]

{ #category : #accessing }
GtNotificationRemovedAnnouncement >> removedNotification: aNotification [
	removedNotification := aNotification
]
