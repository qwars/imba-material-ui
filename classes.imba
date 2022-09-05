
import getAuth, onAuthStateChanged, signOut, signInWithEmailAndPassword, createUserWithEmailAndPassword, sendEmailVerification, updateProfile from "firebase/auth"

export class Authentication
	prop waiting default: true
	prop message

	def profile
		@profile

	def profile= value
		@profile = value

	def signIn email, password
		signInWithEmailAndPassword( @auth, email, password )
			.catch( do |error| waiting = not @message = error )

	def signRegistration email, password, displayName
		signOut.then do createUserWithEmailAndPassword( @auth, email, password )
			.catch( do |error| waiting = not message = error  )
			.then do waiting = !!displayName and updateProfile @auth.currentUser, { displayName: displayName }

	def restorePassword email
		profile and sendPasswordResetEmail( @auth, email )
			.catch( do |error| waiting = not @message = error )

	def updateProfile dataset
		profile and updateProfile( @auth.currentUser, dataset )
			.catch( do |error| waiting = not @message = error )

	def emailVerified
		sendEmailVerification( @auth.currentUser )
			.catch( do |error| waiting = not @message = error )

	def signOut
		signOut( @auth )
			.catch( do |error| waiting = not @message = error )

	def initialize firebaseApp
		@auth = getAuth firebaseApp
		@waiting = !!onAuthStateChanged
			@auth,
			do profile = $1 and $1.toJSON
			do|err| console.log err,
