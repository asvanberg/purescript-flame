-- | Types common to Flame modules
module Flame.Types where

import Prelude

import Effect (Effect)
import Foreign.Object (Object)
import Signal (Signal)
import Web.DOM.Element as WDE
import Web.Event.Event (Event)

-- | Represents a list of events listeners
foreign import data VNodeEvents :: Type

-- | Data (properties, attributes, events) attached to a VNode
-- something missing here is the support for thunks
type VNodeData = {
        attrs :: Object String,
        on :: VNodeEvents
}

-- | Virtual DOM representation
newtype VNode = VNode
        { sel :: String
        , data :: VNodeData
        , children :: Array VNode
        , elm :: DOMElement
        }

-- App abstracts over common fields of an `Application`
type App model message extension = {
        view :: model -> Html message,
        inputs :: Array (Signal message)
        | extension
}

-- | A native HMLT element
type DOMElement = WDE.Element

-- | Type synonym for view functions
type Html = Element

type ToNodeData a = forall b. a -> NodeData b

type Tag = String

-- | Convenience wrapper around `VNode`
data Element message = Node Tag (Array (NodeData message)) (Array (Element message)) | Text String

derive instance elementFunctor :: Functor Element

-- | Convenience wrapper around `VNodeData`
--snabbom has support for style and class node data but I dont think it is worth it
data NodeData message = Attribute String String | Property String Boolean | Event String message | RawEvent String (Event -> Effect message)

derive instance nodeDataFunctor :: Functor NodeData
