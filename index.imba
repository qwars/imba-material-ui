
import './index.styl'

export tag Widget < section
	prop settings default: {}

	@classes = ['carousel-layer']

	def createNewElement
		trigger 'oncreate'

	def deleteElement idx
		trigger 'ondelete', data.splice idx

	def prevLayer e
		console.log e

	def nextLayer e
		console.log e

	def render
		<self>
			<span :tap.prevLayer> if @settings:arrow
			<ul>
				for item, idx in data  when !!item
					<li>
						<del :tap.deleteElement(idx)> if @settings:control
						item
				<li> <abbr.create :tap.createNewElement> if @settings:control
			if @settings:control or @settings:dots then <ul .dots=@settings:dots .control=@settings:control> for item in data when !!item
				<li> item
			<span :tap.nextLayer> if @settings:arrow
