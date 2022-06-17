# imba-material-ui :: colors-collection

Templates, UI css, snippets, generators css, imba support. Site for ui styles info. 

## Install

`yarn add colord`

`git submodule add -b colors-collection git@github.com:qwars/template-ui-kid.git {path-widgets-folder/colors-collection}`

`git submodule update --init --recursive --remote` - забрать изменения

## Props
    

## Import

```
import Widget as ColorsCollection from './path-widgets-folder/colors-collection'

... any tag ...

def inputStateColor e
    e.value
    e.collection

def render
    <self>
    
        .... any ... 
        
        <ColorsCollection[ data ] :input.inputStateColor>

```
