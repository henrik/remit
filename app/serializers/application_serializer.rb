class ApplicationSerializer < ActiveModel::Serializer
  self.root = false

  private

  # https://github.com/rails-api/active_model_serializers/issues/398
  def attributes
    super.map { |k, v| [ k.to_s.camelize(:lower).to_sym, v ] }.to_h
  end
end
