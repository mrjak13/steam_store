class SteamStore::Game
  extend SteamStore::Findable
  attr_accessor :name, :url, :summary, :release_date, :developer, :category, :price, :sale, :game_type

  @@all = []

  def initialize(hash)
    hash.each do |k, v|
      self.send("#{k}=", v)
    end
    SteamStore::Category.find_by_name(category.first.name).games << self
    @@all << self
  end

  def self.create_from_hash(hash)
    if hash[:name] != ""
      self.new(hash)
    end
  end

  def add_info(hash)
    hash.each do |k, v|
      self.send("#{k}=", v)
    end
  end

  def self.all
    @@all
  end

  def self.find_by_game_category(input)
    array = []
    all.each do |game|
      game.category.each do |cat_name|
        if cat_name.name == input
          array << game
        end
      end
    end
    array
  end

end
