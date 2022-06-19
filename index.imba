
import './index.styl'

import { colord } from "colord";
import Widget as ColorsHue from './colors-hue'

const ISymbol = require './symbol.svg'

export tag DefsGradients < svg:svg

	def build
		document:body.addEventListener 'mouseup', do for item in Imba.root.querySelectorAll '.color-choice'
			item.flagIf 'color-choice', false
		document:body.addEventListener 'touchend', do for item in Imba.root.querySelectorAll '.color-choice'
			item.flagIf 'color-choice', false

	def setup
		document:styleSheets[0].insertRule "#L-{id} .ColorSaturationValue rect:first-child \{ fill: url(#ColorHueGradient-{ id }) \}"
		document:styleSheets[0].insertRule "#L-{id} .ColorSaturationValue rect + rect \{ fill: url(#ColorHueBlack-{ id }) \}"
		document:styleSheets[0].insertRule "#L-{id} .ColorAlpha rect \{ fill: url(#ColorHueGradientAlphaY-{ id }) \}"
		document:styleSheets[0].insertRule "#L-{id} .ColorGrayAlpha rect \{ fill: url(#ColorHueGradientAlphaX-{ id }) \}"

	def colordHue
		colord
			h: Number( !!data and data.hue )
			s: 100
			v: 100
			a: 1

	def render
		<self>
			<svg:defs>
				<svg:linearGradient id="ColorHueBlack-{ id }" x1=0 x2=0 y1=0 y2=1>
					<svg:stop stop-color='black' stop-opacity=0 offset="0%">
					<svg:stop stop-color='black' stop-opacity=1 offset="100%">
				<svg:linearGradient id="ColorHueGradient-{  id }">
					<svg:stop stop-color="{ colordHue.toRgbString }" stop-opacity=0 offset="0%">
					<svg:stop stop-color="{ colordHue.toRgbString }" stop-opacity=1 offset="100%">
				<svg:linearGradient id="ColorHueGradientAlphaX-{  id }">
					<svg:stop stop-color="{ data.alpha(1).toRgbString }" stop-opacity=1 offset="0%">
					<svg:stop stop-color="{ data.alpha(1).toRgbString }" stop-opacity=0 offset="100%">
				<svg:linearGradient id="ColorHueGradientAlphaY-{ id }" x1=0 x2=0 y1=0 y2=1>
					<svg:stop stop-color="{ data.alpha(1).toRgbString }" stop-opacity=0 offset="0%">
					<svg:stop stop-color="{ data.alpha(1).toRgbString }" stop-opacity=1 offset="100%">

tag Circle < svg:circle
	def setup
		dom.addEventListener 'touchstart', do parent.flagIf 'color-choice', true
		dom.addEventListener 'mousedown', do parent.flagIf 'color-choice', true

tag ColorSaturationValue < svg:svg

	def setup
		dom.addEventListener 'touchmove', self:moveChoiceColor.bind self
		dom.addEventListener 'mousemove', self:moveChoiceColor.bind self

	def moveChoiceColor e
		choiceColor e if flags.contains 'color-choice'

	def choiceColor e
		let bounding = dom.getBoundingClientRect
		let x = e:x - bounding:x;
		if e:x < bounding:left then x = 0
		elif e:x > bounding:right then x = bounding:width
		let y = e:y - bounding:y;
		if e:y < bounding:top then y = 0
		elif e:y > bounding:bottom then y = bounding:height
		@circle.dom.setAttribute 'cx', x
		@circle.dom.setAttribute 'cy', y
		@circle.dom:cx:baseVal.convertToSpecifiedUnits 2
		@circle.dom:cy:baseVal.convertToSpecifiedUnits 2
		data:s = Math.round @circle.dom:cx:baseVal:valueInSpecifiedUnits
		data:v = Math.round 100 - @circle.dom:cy:baseVal:valueInSpecifiedUnits
		trigger 'input', data

	def tapChoiceColor e
		choiceColor { x: e.x, y: e.y }

	def render
		<self :tap.tapChoiceColor >
			<svg:rect>
			<svg:rect>
			<Circle@circle css:cx="{ data:s }%" css:cy="{ 100 - data:v }%">

tag ColorAlpha < svg:svg
	def setup
		dom.addEventListener 'touchmove', self:moveChoiceColor.bind self
		dom.addEventListener 'mousemove', self:moveChoiceColor.bind self

	def moveChoiceColor e
		choiceColor e if flags.contains 'color-choice'

	def choiceColor e
		let bounding = dom.getBoundingClientRect
		let y = e:y - bounding:y;
		if e:y < bounding:top then y = 0
		elif e:y > bounding:bottom then y = bounding:height
		@circle.dom.setAttribute 'cy', y
		@circle.dom:cy:baseVal.convertToSpecifiedUnits 2
		data:a = Math.round @circle.dom:cy:baseVal:valueInSpecifiedUnits
		trigger 'input', data

	def tapChoiceColor e
		choiceColor { x: e.x, y: e.y }

	def render
		<self :tap.tapChoiceColor>
			<svg:rect>
			<Circle@circle css:cy="{ data:a }%">

tag ColorInputs < section

	def render
		<self>
			<u>
				"HSV"
			<label>
				<i> "H"
				<input[ data:h ] type="number" step=1 min=0 max=360 disabled=!parent.liveHue>
				<u html='°&nbsp;'>
			<label>
				<i> "S"
				<input[ data:s ] type="number" step=1 min=0 max=100>
				<u> "%"
			<label>
				<i> "V"
				<input[ data:v ] type="number" step=1 min=0 max=100>
				<u> "%"
			<label>
				<i> "A"
				<input[ data:a ] type="number" step=1 min=0 max=100>
				<u> "%"

export tag ColorEditor < section
	prop live-hue

	def setData v
		unless querySelector 'input:focus'
			@current = v.toHsv
			@current:a *= 100
		self

	def value
		@current

	def changeColor
		@current:h = Number @current:h
		@current:s = Number @current:s
		@current:v = Number @current:v
		@current:a = Number @current:a
		trigger 'input', Object.assign( {}, @current, { a: @current:a / 100 } )
		render

	def render
		<self>
			<section> <ColorSaturationValue[@current] :input.stop.silence.changeColor>
			<section.chess> <ColorAlpha[@current] :input.stop.silence.changeColor>
			<ColorInputs[@current] :input.stop.silence.changeColor>

tag ColorGray < svg:svg
	def setup
		dom.addEventListener 'touchmove', self:moveChoiceColor.bind self
		dom.addEventListener 'mousemove', self:moveChoiceColor.bind self

	def moveChoiceColor e
		choiceColor e if flags.contains 'color-choice'

	def choiceColor e
		let bounding = dom.getBoundingClientRect
		let x = e:x - bounding:x;
		if e:x < bounding:left then x = 0
		elif e:x > bounding:right then x = bounding:width
		@circle.dom.setAttribute 'cx', x
		@circle.dom:cx:baseVal.convertToSpecifiedUnits 2
		data:v = Math.round @circle.dom:cx:baseVal:valueInSpecifiedUnits
		trigger 'input', data

	def tapChoiceColor e
		choiceColor { x: e.x, y: e.y }

	def render
		<self :tap.tapChoiceColor>
			<Circle@circle css:cx="{ data:v }%">

tag ColorGrayAlpha < svg:svg

	def setup
		dom.addEventListener 'touchmove', self:moveChoiceColor.bind self
		dom.addEventListener 'mousemove', self:moveChoiceColor.bind self

	def moveChoiceColor e
		choiceColor e if flags.contains 'color-choice'

	def choiceColor e
		let bounding = dom.getBoundingClientRect
		let x = e:x - bounding:x;
		if e:x < bounding:left then x = 0
		elif e:x > bounding:right then x = bounding:width
		@circle.dom.setAttribute 'cx', x
		@circle.dom:cx:baseVal.convertToSpecifiedUnits 2
		data:a = 100 - Math.round @circle.dom:cx:baseVal:valueInSpecifiedUnits
		trigger 'input', data

	def tapChoiceColor e
		choiceColor { x: e.x, y: e.y }

	def render
		<self :tap.tapChoiceColor>
			<svg:rect>
			<Circle@circle css:cx="{ 100 - data:a }%">

tag ColorGrayEditor < section

	def setData v
		unless querySelector 'input:focus'
			@current = v.toHsv
			@current:a *= 100
		self

	def changeColor e
		trigger 'input', e.data or @current

	def render
		<self :input.silence.stop.prevent>
			<div> <ColorGray[@current] :input.changeColor>
			<label>
				<i> "G"
				<input[ @current:v ] type="number" step=1 min=0 max=100 :input.changeColor>
				<u> "%"
			<div.chess> <ColorGrayAlpha[@current] :input.changeColor>
			<label>
				<i> "A"
				<input[ @current:a ] type="number" step=1 min=0 max=100 :input.changeColor>
				<u> "%"

export tag Widget
	prop hue

	@classes = ['colors-collection']

	def setHue v
		if @isHue = v isa Array and v:length > 0 then @hue = for item in Array.from Set.new v.map( do|c| colord( c ).alpha(1).toRgbString )
			colord item
		self

	def setData v
		@data = [].concat( ['rgb( 0,0,0 )'].concat v ).map( do|item| colord item ) unless @data
		unless hue then @hue = for item in Array.from Set.new @data.map( do|c| "hsl({ c.hue }, 100%, 50%)" )
			colord item
		@current = @hue[0] unless @current
		self

	def addHueColor e
		@colorshue.dom:open = !@hue.push colord e.target.value

	def addColorCollection e
		unless e.target.parent.querySelector '.active'
			@data.push @current
			render trigger 'change', collection

	def changeColor e
		value = e.data if e.data

	def collection
		@data.map do|item| item.toRgbString

	def value
		@current and @current.toRgbString

	def value= v
		if v isa String then render @current = colord v
		else
			@current = colord {
				h: Number v:h
				s: Number v:s
				v: Number v:v
				a: v:a > 1 ? v:a / 100 :  v:a
			}
			@timeout = clearTimeout( @timeout ) or setTimeout( &, 167 ) do Imba.commit trigger 'input', @current

	def toggleGrayCollection
		@graycollection = !@graycollection
		@current = colord { h: 0, s: 100, v: 0, a: @current.toHsv:a }
		render

	def selectHueColor h
		@graycollection = !@current = colord { h: h, s: 100, v: 100, a: 1 }
		render

	def selecColor item
		@current = item
		render

	def deleteColor item
		@data.splice @data.indexOf( item ), 1 if @data.indexOf( item ) >= 0

	def deleteHueColor hc
		if let filtred = @data.filter( do|item| item.hue === hc.hue )
			@hue.splice @hue.indexOf( hc ), 1
			filtred.map do|item| deleteColor item

	def iD
		unless @iD
			@iD = Math.random.toString.replace /\D/g, ''
		@iD

	def render
		<self id="L-G-{ iD }">
			<DefsGradients[ @current ] id="G-{ iD }">
			<ul>
				for item, idx in @hue
					<li .active=( @current.hue == item.hue and not @graycollection )
						:tap.selectHueColor( item.toHsv:h )
						css:backgroundColor=item.toRgbString>
						if idx > 0 then <del :tap.stop.deleteHueColor( item )> <svg:svg> <svg:use href="{ ISymbol }#plus"> unless @isHue
				unless @isHue then <li> <details@colorshue.Plugin>
					<summary> <svg:svg> <svg:use href="{ ISymbol }#plus">
					<s> <ColorsHue[ @current.toRgbString ] :apply.addHueColor>
				<li css:flexGrow=1 css:border-color="transparent">
				<li :tap.toggleGrayCollection .active=@graycollection css:backgroundColor="gray">
			if @graycollection
				<ColorGrayEditor[ @current ] :input.stop.changeColor>
				<ul>
					<li :tap.addColorCollection> <svg:svg> <svg:use href="{ ISymbol }#plus">
					for item in data when item.toHsv:s == 0
						<li :tap.selecColor( item ) .active=( @current.toRgbString == item.toRgbString ) css:backgroundColor=item.toRgbString .is-alpha=(item.alpha < 1)>
							<del :tap.stop.deleteColor( item )> <svg:svg> <svg:use href="{ ISymbol }#plus">
			else
				<ColorEditor[ @current ] :input.stop.changeColor>
				<ul>
					<li :tap.addColorCollection> <svg:svg> <svg:use href="{ ISymbol }#plus">
					for item in data when item.hue == @current.hue and item.toHsv:s > 0
						<li :tap.selecColor( item ) .active=( @current.toRgbString == item.toRgbString ) css:backgroundColor=item.toRgbString .is-alpha=(item.alpha < 1)>
							<del :tap.stop.deleteColor( item )> <svg:svg> <svg:use href="{ ISymbol }#plus">
