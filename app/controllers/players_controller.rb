class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]

  def index
    @players = Player.all
    respond_to do |format|
      format.html # Regular index page
      format.turbo_stream { render turbo_stream: turbo_stream.replace("new_player", partial: 'new_player_button') }
    end
  end

  def show
    respond_to do |format|
      format.html # Regular show page
      format.turbo_stream { render turbo_stream: turbo_stream.replace("player_#{@player.id}", partial: 'player_card', locals: { player: @player }) }
    end
  end

  def new
    @player = Player.new
    respond_to do |format|
      format.html # Regular new page
      format.turbo_stream { render turbo_stream: turbo_stream.replace("new_player", partial: 'new_form', locals: { player: @player }) }
    end
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      respond_to do |format|
        format.html { redirect_to @player, notice: 'Player was successfully created.' }
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend("players-grid", partial: 'player_card_wrapper', locals: { player: @player }),
            turbo_stream.replace("new_player", partial: 'new_player_button'),
            turbo_stream.replace("flash-messages", partial: 'shared/flash', locals: { notice: "#{@player.name} was successfully created." })
          ]
        end
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("new_player", partial: 'new_form', locals: { player: @player }), status: :unprocessable_entity }
      end
    end
  end

  def edit
    respond_to do |format|
      format.html # Regular edit page
      format.turbo_stream { render turbo_stream: turbo_stream.replace("player_#{@player.id}", partial: 'edit_form', locals: { player: @player }) }
    end
  end

  def update
    if @player.update(player_params)
      respond_to do |format|
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("player_#{@player.id}", partial: 'player_card', locals: { player: @player }),
            turbo_stream.replace("flash-messages", partial: 'shared/flash', locals: { notice: "#{@player.name} was successfully updated." })
          ]
        end
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("player_#{@player.id}", partial: 'edit_form', locals: { player: @player }), status: :unprocessable_entity }
      end
    end
  end

  def destroy
    player_name = @player.name
    @player.destroy
    respond_to do |format|
      format.html { redirect_to players_url, notice: 'Player was successfully deleted.' }
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.remove("player_#{@player.id}"),
          turbo_stream.replace("flash-messages", partial: 'shared/flash', locals: { notice: "#{player_name} was successfully deleted." })
        ]
      end
    end
  end

  private

  def set_player
    @player = Player.find(params[:id])
  end

  def player_params
    params.require(:player).permit(:name, :birthdate, :photo)
  end
end
