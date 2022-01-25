import './index.styl'

tag Registration

	def toggleView
		@view = !@view

	def isDisabled
		not @password.dom.checkValidity or not @email.dom.checkValidity

	def render
		<self.widget-page>
			<section>

				<h2>
					"Register new account"
					<dfn>
						<span> "Already have an account?"
						<a :tap.changeAction( null )> "Sign in"
				<label> <input@email type="email" required=true placeholder="E-mail">
				<label>
					<input@password type=( @view ? 'text' : 'password')
						required=true
						pattern='(?=^.{8,}$)((?=.*\\d)|(?=.*\\W+))(?![.\\n])(?=.*[A-Z])(?=.*[a-z]).*$'
						placeholder="Password"
						autocomplete='new-password'>
					<i :click.toggleView>
				<em> "Too easy. At least 8 characters, numbers, upper and lower case letters (lat)" if @password.value and @password.dom:validity:patternMismatch
				<button.active disabled=isDisabled> "Create account"

tag Restore
	def isDisabled
		not @email.dom.checkValidity

	def render
		<self>
			<section>
				<h2> "Reset password"
					<dfn>
						<span> "Recall your password?"
						<a :tap.changeAction( null )> "Sign in"
				<em>
					"Enter your e-mail address and "
					<wbr>
					"we will send you a link "
					<wbr>
					"to reset your password:"
				<label> <input@email type="email" required=true placeholder="E-mail" >
				<button.active disabled=isDisabled> "Reset password"

tag Enter
	def toogleView
		flag 'view', !flags.contains 'view'

	def isDisabled
		not @password.dom.checkValidity or not @email.dom.checkValidity

	def render
		<self>
			<section>
				<h2>
					"Sign in"
					<dfn>
						<span> "No account?"
						<a :tap.changeAction( 'registration' )> "Register"
				<label>
					<input@email type="email" placeholder="E-mail" required=true >
				<label>
					<input@password type=( flags.contains( 'view' ) ? 'password' : 'text')
						placeholder="Password" required=true autocomplete='new-password'>
					<i :tap.toogleView>
				<button.active disabled=isDisabled :tap.changeAction( null )> "Enter"
			<p>
				"Lost your password? "
				<a :tap.changeAction( 'restore' )> 'Reset password'

tag Message
	def render
		<self.widget-page>
			<section>
				<h2> "The confirmation"
				<em> "To the mail you specified, "
					<q> data:email
					<span> " sent a letter with instructions to confirm registration."
				<button.active :tap.changeAction( null )> "Send again"

export tag Widget < form

	def empty
		Array.from dom, do $1.value = ''

	def submitAuthentication
		unless Array.from( dom ).filter( do not $1.checkValidity ):length === 0 then self
		elif @action === 'restore' then data.restorePassword @restore.@email.value
		elif @action === 'registration' then data.signRegistration @registration.@email.value, @registration.@password.value
		elif data.profile then data.emailVerified
		else data.signIn @enter.@email.value, @enter.@password.value

	def changeAction state
		@action = state

	def render
		<self.authentication :submit.prevent.submitAuthentication>
			if data.profile then  <Message[ data.profile ]>
			elif @action === 'restore' then <Restore@restore :keydown.enter.prevent>
			elif @action === 'registration' then <Registration@registration :keydown.enter.prevent>
			else <Enter@enter :keydown.enter.prevent>