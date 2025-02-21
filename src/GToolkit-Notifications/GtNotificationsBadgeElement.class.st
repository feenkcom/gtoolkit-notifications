"
{{gtClass:GtNotificationsBadgeElement}} shows a {{gtClass:GtNotifications}} list using a dropdown that displays a badge with the summary when collapsed, and the list of notifications when expanded.

To show the list of notifications when the dropdown is expanded it delegates to a {{gtClass:name=GtNotificationsListElement}}. 
For the content of the badge is displays:
	- the number of notifications
	- a set of summaries for groups of notifications of the same type ({{gtMethod:name=GtNotificationsBadgeElement>>notificationsGroupedBySummaryClass|label=#selector}}).
	
For the summary, all notifications that have the same summary (return the same value for {{gtMethod:GtNotificationEvent>>summaryClass}}) are grouped together and displayed using a {{gtClass:name=GtNotificationSummary}}.

"
Class {
	#name : #GtNotificationsBadgeElement,
	#superclass : #GtNotificationsElement,
	#instVars : [
		'listElement',
		'badgeElement',
		'dropdownBadgeElement',
		'badgeContainer',
		'dropdownBadgeContainer',
		'listElementContainer',
		'clearAllButton',
		'toolbar',
		'scrollPane'
	],
	#category : #'GToolkit-Notifications-Badge'
}

{ #category : #accessing }
GtNotificationsBadgeElement >> actOnNotificationAddedFor: anAnnouncement [
	super actOnNotificationAddedFor: anAnnouncement.
	
	anAnnouncement addedNotification ifNotNil: [ :aNotification |
		aNotification shouldShowNotifications ifTrue: [
			badgeContainer dispatchEvent: (BrDropdownShowWish new
				anchor: badgeContainer) ] ]
]

{ #category : #initialization }
GtNotificationsBadgeElement >> badgeContainer [
	^ badgeContainer
]

{ #category : #'private - accessing' }
GtNotificationsBadgeElement >> badgeElement [
	<return: #BrBadge>
	^ badgeElement
]

{ #category : #'private - accessing' }
GtNotificationsBadgeElement >> clearAllButton [
	^ clearAllButton
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
	clearAllButton visibility: BlVisibility hidden.
	^ self visibility: BlVisibility hidden
]

{ #category : #initialization }
GtNotificationsBadgeElement >> initialize [
	super initialize.
	
	self viewModel: BrWidgetModel new.
	self fitContent.
	
	self initializeListElementContainer.
	self initializeDropdownBadgeElement.
	self initializeBadgeElement.
	
	self addChild: self badgeContainer as: #badge.
	
	self addAptitude: (BrLayoutResizerAptitude new anyToFitContent).
]

{ #category : #initialization }
GtNotificationsBadgeElement >> initializeBadgeElement [
	badgeElement := self newBadge text: '0'.
	badgeContainer := BrHorizontalPane new
			addChild: badgeElement;
			addAptitude: ((BrGlamorousWithDropdownAptitude
					handle: [ self newDropdownBadge ]
					content: [ self newDropdownContent ]) preferredExtent: 600 @ 600);
			height: 21;
			hFitContent;
			background: Color orange;
			geometry: (BlRoundedRectangleGeometry cornerRadius: 4)
]

{ #category : #initialization }
GtNotificationsBadgeElement >> initializeClearAllButton [
	clearAllButton := BrButton new
			aptitude: BrGlamorousButtonWithIconAptitude;
			icon: BrGlamorousVectorIcons close;
			id: GtMethodCoderSaveActionId;
			label: 'Clear all notifications';
			beTinySize;
			action: [ :aButtonElement :aButtonModel :anEvent | self notifications releaseNotifications ];
			yourself
]

{ #category : #initialization }
GtNotificationsBadgeElement >> initializeDropdownBadgeElement [
	dropdownBadgeElement := self newBadge text: '0'.
	dropdownBadgeContainer := BrHorizontalPane new
			addChild: dropdownBadgeElement;
			height: 21;
			hFitContent;
			background: Color orange
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

{ #category : #initialization }
GtNotificationsBadgeElement >> initializeListElementContainer [
	"When there are many notifications, they can only be viewed if the list is scrollable."

	self initializeListElement.
	self initializeToolbar.

	scrollPane := BrScrollPane new
			aptitude: BrScrollPaneAptitude 
				+ BrGlamorousWithVerticalScrollbarAptitude;
			hFitContent;
			content: listElement;
			yourself.

	listElementContainer := BrVerticalPane new
			addChild: scrollPane;
			addChild: toolbar;
			vFitContentLimited;
			hFitContent;
			yourself
]

{ #category : #initialization }
GtNotificationsBadgeElement >> initializeToolbar [
	self initializeClearAllButton.
	toolbar := BrToolbar new
			aptitude: BrGlamorousToolbarAptitude;
			addItem: clearAllButton;
			padding: (BlInsets all: 8 );
			yourself
]

{ #category : #'private - accessing' }
GtNotificationsBadgeElement >> listElement [
	<return: #GtNotificationsListElement>
	^ listElement.
]

{ #category : #accessing }
GtNotificationsBadgeElement >> listElementContainer [
	^ listElementContainer
]

{ #category : #'private - updating' }
GtNotificationsBadgeElement >> longListThreshold [
	"Threshold for moving the toolbar to the top."
	^ 10
]

{ #category : #'private - instance creation' }
GtNotificationsBadgeElement >> newBadge [
	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new
				foreground: Color white);
		background: Color orange;
		alignCenter;
		exact: 21 @ 21
]

{ #category : #'private - instance creation' }
GtNotificationsBadgeElement >> newDropdownBadge [
	^ self dropdownBadgeContainer
		removeFromParent
]

{ #category : #'private - instance creation' }
GtNotificationsBadgeElement >> newDropdownContent [
	^ self listElementContainer removeFromParent
]

{ #category : #'private - updating' }
GtNotificationsBadgeElement >> notificationSummaryElements [
	^ self badgeContainer children asArray copyWithoutFirst
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

{ #category : #'hooks - children' }
GtNotificationsBadgeElement >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph.
	
	notifications ifNil: [ ^ self ].
	notifications releaseNotifications
]

{ #category : #'private - accessing' }
GtNotificationsBadgeElement >> scrollPane [
	^ scrollPane
]

{ #category : #'api - visibility' }
GtNotificationsBadgeElement >> show [
	clearAllButton visibility: BlVisibility visible.
	^ self visibility: BlVisibility visible
]

{ #category : #'private - updating' }
GtNotificationsBadgeElement >> updateBadgeContainer [

	self notificationSummaryElements do: [ :aNotificationSummaryElement |
		aNotificationSummaryElement unsubscribeFromNotifications ].

	self removeChildNamed: #badge.
	self initializeBadgeElement.
	self addChild: self badgeContainer as: #badge.

	self notificationsGroupedBySummaryClass
		keysAndValuesDo: [ :aSummaryClass :aNotificationsCollection | 
			badgeContainer addChild: (aSummaryClass new 
				notifications: aNotificationsCollection) ]
]

{ #category : #'private - updating' }
GtNotificationsBadgeElement >> updateDropdownBadgeContainer [
	"Remove summaries, but not the badge itself"
	dropdownBadgeContainer children size 
		to: 2 
		by: -1
		do: [ :anIndex | 
			| aNotificationSummaryElement |
			aNotificationSummaryElement := dropdownBadgeContainer childAt: anIndex.
			aNotificationSummaryElement unsubscribeFromNotifications.
			dropdownBadgeContainer removeChildAt: anIndex ].
		
	"Update summaries"
	self notificationsGroupedBySummaryClass
		keysAndValuesDo: [ :aSummary :aNotificationsCollection | 
			dropdownBadgeContainer
				addChild: (aSummary new notifications: aNotificationsCollection) ]
]

{ #category : #'private - updating' }
GtNotificationsBadgeElement >> updateElement [
	super updateElement.
	
	self updateBadgeContainer.
	self badgeElement text: self notificationsCount.
	self updateDropdownBadgeContainer.
	self dropdownBadgeElement text: self notificationsCount.
	self updateVisibility
]

{ #category : #'private - updating' }
GtNotificationsBadgeElement >> updateVisibility [
	self notificationsCount isZero
		ifTrue: [ self hide ]
		ifFalse: [ self show ]
]
