extends Resource
class_name Item

export var name : String
export var stack : bool = false
export var max_stack_size : int = 1

export (Resource) var Placeable
export var texture : Texture

export var amount = 1
export (Array, Resource) var recipe
