class String
  def as_date
    return nil unless self.length == 10
    begin
      Date.parse(self)
    rescue
      nil
    end
  end
end