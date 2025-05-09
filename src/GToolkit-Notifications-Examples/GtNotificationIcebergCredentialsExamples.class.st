"
I exemplify {{gtClass:GtNotificationIcebergCredentialsProvider}}, {{gtClass:GtNotificationIcebergCredentialsElement}}, and {{gtClass:GtNotificationIcebergCredentials}}.

"
Class {
	#name : #GtNotificationIcebergCredentialsExamples,
	#superclass : #Object,
	#instVars : [
		'files'
	],
	#category : #'GToolkit-Notifications-Examples'
}

{ #category : #'examples - plain text element' }
GtNotificationIcebergCredentialsExamples >> acceptEditedPlaintextCredentialsElement [
	<gtExample>
	<return: #GtNotificationIcebergPlaintextCredentialsElement>
	| anElement aStore anExistingSize |
	anElement := self plaintextCredentialsElementWithUsernameAndPassword.
	aStore := anElement notification credentialStore.
	anExistingSize := aStore allCredentials size.
	anElement usernameInputElement text: 'another username'.
	anElement passwordInputElement text: 'another password'.
	anElement accept.
	self assert: aStore allCredentials size equals: anExistingSize + 1.
	self
		assert: anElement notification credentials username
		equals: 'another username'.
	self
		assert: anElement notification credentials password
		equals: 'another password'.
	^ anElement
]

{ #category : #'examples - plain text element' }
GtNotificationIcebergCredentialsExamples >> acceptPlaintextCredentialsElement [
	<gtExample>
	<return: #GtNotificationIcebergPlaintextCredentialsElement>
	| anElement aStore anExistingSize |
	anElement := self plaintextCredentialsElementWithUsernameAndPassword.
	aStore := anElement notification credentialStore.
	anExistingSize := aStore allCredentials size.
	anElement accept.
	self assert: aStore allCredentials size equals: anExistingSize + 1.
	^ anElement
]

{ #category : #'private - support' }
GtNotificationIcebergCredentialsExamples >> addFile: aFile [
	self files add: aFile
]

{ #category : #'examples - credential store' }
GtNotificationIcebergCredentialsExamples >> basicCredentialStore [
	<gtExample>
	<return: #IceCredentialStore>
	| aStore |
	aStore := IceCredentialStore new.
	self assert: (aStore instVarNamed: #storeFile) isNil.
	^ aStore
]

{ #category : #'examples - plain text credentials' }
GtNotificationIcebergCredentialsExamples >> basicPlaintextCredentials [
	<gtExample>
	<return: #IcePlaintextCredentials>
	| aCredentials |
	aCredentials := IcePlaintextCredentials new.
	^ aCredentials
]

{ #category : #'examples - plain text element' }
GtNotificationIcebergCredentialsExamples >> basicPlaintextCredentialsElement [
	<gtExample>
	<return: #GtNotificationIcebergPlaintextCredentialsElement>
	| anElement |
	anElement := GtNotificationIcebergPlaintextCredentialsElement new.
	self assert: anElement notification isNil.
	^ anElement
]

{ #category : #'examples - plain text notification' }
GtNotificationIcebergCredentialsExamples >> basicPlaintextCredentialsNotification [
	<gtExample>
	<return: #GtNotificationIcebergPlaintextCredentials>
	| aNotification |
	aNotification := GtNotificationIcebergPlaintextCredentials new.
	self assert: aNotification credentials isNotNil.
	self assert: aNotification credentialStore isNil.
	^ aNotification
]

{ #category : #'examples - provider' }
GtNotificationIcebergCredentialsExamples >> basicProvider [
	<gtExample>
	<return: #GtNotificationIcebergCredentialsProvider>
	| aProvider |
	aProvider := GtNotificationIcebergCredentialsProvider new.
	self assert: (aProvider instVarNamed: #remote) isNil.
	^ aProvider
]

{ #category : #'examples - ssh credentials' }
GtNotificationIcebergCredentialsExamples >> basicSshCredentials [
	<gtExample>
	<return: #IceSshCredentials>
	| aCredentials |
	aCredentials := IceSshCredentials new.
	^ aCredentials
]

{ #category : #'examples - ssh element' }
GtNotificationIcebergCredentialsExamples >> basicSshCredentialsElement [
	<gtExample>
	<return: #GtNotificationIcebergSshCredentialsElement>
	| anElement |
	anElement := GtNotificationIcebergSshCredentialsElement new.
	self assert: anElement notification isNil.
	^ anElement
]

{ #category : #'examples - ssh notification' }
GtNotificationIcebergCredentialsExamples >> basicSshCredentialsNotification [
	<gtExample>
	<return: #GtNotificationIcebergSshCredentials>
	| aNotification |
	aNotification := GtNotificationIcebergSshCredentials new.
	self assert: aNotification credentials isNotNil.
	self assert: aNotification credentialStore isNil.
	^ aNotification
]

{ #category : #'examples - plain text element' }
GtNotificationIcebergCredentialsExamples >> cancelEditedPlaintextCredentialsElement [
	<gtExample>
	<return: #GtNotificationIcebergPlaintextCredentialsElement>
	| anElement aStore anExistingSize |
	anElement := self plaintextCredentialsElementWithUsernameAndPassword.
	aStore := anElement notification credentialStore.
	anExistingSize := aStore allCredentials size.
	anElement usernameInputElement text: 'another username'.
	anElement passwordInputElement text: 'another password'.
	anElement cancel.
	self assert: aStore allCredentials size equals: anExistingSize.
	self assert: anElement notification credentials username equals: self username.
	self assert: anElement notification credentials password equals: self password.
	^ anElement
]

{ #category : #'examples - credential store' }
GtNotificationIcebergCredentialsExamples >> credentialStore [
	<gtExample>
	<return: #IceCredentialStore>
	| aStore aFile |
	aStore := self basicCredentialStore.
	aFile := self credentialStoreFile.
	aStore storeFile: aFile.
	self assert: (aStore instVarNamed: #storeFile) equals: aFile.
	^ aStore
]

{ #category : #'examples - credential store' }
GtNotificationIcebergCredentialsExamples >> credentialStoreFile [
	<gtExample>
	<after: #deleteFiles>
	<return: #FileReference>
	| aFile |
	aFile := FileReference newTempFilePrefix: 'credentials.' suffix: '.fuel'.
	self addFile: aFile.
	self assert: aFile exists not.
	^ aFile
]

{ #category : #'examples - ssh credentials' }
GtNotificationIcebergCredentialsExamples >> defaultSshCredentials [
	<gtExample>
	<return: #IceSshCredentials>
	| aStore |
	aStore := self credentialStore.
	^ aStore defaultSSHCredential
]

{ #category : #'private - support' }
GtNotificationIcebergCredentialsExamples >> deleteFiles [
	files ifNotNil: [ :theFiles | 
		theFiles do: [ :eachFile | 
			eachFile ensureDelete ] ]
]

{ #category : #'private - support' }
GtNotificationIcebergCredentialsExamples >> files [
	^ files ifNil: [ files := OrderedCollection new ]
]

{ #category : #'examples - plain text credentials' }
GtNotificationIcebergCredentialsExamples >> host [
	^ 'github'
]

{ #category : #'examples - ssh credentials' }
GtNotificationIcebergCredentialsExamples >> keyPassphrase [
	<gtExample>
	<return: #ByteString>
	^ 'pass phrase'
]

{ #category : #'examples - plain text credentials' }
GtNotificationIcebergCredentialsExamples >> password [
	<gtExample>
	<return: #ByteString>
	^ 'mypassword'
]

{ #category : #'examples - plain text credentials' }
GtNotificationIcebergCredentialsExamples >> plaintextCredentials [
	<gtExample>
	<return: #IcePlaintextCredentials>
	| aCredentials |
	aCredentials := self basicPlaintextCredentials.
	aCredentials host: self host.
	self assert: aCredentials host equals: self host.
	^ aCredentials
]

{ #category : #'examples - plain text element' }
GtNotificationIcebergCredentialsExamples >> plaintextCredentialsElement [
	<gtExample>
	<return: #GtNotificationIcebergPlaintextCredentialsElement>
	| anElement aNotification |
	anElement := GtNotificationIcebergPlaintextCredentialsElement new.
	aNotification := self plaintextCredentialsNotification.
	anElement notification: aNotification.
	self assert: anElement notification equals: aNotification.
	self
		assert: (anElement headerElement text asString endsWith: aNotification credentials host).
	self
		assert: anElement usernameInputElement text asString
		equals: aNotification credentials username.
	self
		assert: anElement passwordInputElement text asString
		equals: aNotification credentials password.
	^ anElement
]

{ #category : #'examples - plain text element' }
GtNotificationIcebergCredentialsExamples >> plaintextCredentialsElementWithUsernameAndPassword [
	<gtExample>
	<return: #GtNotificationIcebergPlaintextCredentialsElement>
	| anElement aNotification |
	anElement := self basicPlaintextCredentialsElement.
	aNotification := self plaintextCredentialsNotificationWithUsernameAndPassword.
	anElement notification: aNotification.
	self assert: anElement notification equals: aNotification.
	self
		assert: (anElement headerElement text asString endsWith: aNotification credentials host).
	self
		assert: anElement usernameInputElement text asString
		equals: aNotification credentials username.
	self
		assert: anElement passwordInputElement text asString
		equals: aNotification credentials password.
	^ anElement
]

{ #category : #'examples - plain text notification' }
GtNotificationIcebergCredentialsExamples >> plaintextCredentialsNotification [
	<gtExample>
	<return: #GtNotificationIcebergPlaintextCredentials>
	| aNotification aCredentials aStore |
	aNotification := self basicPlaintextCredentialsNotification.
	aCredentials := self plaintextCredentials.
	aStore := self credentialStore.
	aNotification credentials: aCredentials.
	aNotification credentialStore: aStore.
	self assert: aNotification credentials equals: aCredentials.
	self assert: aNotification credentialStore equals: aStore.
	^ aNotification
]

{ #category : #'examples - plain text notification' }
GtNotificationIcebergCredentialsExamples >> plaintextCredentialsNotificationWithUsernameAndPassword [
	<gtExample>
	<return: #GtNotificationIcebergPlaintextCredentials>
	| aNotification aCredentials |
	aNotification := self plaintextCredentialsNotification.
	aCredentials := self plaintextCredentialsWithUsernameAndPassword.
	aNotification credentials: aCredentials.
	self assert: aNotification credentials equals: aCredentials.
	^ aNotification
]

{ #category : #'examples - plain text credentials' }
GtNotificationIcebergCredentialsExamples >> plaintextCredentialsWithUsernameAndPassword [
	<gtExample>
	<return: #IcePlaintextCredentials>
	| aCredentials |
	aCredentials := self plaintextCredentials.
	aCredentials username: self username.
	aCredentials password: self password.
	self assert: aCredentials username equals: self username.
	self assert: aCredentials password equals: self password.
	^ aCredentials
]

{ #category : #'examples - ssh credentials' }
GtNotificationIcebergCredentialsExamples >> privateKey [
	<gtExample>
	<return: #ByteString>
	^ '/keys/my_private_key'
]

{ #category : #'examples - provider' }
GtNotificationIcebergCredentialsExamples >> provider [
	<gtExample>
	<return: #GtNotificationIcebergCredentialsProvider>
	| aProvider aRemote |
	aProvider := self basicProvider.
	aRemote := IceRemoteWithOnlyHostname for: 'example.com'.
	aProvider remote: aRemote.
	self assert: (aProvider instVarNamed: #remote) equals: aRemote.
	^ aProvider
]

{ #category : #'examples - ssh credentials' }
GtNotificationIcebergCredentialsExamples >> publicKey [
	<gtExample>
	<return: #ByteString>
	^ '/keys/my_public_key.pub'
]

{ #category : #'examples - ssh credentials' }
GtNotificationIcebergCredentialsExamples >> sshCredentials [
	<gtExample>
	<return: #IceSshCredentials>
	| aCredentials |
	aCredentials := self basicSshCredentials.
	aCredentials host: self host.
	self assert: aCredentials host equals: self host.
	^ aCredentials
]

{ #category : #'examples - ssh element' }
GtNotificationIcebergCredentialsExamples >> sshCredentialsElement [
	<gtExample>
	<return: #GtNotificationIcebergSshCredentialsElement>
	| anElement aNotification |
	anElement := GtNotificationIcebergSshCredentialsElement new.
	aNotification := self sshCredentialsNotification.
	anElement notification: aNotification.
	self assert: anElement notification equals: aNotification.
	self
		assert: (anElement headerElement text asString endsWith: aNotification credentials host).
	self
		assert: anElement usernameInputElement text asString
		equals: aNotification credentials username.
	self
		assert: anElement publicKeyInputElement text asString
		equals: aNotification credentials publicKey.
	self
		assert: anElement privateKeyInputElement text asString
		equals: aNotification credentials privateKey.
	self
		assert: anElement keyPassphraseInputElement text asString
		equals: aNotification credentials keyPassphrase.
	^ anElement
]

{ #category : #'examples - ssh element' }
GtNotificationIcebergCredentialsExamples >> sshCredentialsElementWithKeys [
	<gtExample>
	<return: #GtNotificationIcebergSshCredentialsElement>
	| anElement aNotification |
	anElement := GtNotificationIcebergSshCredentialsElement new.
	aNotification := self sshCredentialsNotificationWithKeys.
	anElement notification: aNotification.
	self assert: anElement notification equals: aNotification.
	self
		assert: (anElement headerElement text asString endsWith: aNotification credentials host).
	self
		assert: anElement usernameInputElement text asString
		equals: aNotification credentials username.
	self
		assert: anElement publicKeyInputElement text asString
		equals: aNotification credentials publicKey.
	self
		assert: anElement privateKeyInputElement text asString
		equals: aNotification credentials privateKey.
	self
		assert: anElement keyPassphraseInputElement text asString
		equals: aNotification credentials keyPassphrase.
	^ anElement
]

{ #category : #'examples - ssh notification' }
GtNotificationIcebergCredentialsExamples >> sshCredentialsNotification [
	<gtExample>
	<return: #GtNotificationIcebergSshCredentials>
	| aNotification aCredentials aStore |
	aNotification := self basicSshCredentialsNotification.
	aCredentials := self sshCredentials.
	aStore := self credentialStore.
	aNotification credentials: aCredentials.
	aNotification credentialStore: aStore.
	self assert: aNotification credentials equals: aCredentials.
	self assert: aNotification credentialStore equals: aStore.
	^ aNotification
]

{ #category : #'examples - ssh notification' }
GtNotificationIcebergCredentialsExamples >> sshCredentialsNotificationWithKeys [
	<gtExample>
	<return: #GtNotificationIcebergSshCredentials>
	| aNotification aCredentials aStore |
	aNotification := self basicSshCredentialsNotification.
	aCredentials := self sshCredentialsWithKeys.
	aStore := self credentialStore.
	aNotification credentials: aCredentials.
	aNotification credentialStore: aStore.
	self assert: aNotification credentials equals: aCredentials.
	self assert: aNotification credentialStore equals: aStore.
	^ aNotification
]

{ #category : #'examples - ssh credentials' }
GtNotificationIcebergCredentialsExamples >> sshCredentialsWithKeys [
	<gtExample>
	<return: #IceSshCredentials>
	| aCredentials |
	aCredentials := self sshCredentials.
	aCredentials username: self username.
	aCredentials publicKey: self publicKey.
	aCredentials privateKey: self privateKey.
	aCredentials keyPassphrase: self keyPassphrase.

	self assert: aCredentials username equals: self username.
	self assert: aCredentials publicKey equals: self publicKey.
	self assert: aCredentials privateKey equals: self privateKey.
	self assert: aCredentials keyPassphrase equals: self keyPassphrase.
	^ aCredentials
]

{ #category : #'examples - plain text credentials' }
GtNotificationIcebergCredentialsExamples >> username [
	<gtExample>
	<return: #ByteString>
	^ 'user'
]
