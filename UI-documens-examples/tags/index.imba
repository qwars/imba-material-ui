import './index.styl'

const ContentSVG = require '../contents/contents.svg'

export tag Aside < aside
	def render
		<self>

export tag Navigation < nav
	def render
		<self>


export tag Article < article
	@classes = ['tags-css-state']
	def render
		<self>
			<section>
				<h3 route-to="#forms"> "Формы"
				<h3 route-to="#headers"> "Элементы для заголовков"
				<ul> for item, idx in Array(6).fill 'H'
					<li> "<{ item }{ idx + 1 }>"
				<h3 route-to="#text"> "Элементы для форматирования текста"
				<ul> for item in ['b', 'em', 'i', 'small', 'strong', 'sub', 'sup', 'ins', 'del', 'mark']
					<li> "<{ item.toUpperCase }>"
				<h3 route-to="#elements"> "Элементы для ввода «компьютерного» текста"
				<ul> for item in ['code', 'kbd', 'samp', 'var', 'pre']
					<li> "<{ item.toUpperCase }>"
				<h3 route-to="#cite"> "Элементы для оформления цитат и определений"
				<ul> for item in ['abbr', 'bdo', 'blockquote', 'q', 'cite', 'dfn']
					<li> "<{ item.toUpperCase }>"
				<h3 route-to="#paragraph"> "Абзацы, средства переноса текста"
				<ul> for item in ['p', 'hr']
					<li> "<{ item.toUpperCase }>"
				<h3 route-to="#links"> "Ссылки"
				<ul> <li> "<A>"
				<h3 route-to="#tables"> "Таблицы"
				<ul>
				<h3 route-to="#lists"> "Списки"
				<ul>
					<li> "маркированный список"
					<li> "нумерованный список"
					<li> "список определений"
			<aside>
				<section route="#forms">
					<fieldset>
						<legend> <svg:svg height="1rem">
							<svg:use href="{ ContentSVG }#rect-content" height="1rem" >
						<legend> <svg:svg height="1rem" >
							<svg:use href="{ ContentSVG }#rect-content" height="1rem">
						<svg:svg height="30rem" > <svg:use href="{ ContentSVG }#rect-content" >
					<p> "Input full state tags CSS ( <LEGEND>, <DFN>, <INS>, <I>, <DEL> ) and icon as 'css:backgroundImage' SVG url '?horizontal=left|right' ( default: left )"
					<label>
						<input type="email" required=true placeholder="placeholder">
						<legend> "legend"
						<dfn> "dfn"
						<ins>
						<del>
						<i> <svg:svg> <svg:use href="{ContentSVG}#logo-qwars">

					<label>
						<textarea placeholder="textarea">
						<legend> "legend"
						<dfn> "dfn"
						<ins>
						<del>


					<label>
						<input type="text" placeholder="type text">

					<label>
						<input type="email" required=true placeholder="type email">

					<label>
						<input type="url" placeholder="type url">
					<label>
						<input type="file" placeholder="type file">
						<span> "Input type file and + Any tag Text not  <LEGEND>, <DFN>, <INS>, <DEL>"
					<label>
						<input type="number" placeholder="type number">
					<label>
						<input type="range" placeholder="type range">
					<label>
						<input type="color" placeholder="type color">
					<label>
						<input type="checkbox" placeholder="type checkbox">
						<legend> "legend"
					<section>
						<label>
							<input type="button" value=''>
							<legend> "legend button"
						<button>
							<i> <svg:svg> <svg:use href="{ContentSVG}#logo-qwars">
							"button icon"
						<button> "default or disabled button"
						<button.active> "active or valid button"
						<button.invalid> "error or invalid button"
						<button.warning> "warning button"
					<label>
						<input type="radio">
						<legend> "legend"
					<label>
						<input type="datetime-local" placeholder="type datetime-local">
					<label>
						<input type="date">
					<label>
						<input type="month">
					<label>
						<input type="week">
					<label>
						<input type="password" placeholder="type password">

				<section route="#headers">
					<section>
						<svg:svg.ContentSVG height="7rem">
							<svg:use href="{ ContentSVG }#rect-content" width="3rem" height="3rem">
							<svg:use href="{ ContentSVG }#rect-content" x="4rem" width="13rem" height="3rem">
							<svg:use href="{ ContentSVG }#rect-content" x="calc( 100% - 3rem )" width="3rem" height="3rem">
							<svg:use href="{ ContentSVG }#rect-content" y="4rem"  height="3rem">
					<h1>
						<abbr> "icon or text - any tag"
						<span> "text - any tag"
						<dfn> "defehition - <DFN>"
						<aside> "aside - <ASIDE>"
					<h2>
						"text - any tag or text"
						<dfn> "defehition - <DFN>"
						<aside> "aside - <ASIDE>"
					<h3>
						"text - any tag or text"
						<dfn> "defehition - <DFN>"
					<h4>
						"text - any tag or text"
						<aside> "aside - <ASIDE>"
