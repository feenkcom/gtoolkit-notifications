Extension { #name : #Exception }

{ #category : #'*GToolkit-Notifications-Extensions' }
Exception >> asNotification [
	^ GtObjectNotificationMessage new
		message: ('[{1}] {2}'
				format: {self class name.
						self messageText});
		object: self copy freeze;
		showNotifications
]
