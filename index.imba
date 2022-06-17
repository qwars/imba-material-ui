
import './index.styl'

import colord  from "colord";

const WidgetIcons = require './icons-symbols.svg'

tag ColorHueSelect < svg:svg

	def mount
		dom:firstElementChild.setAttribute 'cy', '50%'
		dom:firstElementChild.setAttribute 'cx', "{ data / 3.6 }%"
		dom:firstElementChild.setAttribute 'fill', colord('rgb( 255, 0, 0 )').hue( data ).toRgbString

	def value
		colord('rgb( 255, 0, 0 )').hue( dom:firstElementChild:cx:baseVal:valueInSpecifiedUnits * 3.6 ).hue

	def setData value
		unless value === @data
			@data = value
			if dom:firstElementChild
				dom:firstElementChild.setAttribute 'cx', "{ data / 3.6 }%"
				dom:firstElementChild.setAttribute 'fill', colord('rgb( 255, 0, 0 )').hue( data ).toRgbString
		self

	def startMoveCircle
		flagIf 'color-choice', true

	def endMoveCircle e
		flagIf 'color-choice', false

	def moveChoiceColor e
		if flags.contains 'color-choice' then onclick e

	def onclick e
		dom:firstElementChild.setAttribute 'cx', e.x - dom.getBoundingClientRect:x
		dom:firstElementChild:cx:baseVal.convertToSpecifiedUnits 2
		let color = colord('rgb( 255, 0, 0 )').hue dom:firstElementChild:cx:baseVal:valueInSpecifiedUnits * 3.6
		dom:firstElementChild.setAttribute 'fill', color.toRgbString
		trigger 'input', color.hue

	def render
		<self
			:mouseleave.endMoveCircle
			:touchleave.endMoveCircle
			:mousemove.moveChoiceColor
			:touchmove.moveChoiceColor> <svg:circle
				:tap.stop
				:touchstart.stop.startMoveCircle
				:mousedown.stop.startMoveCircle
				:touchend.endMoveCircle
				:mouseup.endMoveCircle >

export tag Widget

	@classes = ['color-hue']

	def setup
		flagIf 'is-apply', [].concat( @on_ ).filter( do|item| item and item[0] === 'apply' ):length > 0

	def setData value
		unless @color then @color = value isa Number ? colord( 'rgba(0,0,255,1)' ).hue( value ) : colord value
		self

	def value
		@color.toRgbString

	def changeColorHue e
		@color = colord
			h: Number e.target.value
			s: 100
			v: 100
			a: 1
		trigger 'choice', @color.toRgbString

	def applyColorHue
		trigger 'apply', @color.toRgbString

	def hueColor
		Number !!@color and @color.hue

	def render
		<self>
			<label>
				<i> <svg:svg> <svg:use href="{ WidgetIcons }#HUE-settings">
				<input type="number" min=0 max=360 step=1 placeholder='0' required=true pattern=RegExp.new( '^[0-9]+$' ) value=hueColor :input.changeColorHue>
				<u> "°"
			<button :tap.applyColorHue> "Apply"
			<div> <ColorHueSelect[ hueColor ] :input.changeColorHue>