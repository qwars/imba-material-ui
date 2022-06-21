
import './index.styl'

const rem = parseFloat window:getComputedStyle(document:documentElement):fontSize

const ChangeElementPosition = do|el|
	const rect = el.querySelector('summary').dom.getBoundingClientRect.toJSON
	Array.from el.querySelectorAll('summary + *'), do|layer|
		const bounding = layer.dom.getBoundingClientRect.toJSON
		const transitionX = rect:x + bounding:width - window:innerWidth
		const transitionY = rect:y + rect:height + bounding:height - window:innerHeight
		layer.dom:style:top = "{ rect:y  }px"
		layer.dom:style:left = "{ rect:x }px"
		layer.dom:style:transform = "translateX(-{ Number transitionX > 0 and transitionX  }px) translateY({ Number transitionY > 0 ? -bounding:height : rect:height }px) translateY({ transitionY > 0 ? '-.5' : '.5'  }rem) "
		layer.dom:style:opacity = 1
		layer.dom:style:zIndex = 1000

const HideAllDetails = do|e| Array.from Imba.root.querySelectorAll( 'details.details-tooltype' ), do|item|
	unless item.dom.contains e:target then item.dom:open = !Array.from item.querySelectorAll('summary + *'), do|layer| layer.dom:style = 'opacity: 0'
	else setTimeout(&) do ChangeElementPosition item if item.dom:open

Imba.root.dom.addEventListener 'click', HideAllDetails
Imba.root.dom.addEventListener 'touch', HideAllDetails
window.addEventListener 'scroll', do|e| Array.from Imba.root.querySelectorAll( 'details.details-tooltype[open]' ), ChangeElementPosition
window.addEventListener 'resize', do|e| Array.from Imba.root.querySelectorAll( 'details.details-tooltype[open]' ), ChangeElementPosition

export tag Sketch < details

	@classes = ['details-tooltype']