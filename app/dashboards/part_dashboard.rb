require "administrate/base_dashboard"

class PartDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    attribute_name: Field::Text,
    description: Field::Text,
    height: Field::Number.with_options(decimals: 2),
    item_part_number: Field::String,
    length: Field::Number.with_options(decimals: 2),
    name: Field::String,
    order_items: Field::HasMany,
    orders: Field::HasMany,
    package_level_gtin: Field::Number,
    part_number: Field::String,
    price: Field::Number.with_options(decimals: 2),
    product_attribute: Field::Text,
    shipping_height: Field::Number.with_options(decimals: 2),
    shipping_length: Field::Number.with_options(decimals: 2),
    shipping_width: Field::Number.with_options(decimals: 2),
    weight: Field::Number.with_options(decimals: 2),
    width: Field::Number.with_options(decimals: 2),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    attribute_name
    description
    height
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    attribute_name
    description
    height
    item_part_number
    length
    name
    order_items
    orders
    package_level_gtin
    part_number
    price
    product_attribute
    shipping_height
    shipping_length
    shipping_width
    weight
    width
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    attribute_name
    description
    height
    item_part_number
    length
    name
    order_items
    orders
    package_level_gtin
    part_number
    price
    product_attribute
    shipping_height
    shipping_length
    shipping_width
    weight
    width
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how parts are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(part)
  #   "Part ##{part.id}"
  # end
end
