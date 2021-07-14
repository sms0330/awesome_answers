require 'minitest/autorun'

class Rectangle
    attr_accessor :width, :height

    def initialize(width, height)
        @width = width
        @height = height
    end

    def perimeter
        @width * 2 + @height * 2
    end

    def area
        width * height
    end

    def is_square?
        @width == @height
    end
end

describe Rectangle do
    describe ".area" do
        it "return the calculated area of the ractangle" do
            #Given
            rect = Rectangle.new(4,5)

            #When
            area = rect.area

            #Then
            _(area).must_equal(20)

            # (area).must_equal 20         # bad
            # assert_equal area, 20        # good
            # _(area).must_equal 20      # good
            # value(area).must_equal 20  # good, also #expect
        end
    end

    describe ".perimeter" do
        it "returns the calculated perimeter of the rectangle" do
            #given
            rect = Rectangle.new(4,5)
            #when
            perm = rect.perimeter
            #then
            _(perm).must_equal(18)
        end
    end

    describe ".is_square?" do
        it "returns true if the rectangle is a square" do
            #given and #when given
            rect = Rectangle.new(4,4)
            #then
            _(rect.is_square?).must_equal(true)

        end
    end
end
