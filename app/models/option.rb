# An adaptor option, not backed by app's DB
class Option < Fitrender::Option
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include Modelable
  extend Adaptorable

  def self.all
    option_hashes = get 'options'
    option_hashes.inject([]) do |arr, option_hash|
      arr << self.from_hash(option_hash)
    end
  end

  def self.find(option_id)
    self.from_hash(get "options/#{option_id}")
  end

  def update(*args)
    args.each do |arg|
      self.value = arg['value'] if arg.has_key? 'value'
    end
    self.save
  end

  def save
    Option.patch "options/#{id}", value: value
  end

  def to_key
    return *self.id
  end
end