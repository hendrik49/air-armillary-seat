module SeatService
  class Get

    SEAT_TYPE = %w(middle aisle window)

    def initialize(layout, total_passengers)
      @layout = layout
      @total_passengers = total_passengers
      @total_seat_type = {}.with_indifferent_access
      SEAT_TYPE.each { |seat_type| @total_seat_type[seat_type] = 0 }
    end

    def call
      validate_params

      create_result_layout
      set_type_of_the_seats
      set_number_of_the_seats
      @result
    end

    private

    def validate_params
      raise Services::BadParameterError.new unless valid_layout? && valid_total_passengers?
    end

    def valid_layout?
      @layout.kind_of?(Array) && @layout.all? { |block| valid_block?(block) }
    end

    def valid_block?(block)
      block.kind_of?(Array) && block.length == 2 && block.all? { |v| valid_size?(v) }
    end

    def valid_size?(value)
      value.is_a?(Integer) && value > 0
    end

    def valid_total_passengers?
      @total_passengers.is_a?(Integer) && @total_passengers >= 0
    end

    def create_result_layout
      @result = @layout.map { |block| Array.new(block[0]){ Array.new(block[1]){ Hash.new.with_indifferent_access }}}
    end

    def set_type_of_the_seats
      iterate_all_seats do |i, j, k|
        seat_type = get_type_of_the_seat(i, j, k)
        add_total_seat_type(seat_type)
        @result[i][j][k][:type] = seat_type
      end
    end

    # left to right
    # front to back
    # 1 2 3
    # 4 5 6
    # return (i j k)
    def iterate_all_seats
      j = 0
      max_j = 0
      while j <= max_j do
        (0..(@result.length-1)).each do |i| # each block
          max_j = [max_j, @result[i].length].max
          (0..(@result[i][0].length-1)).each do |k| # each column
            next if j >= @result[i].length
            yield i, j, k
          end
        end
        j += 1
      end
    end


    def add_total_seat_type(seat_type)
      @total_seat_type[seat_type] += 1
    end

    def get_type_of_the_seat(i, j, k)
      return SEAT_TYPE[2] if seat_is_window?(i, j, k)
      return SEAT_TYPE[1] if seat_is_aisle?(i, j, k)
      return SEAT_TYPE[0]
    end

    def seat_is_aisle?(i, j, k)
      k == 0 || k == @result[i][j].length - 1
    end

    def seat_is_window?(i, j, k)
      seat_on_the_far_left?(i, j, k) || seat_on_the_far_right?(i, j, k)
    end

    def seat_on_the_far_left?(i, j, k)
      i == 0 && k == 0
    end

    def seat_on_the_far_right?(i, j, k)
      i == @result.length - 1 && k == @result[i][j].length - 1
    end

    def set_number_of_the_seats
      initialize_counter_seat_type
      iterate_all_seats do |i, j, k|
        seat_type = @result[i][j][k][:type]
        @result[i][j][k][:number] = @counter[seat_type] if @counter[seat_type] <= @total_passengers
        @counter[seat_type] += 1
      end
    end

    def initialize_counter_seat_type
      @counter = {
        aisle: 1,
        window: 1 + @total_seat_type[:aisle],
        middle: 1 + @total_seat_type[:aisle] + @total_seat_type[:window],
      }.with_indifferent_access
    end
  end
end
