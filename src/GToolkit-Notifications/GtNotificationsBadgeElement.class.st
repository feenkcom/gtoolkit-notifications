Class {
	#name : #GtNotificationsBadgeElement,
	#superclass : #GtNotificationsElement,
	#instVars : [
		'listElement',
		'badgeElement',
		'dropdownBadgeElement',
		'badgeContainer',
		'dropdownBadgeContainer'
	],
	#category : #'GToolkit-Notifications-Badge'
}

{ #category : #initialization }
GtNotificationsBadgeElement >> badgeContainer [
	^ badgeContainer
]

{ #category : #'private - accessing' }
GtNotificationsBadgeElement >> badgeElement [
	<return: #BrBadge>
	^ badgeElement
]

{ #category : #initialization }
GtNotificationsBadgeElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #'private - instance creation' }
GtNotificationsBadgeElement >> dropdownBadgeContainer [
	^ dropdownBadgeContainer
]

{ #category : #'private - accessing' }
GtNotificationsBadgeElement >> dropdownBadgeElement [
	<return: #BrBadge>
	^ dropdownBadgeElement
]

{ #category : #'api - visibility' }
GtNotificationsBadgeElement >> hide [
	^ self visibility: BlVisibility hidden
]

{ #category : #initialization }
GtNotificationsBadgeElement >> initialize [
	super initialize.
	
	self viewModel: BrWidgetModel new.
	self fitContent.
	
	self initializeListElement.
	self initializeDropdownBadgeElement.
	self initializeBadgeElement.
	
	self addChild: self badgeContainer as: #badge.
	
	self addAptitude: (BrLayoutResizerAptitude new anyToFitContent).
]

{ #category : #initialization }
GtNotificationsBadgeElement >> initializeBadgeElement [
	badgeElement := self newBadge label: '0'.
	badgeContainer := BrHorizontalPane new
			addChild: badgeElement;
			addAptitude: ((BrGlamorousWithDropdownAptitude
					handle: [ self newDropdownBadge ]
					content: [ self newDropdownContent ]) preferredExtent: 600 @ 600);
			height: 21;
			hFitContent;
			background: Color white
]

{ #category : #initialization }
GtNotificationsBadgeElement >> initializeDropdownBadgeElement [
	dropdownBadgeElement := self newBadge
		label: '0'.
	dropdownBadgeContainer := BrHorizontalPane new
			addChild: dropdownBadgeElement;
			height: 21;
			hFitContent;
			background: Color white
]

{ #category : #initialization }
GtNotificationsBadgeElement >> initializeListElement [
	listElement := GtNotificationsListElement new
		hExact: 300;
		vFitContentLimited;
		padding: (BlInsets top: 5 right: 0 bottom: 5 left: 0);
		notifications: self notifications;
		geometry: (BlRoundedRectangleGeometry cornerRadius: 4).
]

{ #category : #'private - accessing' }
GtNotificationsBadgeElement >> listElement [
	<return: #GtNotificationsListElement>
	^ listElement.
]

{ #category : #'private - instance creation' }
GtNotificationsBadgeElement >> newBadge [
	^ BrBadge new
		aptitude: BrGlamorousBadgeWithLabelAptitude;
		exact: 21@21
]

{ #category : #'private - instance creation' }
GtNotificationsBadgeElement >> newDropdownBadge [
	^ self dropdownBadgeContainer
		removeFromParent
]

{ #category : #'private - instance creation' }
GtNotificationsBadgeElement >> newDropdownContent [
	^ self listElement
		removeFromParent
]

{ #category : #'private - updating' }
GtNotificationsBadgeElement >> notificationsGroupedBySummaryClass [
	| notificationGroup |

	notificationGroup := self notifications asArray groupedBy: #summaryClass.
	notificationGroup removeKey: nil ifAbsent: [].
	^ notificationGroup
]

{ #category : #accessing }
GtNotificationsBadgeElement >> onNotificationsChanged [
	super onNotificationsChanged.
	self listElement notifications: self notifications.
]

{ #category : #'api - visibility' }
GtNotificationsBadgeElement >> show [
	^ self visibility: BlVisibility visible
]

{ #category : #'private - updating' }
GtNotificationsBadgeElement >> updateBadgeContainer [

	self removeChildNamed: #badge.
	self initializeBadgeElement.
	self addChild: self badgeContainer as: #badge.

	self notificationsGroupedBySummaryClass
		keysAndValuesDo: [ :aSummary :aNotificationsCollection | badgeContainer addChild: (aSummary new notifications: aNotificationsCollection) ]
]

{ #category : #'private - updating' }
GtNotificationsBadgeElement >> updateDropdownBadgeContainer [
	self initializeDropdownBadgeElement.

	self notificationsGroupedBySummaryClass 
		keysAndValuesDo: [ :aSummary :aNotificationsCollection | 
			dropdownBadgeContainer addChild: (aSummary new notifications: aNotificationsCollection) ].
]

{ #category : #'private - updating' }
GtNotificationsBadgeElement >> updateElement [
	super updateElement.
	self updateBadgeContainer.
	self badgeElement label: self notificationsCount.
	self updateDropdownBadgeContainer.
	self dropdownBadgeElement label: self notificationsCount.
	self updateVisibility
]

{ #category : #'private - updating' }
GtNotificationsBadgeElement >> updateVisibility [
	self notificationsCount isZero
		ifTrue: [ self hide ]
		ifFalse: [ self show ]
]
