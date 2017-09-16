class Helper
  def self.downcase(hash)
    array = []
    hash.each_pair do |pair|
      array << pair.map(&:to_s).map!(&:downcase)
    end
    array.to_h
  end

end
