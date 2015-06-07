module Modelable
  def to_s
    id
  end

  def to_model
    self
  end

  def persisted?
    true
  end
end