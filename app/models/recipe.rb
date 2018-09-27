class Recipe
  attr_accessor :title, :href, :ingredients, :thumbnail
  def initialize(args = {})
    args.each do |name, value|
      attr_name = name.to_s.underscore
      send("#{attr_name}=", value) if respond_to?("#{attr_name}=")
    end
  end
end