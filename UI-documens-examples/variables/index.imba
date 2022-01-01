import './index.styl'

const VariablesCSS = [
	"--font-text"
	"--font-title"
	"--font-extra"
	"--font-mono"

	"--canvas-color"
	"--border-color"

	"--title-color"
	"--text-color"
	"--extra-color"

	"--link-color"
	"--active-color"
	"--hover-color"
	"--visited-color"

	"--focus-color"
	"--checked-color"
	"--placeholder-color"
	"--disabled-color"
	"--select-color"

	"--invalid-color"
	"--info-color"
	"--warning-color"
]

export tag Aside < aside
	def render
		<self>

export tag Navigation < nav
	def render
		<self>


export tag Article < article

	@classes = ['variables-css-state']

	def build
		let VarCSSBody = window.getComputedStyle document:body
		@variables = Map.new VariablesCSS.map do [ $1, VarCSSBody.getPropertyValue $1 ]

	def render
		<self>
			<section>
				<h3> "Color Main"
				<ul> for item in VariablesCSS.slice 4, 6
					<li> item
			<section>
				<h3> "Color Fonts & Text"
				<ul> for item in VariablesCSS.slice 6, 9
					<li> item
				<ul> for item in VariablesCSS.slice 0, 4
					<li> item
			<section>
				<h3> "Color Links & Button"
				<ul> for item in VariablesCSS.slice 9, 13
					<li> item
			<section>
				<h3> "Color Inputs"
				<ul> for item in VariablesCSS.slice 13, 18
					<li> item
			<section>
				<h3> "Color Messages"
				<ul> for item in VariablesCSS.slice 18
					<li> item
			<aside css:border="1px solid var(--border-color)">
				<ul>
					<li css:font="var(--font-text)" css:border="1px solid var(--border-color)"> "Text"
					<li css:font="var(--font-title)" css:border="1px solid var(--border-color)"> "Title"
					<li css:font="var(--font-extra)" css:border="1px solid var(--border-color)"> "Extra"
					<li css:font="var(--font-mono)" css:border="1px solid var(--border-color)"> "Mono"
				<ul> for item in VariablesCSS.slice 9, 13
					<li css:border="1px solid var(--border-color)" css:backgroundColor="var({item})"> item
				<ul> for item in VariablesCSS.slice 13, 18
					<li css:border="1px solid var(--border-color)" css:backgroundColor="var({item})"> item
				<ul> for item in VariablesCSS.slice 18
					<li css:border="1px solid var(--border-color)" css:backgroundColor="var({item})"> item
				<section>