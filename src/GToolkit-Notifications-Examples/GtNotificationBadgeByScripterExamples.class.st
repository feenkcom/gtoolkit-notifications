Class {
	#name : #GtNotificationBadgeByScripterExamples,
	#superclass : #GtNotificationByScripterExamples,
	#category : #'GToolkit-Notifications-Examples'
}

{ #category : #'examples - actions' }
GtNotificationBadgeByScripterExamples >> clickOnBadgeIn: aScripterOrStep do: aBlock [
	<gtExample>
		
	aScripterOrStep 
		substep: 'Notification dropdown'
		do: [ :aStep | 
		
			aStep click 
				label: 'Click on notification badge';
				onSpaceRoot;
				onChildAt: 2;
			play.
				
			aStep wait forEmptySpaceTaskQueue;
			play.
			
			aBlock cull: aStep ].
	
	^ aScripterOrStep
]

{ #category : #'examples - targets' }
GtNotificationBadgeByScripterExamples >> closeButtonTarget: aStep [
	<gtExample>
	aStep 
		onChildOfClass: GtNotificationBorderElement;
		id: #closeButton
]

{ #category : #'examples - inform message' }
GtNotificationBadgeByScripterExamples >> closeInformNotification [
	<gtExample>
	
	| aScripter |
	aScripter := self displayInformNotification.

	aScripter
		substep: 'Close notification'
		do: [ :aStep | 
			aStep click
				label: 'Click on close notification button';
				onTarget: [ :theClick | 
					self
						dropdownListItemElementTarget: theClick
						itemClass: GtNotificationMessageElement.
					self closeButtonTarget: theClick ];
			play.
			aStep wait forEmptySpaceTaskQueue;
			play.

			aStep check
				label: 'Check empty list';
				value: [ :aList | aList listElement items size ] equals: 1;
				onTarget: [ :theCheck | self dropdownListElementTarget: theCheck ];
			play.

			aStep check
				label: 'Check anchored badge label';
				satisfies: [ :aBadge | (aBadge isKindOf: BrLabel) and: [ aBadge text asString = '0' ] ];
				onTarget: [ :theCheckStep | self dropdownBadgeElementTarget: theCheckStep ];
			play ].

	^ aScripter
]

{ #category : #'examples - inform message' }
GtNotificationBadgeByScripterExamples >> displayInformNotification [
	<gtExample>
	| aScripter |
	aScripter := self informInSpace.
	
	self clickOnBadgeIn: aScripter do: [ :aStep |
		aStep check
			label: 'Check anchored badge list';
			satisfies: [ :aList | aList listElement items size = 1 ];
			onTarget: [ :theCheckStep |
				self dropdownListElementTarget: theCheckStep ];
			play.

		aStep check
			label: 'Check anchored badge label';
			satisfies: [ :aBadge | 
				(aBadge isKindOf: BrLabel) and: [
					aBadge text asString = '1' ] ];
			onTarget: [ :theCheckStep |
				self dropdownBadgeElementTarget: theCheckStep ];
			play ].
	
	^ aScripter
]

{ #category : #'examples - inform message' }
GtNotificationBadgeByScripterExamples >> displayObjectNotification [
	<gtExample>
	| aScripter |
	aScripter := self objectNotificationInSpace.
	
	self clickOnBadgeIn: aScripter do: [ :aStep |
		aStep check
			label: 'Check anchored badge list';
			satisfies: [ :aList | aList listElement items size = 1 ];
			onTarget: [ :theCheckStep |
				self dropdownListElementTarget: theCheckStep ];
			play.

		aStep check
			label: 'Check anchored badge label';
			satisfies: [ :aBadge | 
				(aBadge isKindOf: BrLabel) and: [
					aBadge text asString = '1' ] ];
			onTarget: [ :theCheckStep |
				self dropdownBadgeElementTarget: theCheckStep ];
			play.
				
		aStep check
			label: 'Check element type';
			onSpaceRoot;
			// GtObjectNotificationMessageElement;
			satisfies: [ :aNotificationElement | 
				aNotificationElement notification message = 'An object to inspect' ];
			play ].
	
	^ aScripter
]

{ #category : #'examples - inform message' }
GtNotificationBadgeByScripterExamples >> dropdownBadgeElementTarget: aStep [
	<gtExample>
	aStep
		onSpaceRoot;
		onBreadthFirstChildOfClass: BrAnchoredElement;
		onBreadthFirstChildOfClass: BrLabel.
	^ aStep
]

{ #category : #'examples - inform message' }
GtNotificationBadgeByScripterExamples >> dropdownListElementTarget: aStep [
	<gtExample>
	aStep
		onSpaceRoot;
		onBreadthFirstChildOfClass: BrAnchoredElement;
		onBreadthFirstChildOfClass: GtNotificationsListElement.
	^ aStep
]

{ #category : #'examples - inform message' }
GtNotificationBadgeByScripterExamples >> dropdownListItemElementTarget: aStep itemClass: aClass [
	<gtExample>
	self dropdownListElementTarget: aStep.
	aStep
		onBreadthFirstChildOfClass: aClass.
	^ aStep
]

{ #category : #'examples - inform message' }
GtNotificationBadgeByScripterExamples >> informCode [
	<gtExample>
	^ '[ BlBlocUIManagerNotification
	requestOrNil: #inform:
	with: { ''Example information'' } ] 
on: BlBlocUIManagerNotification 
do: [ :aNotification | 
	GtNotificationForwarder
		spaceDo: [ :aSpace | 
			aSpace root userData at: #exampleSpaceId put: aSpace id ].
	aNotification pass.
]'
]

{ #category : #'examples - inform message' }
GtNotificationBadgeByScripterExamples >> informInSpace [
	<gtExample>
	| aScripter |
	aScripter := self scripterForBlock: [
		self snippetWithInformCode ].
		
	aScripter check
		label: 'Check space height';
		value: [ :aSpace | aSpace height ]
		equals: 600;
		onSpace;
			play.

	aScripter check
		label: 'Check space width';
		value: [ :aSpace | aSpace width ]
		equals: 800;
		onSpace;
			play.
		
	aScripter 
		substep: 'Play code snippet'
		do: [ :aStep | 
		
			aStep click 
				label: 'Click on play button';
				onGtPharoSnippetPlayButton;
			play.
				
			aStep wait forEmptySpaceTaskQueue;
			play.
			
			aStep check 
				label: 'Check space ID stored in space root element';
				value: [ :aSpace | 
					aSpace root userData at: #exampleSpaceId ifAbsent: [ nil ] ]
				equals: [ :aSpace | aSpace id ];
				onSpace;
			play.
			
			aStep check
				label: 'Check two elements in space';
				value: [ :aRootElement | aRootElement children size ]
				equals: 2;
				onSpaceRoot;
			play.

			aStep check
				label: 'Check notification badge existence';
				value: [ :aRootElement | (aRootElement childAt: 2) class ]
				equals: GtNotificationsBadgeElement;
				onSpaceRoot;
			play.
								
			aStep check
				label: 'Check notification badge label';
				satisfies: [ :aBadgeElement |
					aBadgeElement badgeElement text asString = '1' ];
				onSpaceRoot;
				onChildAt: 2;
			play ].
	
	^ aScripter
]

{ #category : #'examples - object message' }
GtNotificationBadgeByScripterExamples >> objectNotificationInSpace [
	<gtExample>
	| aScripter |
	aScripter := self scripter.
	aScripter set 
		label: 'Initialize Space Content';
		element: [ BlElement new ].
	
	aScripter space showNotification: (GtNotificationObjectMessageExamples new 
		notificationEvent).
	aScripter play.
	
	aScripter 
		substep: 'Show notification'
		do: [ :aStep | 
			
			aStep check
				label: 'Check two elements in space';
				value: [ :aRootElement | aRootElement children size ]
				equals: 2;
				onSpaceRoot;
			play.

			aStep check
				label: 'Check notification badge existence';
				value: [ :aRootElement | (aRootElement childAt: 2) class ]
				equals: GtNotificationsBadgeElement;
				onSpaceRoot;
			play.
								
			aStep check
				label: 'Check notification badge label';
				satisfies: [ :aBadgeElement |
					aBadgeElement badgeElement text asString = '1' ];
				onSpaceRoot;
				onChildAt: 2;
			play ].
	
	^ aScripter
]

{ #category : #'examples - object message' }
GtNotificationBadgeByScripterExamples >> objectNotificationInSpaceWithAutomaticShow [
	<gtExample>
	| aScripter |
	aScripter := self scripter.
	aScripter set 
		label: 'Initialize Space Content';
		element: [ BlElement new ].
	
	aScripter space showNotification: (GtNotificationObjectMessageExamples new 
		notificationEvent) 
			showNotifications.
	
	aScripter play.
	
	aScripter 
		substep: 'Show notification'
		do: [ :aStep | 
			
			aStep check
				label: 'Check three elements in space';
				value: [ :aRootElement | aRootElement children size ]
				equals: 3;
				onSpaceRoot;
			play.

			aStep check
				label: 'Check notification badge existence';
				value: [ :aRootElement | (aRootElement childAt: 2) class ]
				equals: GtNotificationsBadgeElement;
				onSpaceRoot;
			play.
								
			aStep check
				label: 'Check notification badge label';
				satisfies: [ :aBadgeElement |
					aBadgeElement badgeElement text asString = '1' ];
				onSpaceRoot;
				onChildAt: 2;
			play ].
	
	aScripter 
		substep: 'Check badge shown' 
		do: [ :aStep |
			aStep check
				label: 'Check anchored badge list';
				satisfies: [ :aList | aList listElement items size = 1 ];
				onTarget: [ :theCheckStep |
					self dropdownListElementTarget: theCheckStep ];
			play.

			aStep check
				label: 'Check anchored badge label';
				satisfies: [ :aBadge | 
					(aBadge isKindOf: BrLabel) and: [
						aBadge text asString = '1' ] ];
				onTarget: [ :theCheckStep |
					self dropdownBadgeElementTarget: theCheckStep ];
			play.
				
			aStep check
				label: 'Check element type';
				onSpaceRoot;
				// GtObjectNotificationMessageElement;
				satisfies: [ :aNotificationElement | 
					aNotificationElement notification message = 'An object to inspect' ];
			play].
	
	^ aScripter
]

{ #category : #'examples - coder' }
GtNotificationBadgeByScripterExamples >> pharoSnippetCoder [
	<gtExample>
	| aCoder |
	aCoder := GtPharoSnippetCoder new.
	^ aCoder
]

{ #category : #'examples - inform message' }
GtNotificationBadgeByScripterExamples >> snippetWithInformCode [
	<gtExample>
	| aCoder |
	aCoder := self pharoSnippetCoder.
	aCoder forSource: self informCode.
	^ aCoder
]
