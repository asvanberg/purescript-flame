---
layout: default
title: Defining views
permalink: /views
---

## Defining views

In the application record
```haskell
{
        init :: model,
        view :: model -> Html message,
        update :: model -> message -> model,
        inputs :: Array Signal
}
```
the `view` field maps the current state to markup. Whenever the model is updated, flame will patch the DOM by calling `view` with the new state.

A custom DSL, defined by the type `Html`, is used to write markup. You will probably want to qualify imports as such
```haskell
import Flame.HTML.Element as HE
import Flame.HTML.Attribute as HA
```
using the prefix HE for HTML elements and HA for HTML attributes, properties and events.

### Attributes, properties and events

The module `Flame.HTML.Attribute` exports

* Attributes, which are functions from string values such as `id` or `type'`, or helpers such as `class'` or `style`

* Properties, which are presential attributes such as `disabled` or `checked` expecting boolean parameters

* Events, such as `onClick` or `onInput`, expecting a `message` type constructor

See the [API reference](https://pursuit.purescript.org/packages/purescript-flame) for a complete list of attributes. In the case you need to define your own attributes, Flame provides the combinators

```haskell
HA.createAttibute

HA.createEvent
HA.createRawEvent

HA.createProperty
```

### Elements

The module `Flame.HTML.Element` exports HTML elements, such as `div`, `body`, etc, following the convention

* Functions named `element` expects attributes and children elements

```haskell
HE.div [HA.id "my-div"] [HE.text "text content"] --renders <div id="my-div">text content</div>
```

* Functions named `element_` (trailing underscore) expects children elements but no attributes

```haskell
HE.div_ [HE.text "text content"] --renders <div>text content</div>
```

* Functions named `element'` (trailing quote) expects attributes but no children elements

```haskell
HE.div' [HA.id "my-div"] --renders <div>text content</div>
```

(a few elements that usually have no children like br or input have `element` behave as `element'`)

Attributes and children elements are passed as arrays

```haskell
HE.div [HA.id "my-div", HA.disabled False, HA.title "div tite"] [
        HE.span' [HA.id "special-span"],
        HE.br,
        HE.span_ [HA.id "regular-span"] [HE.text "I am regular"],
]
{- renders
<div id="my-div" title="div title">
        <span id="special-span"></span>
        <br>
        <span id="regular-span">I am regular</span>
</div>
-}
```

But for some common cases, the markup DSL also defines convenience type classes so we can write

* `HE.element "my-element" _` instead of `HE.element [HA.id "my-element"] _` to declare an element with an id attribute

* `HE.element _ "text content"` instead of `HE.element _ [HE.text "text content"]` to declare elements with text as children

* `HE.element (HA.attribute _) _` instead of `HE.element [HA.attribute _] _` to declare elements with a single attribute

* `HE.element _ $ HE.element _ _` instead of `HE.element _ [HE.Element _ _]` to declare elements with a single child element

See the [API reference](https://pursuit.purescript.org/packages/purescript-flame) for a complete list of elements. In the case you need to define your own elements, Flame provides a few combinators
```haskell
HE.createElement
HE.createElement_
HE.createElement'
HE.createEmptyElement
```

### View logic

A `view` is just a regular PureScript function, meaning we can compose it, pass it around as any other value. We will talk again more about "components" in the next section, [Handling events](events),

<a href="/concepts" class="direction previous">Previous: Main concepts</a>
<a href="/events" class="direction">Next: Handling events</a>