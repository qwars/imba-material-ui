
import Navigation as ContentsUINavigation, Article as ContentsUIArticle, Aside as ContentsUIAside from './UI-documens-examples/contents'
import Navigation as VariablesUINavigation, Article as VariablesUIArticle, Aside as VariablesUIAside from './UI-documens-examples/variables'
import Navigation as TagsUINavigation, Article as TagsUIArticle, Aside as TagsUIAside from './UI-documens-examples/tags'
import Navigation as WidgetsUINavigation, Article as WidgetsUIArticle, Aside as WidgetsUIAside from './UI-documens-examples/widgets'
import Navigation as IconsUINavigation, Article as IconsUIArticle, Aside as IconsUIAside from './UI-documens-examples/icons'
import Navigation as ClassesUINavigation, Article as ClassesUIArticle, Aside as ClassesUIAside from './UI-documens-examples/classes'

export const MediaPrefersColorScheme = do document:documentElement:dataset:theme === $1 or window.matchMedia( "(prefers-color-scheme: {$1})" ):matches

tag label < label
	def mount
		const inpt = querySelector 'input'
		inpt.css('text-indent', '2ex' ) if querySelector 'i'
		if querySelector 'var + input'
			const invar = querySelector 'var'
			const callback = do
				console.log invar.dom:offsetWidth
				inpt.css 'padding-right', "calc( {invar.dom:offsetWidth}px + 1ex )"
			const observer = MutationObserver.new callback
			observer.observe invar.dom,
				childList: true
				subtree: true
			setTimeout callback, 168
			callback()

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

	def render
		<self>
			<MenuUI route="/-ui">

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

	def toggleScheme e
		document:documentElement:dataset:theme = document:documentElement:dataset:theme === 'dark' ? 'light' : 'dark'

	def render
		<self :tap.toggleScheme>
