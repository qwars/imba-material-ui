
import Navigation as ContentsUINavigation, Article as ContentsUIArticle, Aside as ContentsUIAside from './UI-documens-examples/contents'
import Navigation as VariablesUINavigation, Article as VariablesUIArticle, Aside as VariablesUIAside from './UI-documens-examples/variables'
import Navigation as TagsUINavigation, Article as TagsUIArticle, Aside as TagsUIAside from './UI-documens-examples/tags'
import Navigation as WidgetsUINavigation, Article as WidgetsUIArticle, Aside as WidgetsUIAside from './UI-documens-examples/widgets'
import Navigation as IconsUINavigation, Article as IconsUIArticle, Aside as IconsUIAside from './UI-documens-examples/icons'
import Navigation as ClassesUINavigation, Article as ClassesUIArticle, Aside as ClassesUIAside from './UI-documens-examples/classes'

export const MediaPrefersColorScheme = do document:documentElement:dataset:theme === $1 or window.matchMedia( "(prefers-color-scheme: {$1})" ):matches

tag label < label
	def mount
		querySelector('input').css('text-indent', '2ex' ) if querySelector 'i'

tag MenuUI < menu
	def render
		<self>
			<abbr><kbd>
			<h2>
				<span route="/-ui/*$"> "Структура"
				<span route="/-ui/variables"> "Переменные"
				<span route="/-ui/tags"> "Тэги"
				<span route="/-ui/widgets"> "Виджеты"
				<span route="/-ui/icons"> "Иконки"
				<span route="/-ui/classes"> "Imba Classes"
			<aside>
				<a route-to="/-ui" .not-active=!router.location.path.match(/\/-ui\/*$/)> "Content"
				<a route-to="/-ui/variables"> "Variables"
				<a route-to="/-ui/tags"> "Tags"
				<a route-to="/-ui/widgets"> "Widgets"
				<a route-to="/-ui/icons"> "Icons"
				<a route-to="/-ui/classes"> "Classes"

tag MainUi < main
	def mount
		setTimeout
			do while dom:nextElementSibling and dom:nextElementSibling:childNodes:length === 0 then dom:nextElementSibling.remove
			167

	def render
		<self>
			<MenuUI>

			<ContentsUINavigation route="/-ui/*$">
			<VariablesUINavigation route="/-ui/variables">
			<TagsUINavigation route="/-ui/tags">
			<WidgetsUINavigation route="/-ui/widgets">
			<IconsUINavigation route="/-ui/icons">
			<ClassesUINavigation route="/-ui/classes">

			<ContentsUIArticle route="/-ui/*$">
			<VariablesUIArticle route="/-ui/variables">
			<TagsUIArticle route="/-ui/tags">
			<WidgetsUIArticle route="/-ui/widgets">
			<IconsUIArticle route="/-ui/icons">
			<ClassesUIArticle route="/-ui/classes">

			<ContentsUIAside route="/-ui/*$">
			<VariablesUIAside route="/-ui/variables">
			<TagsUIAside route="/-ui/tags">
			<WidgetsUIAside route="/-ui/widgets">
			<IconsUIAside route="/-ui/icons">
			<ClassesUIAside route="/-ui/classes">


export tag TogglePrefersColorScheme < kbd
	@classes = []

	def setup
		@timeout
		let gotoui = do window:location:href = '/-ui'
		let open-ui-page = do @timeout = setTimeout gotoui, 3000
		let close-ui-page = do @timeout = clearTimeout @timeout
		if process:env:NODE_ENV === 'development'
			dom.addEventListener 'mousedown',  open-ui-page
			dom.addEventListener 'touchstart',  open-ui-page
			dom.addEventListener 'mouseup',  close-ui-page
			dom.addEventListener 'touchend',  close-ui-page
	def mount
		Imba.mount <MainUi> if window:location:pathname.includes '-ui'

	def toggleScheme e
		document:documentElement:dataset:theme = document:documentElement:dataset:theme === 'dark' ? 'light' : 'dark' unless @timeout

	def render
		<self :tap.toggleScheme>
