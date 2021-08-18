class GiftsController < ApplicationController
    def new
        @gift = Gift.new
    end

    def create
        @gift = Gift.new(gift_params)
        @answer = Answer.find params[:answer_id]
        @question = @answer.question
        @gift.sender = current_user
        @gift.status = "pending"
        # @gift.security_key = "this is security key"
        @gift.security_key = SecureRandom.hex(20)
        @gift.receiver = @answer.user
        @gift.answer = @answer

        if @gift.save
            shared_path = "http://localhost:3000/answers/#{@answer.id}/gifts/complete?gift_id=#{@gift.id}&security_key=#{@gift.security_key}"
            session = Stripe::Checkout::Session.create({
                # success_url: shared_path + '/success',
                success_url: shared_path + '&status=completed',
                # cancel_url: shared_path + '/cancel',
                cancel_url: shared_path + '&status=canceled',
                payment_method_types: ['card'],
                line_items: [{
                    amount: @gift.amount * 100,
                    currency: "cad",
                    name: "Gift for good answer",
                    quantity: 1,
                    images: [
                        'https://thebritishschoolofetiquette.com/wp-content/uploads/2018/12/Article-Size-Pictures7.jpg'
                    ]
                }],
                mode: "payment"
            })

            redirect_to session.url
            # puts session
            # flash[:notice] = "Gift was created"
            # redirect_to root_path
        else
            render :new
        end
    end

    def complete
        @gift = Gift.find params[:gift_id]
        @gift.status = params[:status]
        @gift.save
        if @gift.status == "completed"
            flash[:notice] = "Gift successfully given!"
        else
            flash[:alert] = "Gift not completed"
        end
        redirect_to root_path
    end

    private

    def gift_params
        params.require(:gift).permit(:amount)
    end
end