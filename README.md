# imba-material-ui :: pagination-firebase

pagination-firebase - создает стрелки постраничного перехода относительно ссылки на коллекцию firestore

## Добавления виджетов в систему или для разработки

`git submodule add -b pagination-firebase git@github.com:qwars/imba-material-ui.git {/develop/widgets/path-branch}`

`git submodule update --init --recursive --remote` - забрать изменения


## Добавление кода

```

import Widget as Pagination from '{ path }/pagination-firebase'

... any tag ...



<Pagination[ collectionRef ]@pagination limit=paginationLimit :subscribe.clearSearchValue>


<ul> for item in @pagination.response
    <li> <ItemListArticle[item.data] route-to="/{params:collection}/{item:id}">


```

## Методы

@pagination.limit - Обновляет query запрос наблюдения изменений ( onSnapshot ) как firestor limit
@pagination.filters - Обновляет query запрос наблюдения изменений ( onSnapshot ) как firestor query
@pagination.explicitOrderBy - Обновляет query запрос наблюдения изменений ( onSnapshot ) как firestor orderBy

@pagination.response - содержимое ( onSnapshot )

@pagination.collection или data - запрос на получение данных как firestor query

:subscribe - Событие изменения содержимого страницы


