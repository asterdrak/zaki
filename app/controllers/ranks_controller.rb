# frozen_string_literal: true
class RanksController < ApplicationController
  # POST /ranks
  # POST /ranks.json
  def create
    @rank = @committee.ranks.new(rank_params)

    respond_to do |format|
      if @rank.save
        format.html { redirect_to [:edit, @committee], notice: t(:rank_successfully_created) }
        format.json { render :show, status: :created, location: @rank }
      else
        format.html do
          redirect_to [:edit, @committee], alert: @rank.errors.full_messages.to_sentence
        end
        format.json { render json: @rank.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ranks/1
  # DELETE /ranks/1.json
  def destroy
    @committee.ranks.find(params[:id]).destroy

    respond_to do |format|
      format.html { redirect_to [:edit, @committee], notice: t(:rank_successfully_destroyed) }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def rank_params
    params.require(:rank).permit(:name)
  end
end
