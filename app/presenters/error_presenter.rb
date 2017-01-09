class ErrorPresenter
  def initialize(object)
    @object = object
  end

  def as_json(*)
    @object.errors.to_hash.each_with_object([]) do |(id, titles), array|
      titles.each do |title|
        array << { id: id, title: title }
      end
    end
  end
end
