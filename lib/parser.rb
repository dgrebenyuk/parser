require "parser/version"

module Parser
  PATTERN = %r{(\w+(?=\.))?\.?(\w+(?=\[\d\]))?(\[\d\])?(\w+)?=(.*)}

  def self.proceed(str)
    Hash.new.tap do |result|
      str.split("\n").each do |el|
        el.gsub(PATTERN) do
          result[$1] ||= {} if $1
          if $2
            result[$1][$2] ||= []
            result[$1][$2] << value_formatter($5)
          elsif $1
            result[$1][$4] = value_formatter($5)
          else
            result[$4] = value_formatter($5)
          end
        end
      end
    end
  end

  private

  def self.value_formatter(value)
    if value =~ %r{^\d+$}
      return value.to_i
    elsif value == 'false'
      return false
    elsif value == 'true'
      return true
    else
      return value
    end
  end
end
