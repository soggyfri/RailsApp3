class ChatController < ApplicationController

  def send(one, two)
		#debugger
		@msg  = params[:msg_body]
		@sender = params[:sender]

		Juggernaut.publish( "/chat/test", parse_chat_msg(@msg,@sender) )

		respond_to do |format|
			format.js
		end 
  end

	def parse_chat_msg(msg,sender)
		return "#{sender}: #{msg}"
	end

end
