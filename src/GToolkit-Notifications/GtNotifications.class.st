Class {
	#name : #GtNotifications,
	#superclass : #Object,
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#instVars : [
		'collection',
		'mutex',
		'announcer'
	],
	#category : #'GToolkit-Notifications-Basic'
}

{ #category : #'api - adding / removing' }
GtNotifications >> addNotification: aNotification [
	mutex critical: 
			[(collection anySatisfy: [:each | each = aNotification])
				ifFalse: 
					[collection addFirst: aNotification.
					aNotification onRemovalRequestSend: #onRemovalRequest: to: self.
					aNotification addedTo: self]].
	self notifyNotificationsAddedFor: aNotification
]

{ #category : #announcer }
GtNotifications >> announcer [
	<return: #Announcer>
	^ announcer
]

{ #category : #'api - converting' }
GtNotifications >> asArray [
	^ mutex critical: [ 
		collection asArray ]
]

{ #category : #accessing }
GtNotifications >> do: aBlock [
	mutex critical: [ collection do: aBlock ]
]

{ #category : #'gt-extensions' }
GtNotifications >> gtNotificationsFor: aView [
	<gtView>
	collection ifNil: [ ^ aView empty ].
	
	^ aView list
		title: 'Notifications';
		items: [ self asArray ];
		updateWhen: GtNotificationsChangedAnnouncement in: self
]

{ #category : #initialization }
GtNotifications >> initialize [
	super initialize.
	mutex := Mutex new.
	collection := LinkedList new.
	announcer := Announcer new.
]

{ #category : #'private - notifying' }
GtNotifications >> notifyNotificationsAddedFor: aNotification [
	self announce: (GtNotificationAddedAnnouncement new 
		notifications: self;
		addedNotification: aNotification)
]

{ #category : #'private - notifying' }
GtNotifications >> notifyNotificationsRemovedFor: aNotification [
	self announce: (GtNotificationRemovedAnnouncement new
		notifications: self;
		removedNotification: aNotification)
]

{ #category : #'private - announcement handling' }
GtNotifications >> onRemovalRequest: anAnnouncement [
	self removeNotification: anAnnouncement notification.
]

{ #category : #'api - adding / removing' }
GtNotifications >> releaseNotifications [
	"I am called from
	{{gtMethod: GtNotificationsBadgeElement >> #onRemovedFromSceneGraph }}. 
	The purpose is to remove any notification resources, e.g., embedded debuggers
	when a window is closed. It is assumed that notifications are global and
	unique for one window (BlSpace)."
	
	self asArray do: [ :eachNotification | 
		self removeNotification: eachNotification ]
]

{ #category : #'api - adding / removing' }
GtNotifications >> removeNotification: aNotification [
	mutex critical: [ 
		collection 
			remove: aNotification
			ifAbsent: [ "ignore" ^ self ].
		aNotification unsubscribe: self.
		aNotification removedFrom: self ].
		
	self notifyNotificationsRemovedFor: aNotification
]

{ #category : #'api - accessing' }
GtNotifications >> size [
	<return: #Integer>
	^ mutex critical: [ collection size ]
]
