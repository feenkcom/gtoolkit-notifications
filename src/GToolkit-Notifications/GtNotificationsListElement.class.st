"
{{gtClass:name=GtNotificationsListElement}} shows a list of notifications using custom widgets.

Each notification instance, subclassing {{gtClass:name=GtNotificationEvent}}, can override {{gtMethod:name=GtNotificationEvent>>#elementClass}} to indicate a widget for displaying that notification to the user. These widgets are graphical elements that subclass from {{gtClass:name=GtNotificationElement}}.
"
Class {
	#name : #GtNotificationsListElement,
	#superclass : #GtNotificationsElement,
	#instVars : [
		'listElement'
	],
	#category : #'GToolkit-Notifications-Badge'
}

{ #category : #initialization }
GtNotificationsListElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #initialization }
GtNotificationsListElement >> initialize [
	super initialize.
	self initializeList.
	self initializeListeners.
	
	self addChild: self listElement as: #notifications.
	
	self addAptitude: (BrLayoutResizerAptitude new inherit: self listElement).
]

{ #category : #initialization }
GtNotificationsListElement >> initializeList [
	listElement := BrSimpleList new
		itemType:[ :anItemTypeFactory :anItemObject :anItemIndex | 
			anItemObject elementClass ];
		itemStencil: [ :anEventElementClass :aListWidget | anEventElementClass new ];
		itemDataBinder:[ :aNotificationElement :aNotificationEvent :anItemIndex | 
			aNotificationElement notification: aNotificationEvent ];
		itemDataUnbinder: [ :aNotificationElement | 
			aNotificationElement actOnElementDetached ];
		items: self listItems
]

{ #category : #initialization }
GtNotificationsListElement >> initializeListeners [
	self 
		when: GtNotificationDismissWish 
		do: [ :anEvent | 
			self onNotificationDismissWish: anEvent notification.
			anEvent consumed: true. ]
]

{ #category : #'private - accessing' }
GtNotificationsListElement >> listElement [
	<return: #BrSimpleList>
	^ listElement
]

{ #category : #'private - accessing' }
GtNotificationsListElement >> listItems [
	^ self notifications asArray ifEmpty: [ { GtNotificationEvent empty } ]
]

{ #category : #'private - event handling' }
GtNotificationsListElement >> onNotificationDismissWish: aGtNotificationEvent [ 
	self removeNotification: aGtNotificationEvent
]

{ #category : #'private - updating' }
GtNotificationsListElement >> updateElement [
	"I must be called in a UI process."
	super updateElement.
	self listElement items: self listItems.
]
