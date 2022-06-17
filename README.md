# imba-material-ui :: colors-hue

Choice HUE color

## Install

`git submodule add -b colors-hue git@github.com:qwars/imba-material-ui.git {patch-widgets-folder/colors-hue}`

`yarn add colord`

## Triggers
    If exists event ':apply' then view button
    

## Import

```
import Widget as ColorsHue from './path-widgets-folder/colors-hue'

... any tag ...

def changeColorAsRGB e
    console.log e.data # RGB color as String
    console.log e.target.value # RGB color as String

def inputHUE e
    console.log e.target.value # HUE color as Number

def render
    <self>
    
        .... any ... 
        
        <ColorsHue[ color-hue-number or color ] :choice.changeColorAsRGB :input.inputHUE :apply.changeColorAsRGB>

```
