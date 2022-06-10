import './index.styl'

const firebaseFn = require "firebase/firestore"

export tag Widget

	prop current default: 0
	prop limit default: 25
	prop waiting default: true
	prop collection
	prop response

	@classes = ['pagination-firebase']

	def setData v
		unsubscribe v unless @collection and @collection:_query:path.toString === v:_query:path.toString and @collection:_location === window:location:href
		self

	def setCollection v
		unsubscribe v unless @collection and @collection:_query:path.toString === v:_query:path.toString and @collection:_location === window:location:href
		self

	def explicitOrderBy datastate
		let orders = for item in datastate
			firebaseFn.query
				firebaseFn.collection @collection:firestore, @collection:_query:path.toString
				firebaseFn.orderBy item[0], item[1]
		@collection:_query:explicitOrderBy = orders.map do $1:_query:explicitOrderBy[0]
		@collection:_query:startAt = @collection:_query:endAt = null
		@current = 0
		unsubscribe @collection

	def filters datastate
		let filters = for item in datastate
			firebaseFn.query
				firebaseFn.collection @collection:firestore, @collection:_query:path.toString
				firebaseFn.where item[0], item[1], item[2]
		@collection:_query:filters = filters.map do $1:_query:filters[0]
		@collection:_query:startAt = @collection:_query:endAt = null
		@current = 0
		unsubscribe @collection

	def unsubscribe v
		@response = @unsubscribe and @unsubscribe()
		v:_query:limit = limit + 1
		@waiting = not not trigger 'subscribe', @unsubscribe = firebaseFn.onSnapshot
			@collection = Object.defineProperty v, '_location',
				value: window:location:href
			do
				@prevElementDoc = @nextElementDoc if @current
				@nextElementDoc = $1:docs[ $1:query:_query:limit - 1 ]
				Imba.commit @waiting = not @response = $1:docs.slice 0, $1:query:_query:limit - 1

	def current
		@current + 1

	def nexPage
		@current += 1

	def prevPage
		@current -= 1

	def render
		<self>
			unless @response then <.loading>
			elif @response:length == 0 then <.empty-state>
			else
				<span .active=!!@current :tap.prevPage>
				<span> "Page: { current }"
				<span .active=!!@nextElementDoc :tap.nexPage>