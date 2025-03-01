Class {
	#name : #GtNotificationMessageElement,
	#superclass : #GtNotificationEventElement,
	#instVars : [
		'message',
		'textEditor',
		'borderElement'
	],
	#category : #'GToolkit-Notifications-Message'
}

{ #category : #'private - asserting' }
GtNotificationMessageElement >> assertMessage: aString [
	self 
		assert: [ aString isNotNil ] 
		description: [ 'Notification message must be non-nil' ].
]

{ #category : #'private - accessing' }
GtNotificationMessageElement >> borderElement [
	<return: #GtNotificationBorderElement>
	^ borderElement
]

{ #category : #initialization }
GtNotificationMessageElement >> defaultLayout [
	^ BlLinearLayout vertical alignCenterRight
]

{ #category : #defaults }
GtNotificationMessageElement >> defaultMessage [
	^ 'empty message'
]

{ #category : #initialization }
GtNotificationMessageElement >> initialize [
	super initialize.
	
	message := self defaultMessage.
	self initializeBorderElement.
	self initializeTextEditor.
	
	self addChild: self borderElement as: #border.
	self borderElement containerDo: [ :aContainer |
		aContainer addChild: self textEditor as: #textEditor ].
	
	self addAptitude: (BrLayoutResizerAptitude new
		hInherit;
		vAnyToFitContent;
		hInherit: self borderElement;
		vAnyToFitContent: self borderElement;
		hInherit: self textEditor;
		vAnyToFitContent: self textEditor).
]

{ #category : #initialization }
GtNotificationMessageElement >> initializeBorderElement [
	borderElement := GtNotificationBorderElement new
			withCloseButtonAction: [ self dismiss ].

	borderElement
		childWithId: #closeButton
		ifFound: [ :closeButton | 
			closeButton visibility: BlVisibility hidden.
			borderElement
				when: BlMouseLeaveEvent
					do: [ :e | closeButton visibility: BlVisibility hidden ];
				when: BlMouseEnterEvent
					do: [ :e | closeButton visibility: BlVisibility visible ] ]
		ifNone: [  ]
]

{ #category : #initialization }
GtNotificationMessageElement >> initializeTextEditor [
	textEditor := BrEditor new
		aptitude: BrGlamorousRegularEditorAptitude;
		hMatchParent;
		vFitContent;
		beReadOnlyWithSelection;
		text: self message.
]

{ #category : #'api - accessing' }
GtNotificationMessageElement >> message [
	<return: #String>
	^ message
]

{ #category : #'api - accessing' }
GtNotificationMessageElement >> message: aString [
	self assertMessage: aString.
	message = aString ifTrue: [ ^ self ].
	message := aString.
	self onMessageChanged.
]

{ #category : #'private - hooks' }
GtNotificationMessageElement >> onMessageChanged [
	self updateTextEditor.
]

{ #category : #'private - hooks' }
GtNotificationMessageElement >> onNotificationChanged [
	super onNotificationChanged.
	self message: self notification message
]

{ #category : #'private - accessing' }
GtNotificationMessageElement >> textEditor [
	<return: #BrEditor>
	^ textEditor
]

{ #category : #'private - updating' }
GtNotificationMessageElement >> updateTextEditor [
	self textEditor text: self message.
]
