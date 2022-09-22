
import './index.styl'

const PreloadFileData = do|file| Promise.new do|resolve|
	let reader = FileReader.new
	reader:onload = do |e| resolve e:target:result
	reader.readAsDataURL file

const PreloadFiles =  do|files| Promise.new do|resolve|
	resolve( await Promise.all Array.from files, do|f| PreloadFileData f )

export tag Widget < section
	prop settings default: {}
	prop current default: 0

	@classes = ['carousel-layer']

	def setup
		@preloadCSS = document:styleSheets[0]:cssRules[ document:styleSheets[0].insertRule '.carousel-layer dialog label.preload:before { margin-right: 0% }' ]

	def createNewElement
		if @settings:ratio and not @image then @open-dialog = true
		else closeDialog @settings:upload @image

	def closeDialog
		unless @open-dialog = false then @image = ''

	def preloadImage e
		if e.target.dom:files:length then @preload = not not PreloadFiles( e.target.dom:files )
			.then( do|result| @image = result )
			.finally do render e.target.value = @preload = ''

	def deleteElement idx
		@settings:remove data.splice idx, 1

	def prevLayer e
		scrollIdx @current - 1

	def nextLayer
		scrollIdx @current + 1

	def scrollIdx idx
		@current = idx
		@scrollLayer.dom.scroll
			left: @scrollLayer.dom:offsetWidth * @current
			behavior:'smooth'

	def render
		<self>
			<span :tap.prevLayer .active=@current> if @settings:control
			<ul@scrollLayer .loading=!data>
				for item, idx in data when !!item
					<li css:backgroundImage="url({item})">
						<del :tap.silence.deleteElement(idx)> if @settings:remove
				if @settings:upload and data isa Array then <li>
					<abbr.create :tap.createNewElement> @settings:icon
					<input@file type="file" :change.preloadImage> unless @settings:ratio
			if @settings:dots then <ul .dots=@settings:dots > for item, idx in data when !!item
				<li .active=( @current === idx ) :tap.scrollIdx( idx )>
			<span :tap.nextLayer .active=( data and data:length > 0 and @current !== data:length - Number !@settings:upload )> if @settings:control
			if @settings:ratio and @settings:upload then <dialog open=@open-dialog>
				<label .preload=@preload>
					<input type="file" accept="image/*" :change.preloadImage>
					<img src="{ @image or '' }" css:aspect-ratio=@settings:ratio>
				<div>
					<button.cancel :tap.closeDialog> "Cancel"
					<button .active=!!@image :tap.createNewElement> "Upload"
