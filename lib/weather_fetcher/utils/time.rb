class Time
  # Create Time from YYYY-MM-DD HH:mm A/PM string format
  #
  # :call-seq:
  #   Time.create_time_from_string( String date, String time ) => Time
  def self.create_time_from_string_12_utc(date, time)
    if date.nil?
      y = Time.now.year
      m = Time.now.month
      d = Time.now.day
    else
      date =~ /(\d{4})-(\d{1,2})-(\d{1,2})/
      y = $1.to_i
      mo = $2.to_i
      d = $3.to_i
    end

    # hour
    time =~ /(\d{1,2}):(\d{1,2}) ([PM])M/
    h = $1.to_i
    m = $2.to_i

    if $3 == "P"
      h_plus = 12
    else
      h_plus = 0
    end
    h += h_plus
    h = h % 24

    return Time.utc(y, mo, d, h, m).localtime

  end

  # Create Time from YYYY-MM-DD HH:mm string format
  #
  # :call-seq:
  #   Time.create_time_from_string( String date, String time ) => Time
  def self.create_time_from_string(date, time)
    date =~ /(\d{4})-(\d{1,2})-(\d{1,2})/
    y = $1.to_i
    m = $2.to_i
    d = $3.to_i

    if time =~ /(\d{1,2}):(\d{1,2})/
      h = $1.to_i
      min = $2.to_i
    else
      h = 0
      min = 0
    end

    return Time.mktime(y, m, d, h, min, 0, 0)
  end
end