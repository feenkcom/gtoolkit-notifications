Class {
	#name : #GtNotificationJobByScripterExamples,
	#superclass : #GtNotificationByScripterExamples,
	#category : #'GToolkit-Notifications-Examples'
}

{ #category : #examples }
GtNotificationJobByScripterExamples >> compilingRenameInstanceVariableNotification [
	<gtExample>
	<return: #BlScripter>
	"The job's block is never run here (mirroring the reported snippet), so the
	notification is inspected in its just-constructed, not-yet-started state."
	| job notification aScripter |
	job := (GtJob
		block: [ :aJob | 
			| total |
			aJob label: 'Compiling Rename instance variable entity1 to entity2'.
			total := 10.
			aJob max: total.
			1
				to: total
				do: [ :i | 
					aJob currentValue: i.
					(Delay forMilliseconds: 300) wait ] ])
		announcer: Announcer new;
		yourself.

	notification := GtNotificationJob new
		summaryClass: GtCompilationNotificationSummary;
		job: job.

	aScripter := self scripter.
	aScripter
		model: notification;
		element: notification asElement.

	self assert: aScripter element class equals: GtNotificationRootJobElement.
	self assert: notification job equals: job.

	^ aScripter
]
