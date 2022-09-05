
import './index.styl'

const PreloadFileData = do|file| Promise.new do|resolve|
	let reader = FileReader.new
	reader:onload = do |e| resolve e:target:result
	reader.readAsDataURL file

const PreloadFiles =  do|files| Promise.new do|resolve|
	resolve( await Promise.all Array.from files, do|f| PreloadFileData f )

export tag Widget < section
	prop settings default: {}

	@classes = ['carousel-layer']

	def setup
		@preloadCSS = document:styleSheets[0]:cssRules[ document:styleSheets[0].insertRule '.carousel-layer dialog label.preload:before { margin-right: 0% }' ]

	def createNewElement
		unless @settings:ratio then trigger 'oncreate'
		elif @image then closeDialog trigger 'oncreate', @image
		else @open-dialog = true

	def closeDialog
		unless @open-dialog = false then @image = ''

	def preloadImage e
		if e.target.dom:files:length then @preload = not not PreloadFiles( e.target.dom:files )
			.then( do|result| @image = result )
			.finally do render e.target.value = @preload = ''

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
				for item, idx in data when !!item
					<li css:backgroundImage="url({item})">
						<del :tap.deleteElement(idx)> if @settings:control
				if @settings:control then <li>
					<abbr.create :tap.createNewElement> @settings:icon
					<input@file type="file"> unless @settings:ratio
			if @settings:control or @settings:dots then <ul .dots=@settings:dots .control=@settings:control> for item in data when !!item
				<li>
			<span :tap.nextLayer> if @settings:arrow
			if @settings:ratio then <dialog open=@open-dialog>
				<label .preload=@preload>
					<input type="file" accept="image/*" :change.preloadImage>
					<img src="{ @image or '' }" css:aspect-ratio=@settings:ratio>
				<div>
					<button.cancel :tap.closeDialog> "Cancel"
					<button .active=!!@image :tap.createNewElement> "Upload"
