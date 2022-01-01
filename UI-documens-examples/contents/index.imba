
import './index.styl'

const ContentSVG = require './contents.svg'

export tag Aside < aside
	def render
		<self>

export tag Navigation < nav
	def render
		<self>


export tag Article < article
	def render
		<self>
			<svg:svg.ContentSVG>
				# TODO: FF не принимает значения типа calc и rem
				<svg:use href="{ ContentSVG }#rect-content" height="3rem">
				<svg:use href="{ ContentSVG }#rect-content" y="4rem" height="3rem">
				<svg:use href="{ ContentSVG }#rect-content" y="8rem" height="calc( 100% - 12rem )" width="13rem">
				<svg:use href="{ ContentSVG }#rect-content" y="8rem" x="14rem" height="calc( 100% - 12rem )" width="calc(100% - 28rem)">
				<svg:use href="{ ContentSVG }#rect-content" y="8rem" x="calc(100% - 13rem)" height="calc( 100% - 12rem )" width="13rem">
				<svg:use href="{ ContentSVG }#rect-content" y="calc(100% - 3rem)" height="3rem">
