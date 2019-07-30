require 'faker'

PRODUCTS_COUNT = 100

MAX_CATEGORIES = 3

MAX_VARIANTS = 4
VARIANTS_WEIGHT = 0.53

CATEGORIES = Faker::Base.fetch_all('commerce.department').map do |title|
  Category.find_or_create_by!(title: title)
end

PRODUCTS_COUNT.times do

  title = ''

  # generate unique title
  loop do
    title = Faker::Commerce.product_name
    break unless Product.exists?(title: title)
  end

  product = Product.new(
    title: title,
    price: Faker::Commerce.price
  )

  num_categories = 1 + rand(MAX_CATEGORIES)
  product.categories = CATEGORIES.sample(num_categories)

  if rand > VARIANTS_WEIGHT
    num_variants = 1 + rand(MAX_VARIANTS)
    num_variants.times do
      product.variants.build(
        title: rand > VARIANTS_WEIGHT ? Faker::Commerce.color : Faker::Commerce.material,
        price: Faker::Commerce.price
      )
    end
  end

  product.save!

end
