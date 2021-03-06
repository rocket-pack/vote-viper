class ElectionsController < ApplicationController
  def show
    @responder = current_responder
    @election = @responder.election
    @votes = @election.questions.map{|q| @responder.votes.where(question_id: q.id).first_or_initialize}
  end


  private

  def current_responder
    key = params[:key] || session[:responder_key]
    session[:responder_key] = key
    Responder.where(private_key: key).first if key.present?
  end

end
