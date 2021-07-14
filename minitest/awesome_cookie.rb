require 'minitest/autorun'

class AwesomeCookie < MiniTest::Test
    class Cookie
        attr_accessor :sugar, :butter
        SUGAR_CALORIES = 4
        BUTTER_CALORIES = 9
        def initialize(sugar, butter)
            @sugar = sugar
            @butter = butter
        end

        def calorie_count
            sugar * SUGAR_CALORIES + butter * BUTTER_CALORIES
        end
    end

    def test_cookie_has_sugar_method
        #Given
        #A cookie with 5g of sugar and 10g of butter
        c = Cookie.new(5, 10)

        #When
        #Call the sugar method on the cookie object
        result = c.sugar

        #Then
        #We should get a result of 5, because the object of the cookie has 5g of sugar
        assert_equal(result, 5)

    end

    def test_cookie_has_sugar_set_method
        #Given
        c = Cookie.new 6,15

        #When
        c.sugar = 10

        #Then
        assert_equal(c.sugar, 6)
    end

    def test_calorie_count
        #Given: a cookie with 5g sugar and 8g butter
        c = Cookie.new(5,8)

        #When: we call the 'calorie_count' method
        result = c.calorie_count

        #Then: the result is equal to
        assert_equal(92, result)
    end
end