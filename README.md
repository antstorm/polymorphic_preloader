# PolymorphicPreloader

This gem does exactly what it says — it preloads nested polymorphic associations on ActiveRecord objects.

Here's a common example:

```ruby
class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :purchase, polymorphic: true
end

class Product < ActiveRecord::Base
  has_many :transactions, as: :purchase
  belongs_to :company
end

class Service < ActiveRecord::Base
  has_many :transactions, as: :purchase
  belongs_to :provider
end
```

Suppose we want to show all the products and services that user has purchased. Apparently we want to eager-load `products` with `companies` and `services` with `providers`.
ActiveRecord won't allow you to do `includes(purchase: [ :company, :provider ])`. Here's where PolymorphicPreloader comes to help.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'polymorphic_preloader'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install polymorphic_preloader

## Usage

Considering the above example:

```ruby
transactions = current_user.transactions.includes(:purchase)

PolymorphicPreloader.new(transactions, :purchase).preload!(product: :company, service: :provider)
```

## TODO

- Test with a dummy rails app (?)
- Hook into ActiveRecord for a delayed preloading and nicer interface (e.g. `includes_polymorphic()`)
