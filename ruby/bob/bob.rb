class Bob
  class << self
    def hey(remark)
      remark = remark.strip
      if question?(remark) && shout?(remark)
        "Calm down, I know what I'm doing!"
      elsif question?(remark) && !shout?(remark)
        'Sure.'
      elsif shout?(remark)
        'Whoa, chill out!'
      elsif empty?(remark)
        'Fine. Be that way!'
      else
        'Whatever.'
      end
    end

    def question?(remark)
      remark[-1] == '?'
    end

    def shout?(remark)
      remark.scan(/[a-zA-Z]/).join.then do |letters|
        letters.length.positive? && letters == letters.upcase
      end
    end

    def empty?(remark)
      remark.empty? || remark.nil?
    end
  end
end
