# imba-material-ui :: carousel-layers

carousel-layers - создает бесконечный список просмотра элементов

# Добавления виджетов в систему или для разработки

`git submodule add -b carousel-layers git@github.com:qwars/imba-material-ui.git {/develop/widgets/carousel-layers}`

`git submodule update --init --recursive` - забрать изменения

## Добавление кода

```

import Widget as CarouselLayers from '{ path }/carousel-layers'

... any tag ...



<CarouselLayers[ collectionRef ]@carousel>

<CarouselLayers[ collectionRef ]@carousel settings={ control: true } oncreate=(  do|e| console.log e) ondelete=( do|e| console.log e )  onmove=( do|e| console.log e )>


```

## Пропсы и Методы

`data` - массив тегов для отображения

`settings` - объект с настройками виджета

если `control` - `true` то события управления будут работать

`ondelete` - удаление элемента из массива ( кнопка )

`onmove` - изменение положения элемента в массиве ( долгое нажатие на элементе )

`oncreate` - запрос на создание нового элемента ( добавление пустого эемента в массив, как кнопка )

## `settings`

`dots` - показать точки

`arrows` - показать стрелки с событиями последовательного поелементного перехода

`control` - возможность упревление массивом удаления, добавление и перемещение объектов. Отображать элементы управления массивом 




